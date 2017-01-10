//
//  TicketsListViewModel.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 20.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation
protocol TicketsListViewControllerDelegate : class {
    func updateDataFinished()
    func updateDataFalled()
}

class TicketsListViewModel {
    weak var delegate : TicketsListViewControllerDelegate?
    private var tickets : [Ticket]?
    private let webservice: Webservice
    var numberOfSections : Int
    var numberOfTickets : Int
    
    init(webservice: Webservice) {
       self.webservice = webservice
        numberOfSections = 1
        numberOfTickets = 0
    }
    
    func updateData() {
        webservice.load(resource: Ticket.all()) { tickets in
            guard tickets != nil else {
                self.delegate?.updateDataFalled()
                return
            }
            self.tickets = tickets
            self.numberOfTickets = tickets!.count
            self.delegate?.updateDataFinished()
        }

    }
    
    func viewModel(for index: Int) -> TicketRepresentable {
        guard let tickets = self.tickets else { fatalError("Tickets is nil") }
        return TicketViewViewModel(ticket: tickets[index])
    }
    
}
