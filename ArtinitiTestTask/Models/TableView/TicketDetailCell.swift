//
//  TicketDetailCell.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 21.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class TicketDetailCell: UITableViewCell {
    static let reuseIdentifier = "TicketDetailsCell"
    
    @IBOutlet weak var solutionDescriptionTextView: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var statusTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var slaRecoveryTimeLabel: UILabel!
    @IBOutlet weak var actualRecoveryTimeLabel: UILabel!
    
   
    func configure(with viewModel: TicketDetailsRepresentable) {
        self.solutionDescriptionTextView.text = viewModel.solutionDescription
        self.descriptionLabel.text = viewModel.description
        self.fullnameLabel.text = viewModel.fullname
        self.statusTextLabel.text = viewModel.statusText
        self.createdAtLabel.text = viewModel.createdAt
        self.slaRecoveryTimeLabel.text = viewModel.SLARecoveryTime
        self.actualRecoveryTimeLabel.text = viewModel.actualRecoveryTime
    }
}
