//
//  TicketDetailsViewController.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 21.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class TicketDetailsViewController: UIViewController, TicketDetailsViewModelDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel : TicketDetailsViewControllerViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getTicketDetails()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func loadingTicketDetailsFailed() {
        activityIndicator.stopAnimating()
        showAlert()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Error loading data", message:
            "Oops, check your internet connection and try again. ", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func loadingTicketDetailsFinished() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func handleKeyboardNotification(_ notification: Notification) {
        if (notification as NSNotification).userInfo != nil {
            let keyboardFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            let isKeyboardShowing = (notification.name == NSNotification.Name.UIKeyboardWillShow)
            let bottomInset = isKeyboardShowing ? keyboardFrame!.height : 0
            tableView.contentInset = UIEdgeInsets(top: tableView.contentInset.top, left: 0, bottom: bottomInset, right: 0)
            
            if isKeyboardShowing {
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
        
    }
}

extension TicketDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.numberOfSections
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {return 0}
        return viewModel.numberOfCells
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TicketDetailCell.reuseIdentifier, for: indexPath) as? TicketDetailCell else { (fatalError("Unexpected cell")) }
        if let ticketRepresentable = viewModel?.viewModel() {
            cell.configure(with: ticketRepresentable)
        }
        return cell
    }
}
