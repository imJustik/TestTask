//
//  TicketDetails.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 21.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation
import Unbox

struct TicketDetails {
    var statusText : String
    var fullname : String
    var description : String
    var solutionDescription : String?
    var createdAt : Date?
    var SLARecoveryTime : Date?
    var actualRecoveryTime : Date?
}

extension TicketDetails : Unboxable {
    init(unboxer: Unboxer) throws {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd-MM-yyyy HH:mm"
        self.statusText = try unboxer.unbox(key: "StatusText")
        self.fullname = try unboxer.unbox(key: "CreatedByFullName") // В ТЗ - FullName
        self.description = try unboxer.unbox(key: "Description")
        self.solutionDescription = unboxer.unbox(key: "SolutionDescription")
        self.createdAt = unboxer.unbox(key: "CreatedAt", formatter: dateFormater)
        self.SLARecoveryTime = unboxer.unbox(key: "SLARecoveryTime", formatter: dateFormater)
        self.actualRecoveryTime = unboxer.unbox(key: "ActualRecoveryTime", formatter: dateFormater)
    }
}
