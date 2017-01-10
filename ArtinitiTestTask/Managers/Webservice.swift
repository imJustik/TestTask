import UIKit
import Unbox
import Alamofire

typealias JSONDictionary = [String: Any]


struct Resource<A> {
    let request : URLRequestConvertible
    let parse : (Data) -> A?
}

extension Resource {
    init(request: URLRequestConvertible, parseJSON: @escaping (Any) -> A?) {
        self.request = request
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}


final class Webservice {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
        Alamofire.request(resource.request).responseData { (data) in
            completion(data.data.flatMap(resource.parse))
        }
    }
}

extension Ticket {
    static func all() -> Resource<[Ticket]> {
        return Resource(request: WebserviceRouter.LoadTickets(), parseJSON: { result in
            guard let array = result as? [UnboxableDictionary] else {return nil}
            do {
                let tickets : [Ticket] = try unbox(dictionaries: array)
                return tickets
            } catch {
                return nil
            }
        })
    }
}

extension TicketDetails {
    static func details (requestID : String) -> Resource<TicketDetails> {
        return Resource(request: WebserviceRouter.LoadTicketDetails(requestID), parseJSON: {result in
            guard let json = result as? UnboxableDictionary else {return nil}
            do {
                let ticketDetails : TicketDetails = try unbox(dictionary: json, atKey: "Request")
                return ticketDetails
            } catch {
                return nil
            }
        })
    }
}

