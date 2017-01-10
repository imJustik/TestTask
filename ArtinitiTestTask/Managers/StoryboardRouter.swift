//
//  StoryboardRouter.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 21.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

/*
 Возможно, роутер, в рамках конкретной задачи, является лишним, а переход можно совершать непосредственно в контроллере.
 Однако, в больших проектах, данный класс помогает вынести всю логику переходов из контроллеров и использовать ее
 повторно.
 */

class StoryboardRouter<T: UIViewController> {
    weak fileprivate(set) var viewController : UIViewController?
    
    init(viewController : T) {
        self.viewController = viewController
    }
    
    func navigateToTicketDetailsScreen(ticketViewModel: TicketRepresentable) {
        self.performSegue(identifier: "ToDetailsSegue") { (viewController: TicketDetailsViewController) in
            viewController.viewModel = TicketDetailsViewControllerViewModel(ticketViewModel: ticketViewModel, webservice: Webservice())
        }
        
    }
    
}


extension StoryboardRouter {
    
    fileprivate func performSegue<DestinationViewControllerType>(identifier: String, configurate:  ((_ viewController: DestinationViewControllerType) -> Void)?) {
        self.viewController?.performSegueWithIdentifier(identifier, sender: self, configurate: { (segue) in
            if let navigationViewController = segue.destination as? UINavigationController {
                if let rootViewController = navigationViewController.viewControllers.first {
                    self.perform(viewController: rootViewController, identifier: identifier, configurate: configurate)
                } else {
                    fatalError("Segue with identifier: \(identifier) has destinationViewController as UINavigationController without viewControllers")
                }
            } else {
                self.perform(viewController: segue.destination, identifier: identifier, configurate: configurate)
            }
            
        })
    }
    
    fileprivate func perform<DestinationViewControllerType>(viewController: UIViewController, identifier: String, configurate: ((_ viewController: DestinationViewControllerType) -> Void)?) {
        guard let viewController = viewController as? DestinationViewControllerType else {
            fatalError("Segue with identifier: \(identifier) doesn't has destinationViewController with type \(DestinationViewControllerType.self)")
        }
        
        configurate?(viewController)
    }
}

