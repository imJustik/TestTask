//
//  TicketDetailsVewViewModel.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 21.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation

protocol TicketDetailsRepresentable {
    var statusText : String {get}
    var fullname : String {get}
    var description : String {get}
    var solutionDescription : String {get}
    var createdAt : String {get}
    var SLARecoveryTime : String {get}
    var actualRecoveryTime : String {get}
}

class TicketDetailsViewViewModel : TicketDetailsRepresentable {
    
    private let dateFormatter = DateFormatter()
    var statusText : String
    var fullname : String
    var description : String
    var solutionDescription : String
    var createdAt : String
    var SLARecoveryTime : String
    var actualRecoveryTime : String
    
    init(details: TicketDetails) {
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        self.statusText = details.statusText
        self.fullname = details.fullname
        self.description = details.description
        
        self.solutionDescription = details.solutionDescription != nil ? details.solutionDescription! : ""
        self.SLARecoveryTime = details.SLARecoveryTime != nil ? self.dateFormatter.string(from: details.SLARecoveryTime!) : "-"
        self.createdAt = details.createdAt != nil ? self.dateFormatter.string(from: details.createdAt!) : "-"
        self.actualRecoveryTime = details.actualRecoveryTime != nil ? self.dateFormatter.string(from: details.actualRecoveryTime!) : "-"
    }
}
