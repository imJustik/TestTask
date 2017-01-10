//
//  WebserviceRouter.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 08.01.17.
//  Copyright © 2017 Iliya Kuznetsov. All rights reserved.
//

import Foundation
import Alamofire

enum WebserviceRouter: URLRequestConvertible {
    static let baseURLString = "http://mobile.atrinity.ru/api/service"
    static let baseParameters : [String:Any] = [
        "ApiKey":"e8e6a311d54985a067ece5a008da280a",
        "Login":"d_blinov",
        "Password":"Passw0rd",
        "ObjectCode":300,
        ]
    
    case LoadTickets()
    case LoadTicketDetails(String)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .LoadTickets, .LoadTicketDetails :
            return .post
        }
    }
    
    var parameters : [String:Any] {
        switch self {
        case .LoadTickets:
            return ["Action": "GET_LIST", "Fields" : ["FilterID":"3CD0E650-4B81-E511-A39A-1CC1DEAD694D"]]
        case .LoadTicketDetails(let requestID):
            return ["Action": "GET_INFO", "Fields" : ["RequestID":requestID]]
        }
        
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: WebserviceRouter.baseURLString)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        let parameters = WebserviceRouter.baseParameters + self.parameters
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
