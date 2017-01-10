//
//  TicketDetailsViewModel.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 21.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation


protocol TicketDetailsViewModelDelegate : class {
    func loadingTicketDetailsFinished()
    func loadingTicketDetailsFailed()
}

class TicketDetailsViewControllerViewModel {
    private var ticketViewModel : TicketRepresentable
    private var ticketDetails : TicketDetails?
    private var webservice : Webservice
    
    weak var delegate: TicketDetailsViewModelDelegate?
    let numberOfSections = 1
    var numberOfCells = 0
    
    init(ticketViewModel: TicketRepresentable, webservice: Webservice) {
        self.ticketViewModel = ticketViewModel
        self.webservice = webservice
    }
    
    func getTicketDetails() {
        webservice.load(resource: TicketDetails.details(requestID: ticketViewModel.requestID)) { details in
            guard details != nil else {
                self.delegate?.loadingTicketDetailsFailed()
                return
            }
            self.ticketDetails = details
            self.numberOfCells = 1
            self.delegate?.loadingTicketDetailsFinished()
        }

    }
    
    func viewModel() -> TicketDetailsViewViewModel {
        guard let details = self.ticketDetails else { fatalError("Tickets is nil") }
        return TicketDetailsViewViewModel(details: details)
    }
}
    
