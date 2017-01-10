//
//  TicketViewViewModel.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 20.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation

protocol TicketRepresentable {
    var requestID: String {get}
    var requestNumber : String {get}
    var name : String {get}
    var createdAt : String {get}
}

//ViewModel для отображения заявки в ячейке TableView

class TicketViewViewModel : TicketRepresentable {
    private let dateFormatter = DateFormatter()
    private let ticket : Ticket
    
    var requestID: String
    var createdAt: String
    var name: String
    var requestNumber: String
    
    init(ticket: Ticket) {
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        self.requestID = ticket.requestID
        self.ticket = ticket
        self.createdAt = dateFormatter.string(from: ticket.createdAt)
        self.name = ticket.name
        self.requestNumber = ticket.requestNumber
        
    }

}
