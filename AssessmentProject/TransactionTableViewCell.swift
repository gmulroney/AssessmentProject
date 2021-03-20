//
//  TransactionTableViewCell.swift
//  AssessmentProject
//
//  Created by Garrett Mulroney on 3/19/21.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amountLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var recipientLabel: UILabel!
    
    var transaction : TransactionModel?
    
    static func cellIdentifier() -> String {
        return "transactionTableViewCell"
    }
}
