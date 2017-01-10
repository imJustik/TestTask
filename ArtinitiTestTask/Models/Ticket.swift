//
//  Tiket.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 20.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation
import Unbox

struct Ticket {
    var createdAt : Date
    var name: String
    var objectCode : Int
    var priority : Int
    var requestNumber : String
    var status : Int
    var statusDisplayName : String
    var requestID : String
}

extension Ticket : Unboxable {
    init(unboxer: Unboxer) throws {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy HH:mm"
            self.createdAt = try unboxer.unbox(key: "CreatedAt", formatter: dateFormater)
            self.name = try unboxer.unbox(key: "Name")
            self.objectCode = try unboxer.unbox(key: "ObjectCode")
            self.priority = try unboxer.unbox(key: "Priority")
            self.requestNumber = try unboxer.unbox(key: "RequestNumber")
            self.status = try unboxer.unbox(key: "Status")
            self.statusDisplayName = try unboxer.unbox(key: "StatusDisplayName")
            self.requestID = try unboxer.unbox(key:"RequestID")
        
    }
}
