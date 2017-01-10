//
//  AllTicketsCell.swift
//  ArtinitiTestTask
//
//  Created by Iliya Kuznetsov on 20.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class AllTicketsCell: UITableViewCell {

    static let reuseIdentifier = "TicketCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var requestNumbelLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    func configure(withViewModel viewModel: TicketRepresentable) {
        nameLabel.text = viewModel.name
        requestNumbelLabel.text = viewModel.requestNumber
        createdAtLabel.text = viewModel.createdAt
    }

}
