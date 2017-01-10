//
//  AppDependence.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 20.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class AppDependence {
    let window : UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func startConfiguration() {
        if let navigationController = window?.rootViewController as? UINavigationController {
            if let ticketsListViewController = navigationController.viewControllers.first as? TicketsListViewController
            {
                ticketsListViewController.viewModel = TicketsListViewModel(webservice: Webservice())
            }
        }
    }
}
