//
//  ViewController.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 20.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class TicketsListViewController: UIViewController, TicketsListViewControllerDelegate {
    
    
    var viewModel : TicketsListViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl : UIRefreshControl!
    var router : StoryboardRouter<UIViewController>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        router = StoryboardRouter(viewController: self)
        updateData()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        //Refresh Controller
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to update data")
        refreshControl.addTarget(self, action: #selector(updateData), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func updateData() {
        viewModel?.updateData()
    }
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error loading data", message:
            "Oops, check your internet connection and try again. (Pull to reload)", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: { UIAlertAction in
            self.refreshControl.endRefreshing()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
//MARK: - Delegate methods
    
    func updateDataFinished() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    func updateDataFalled() {
        activityIndicator.stopAnimating()
        showErrorAlert()
    }
}

//MARK: - TableView

extension TicketsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.numberOfSections
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {return 0}
        return viewModel.numberOfTickets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllTicketsCell.reuseIdentifier, for: indexPath) as? AllTicketsCell else { (fatalError("Unexpected cell")) }
        
        if let ticketRepresentable = viewModel?.viewModel(for: indexPath.row) {
            cell.configure(withViewModel: ticketRepresentable)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ticketViewModel = viewModel?.viewModel(for: indexPath.row) {
            router?.navigateToTicketDetailsScreen(ticketViewModel: ticketViewModel)
        }
    }
}

