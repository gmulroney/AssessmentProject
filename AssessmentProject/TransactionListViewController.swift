//
//  TransactionListViewController.swift
//  AssessmentProject
//
//  Created by Garrett Mulroney on 3/17/21.
//

import UIKit

class TransactionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var transactionsTable : UITableView!
    
    var transactions : Array<TransactionModel> = [TransactionModel(id: "1", amount: -5.00, date: "12/12/21", recipient: "Garrett", description: "New Debit")]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.cellIdentifier()) as!TransactionTableViewCell
        let transaction = transactions[indexPath.row]
        cell.amountLabel.text = "\(transaction.amount)"
        cell.dateLabel.text = transaction.date
        cell.descriptionLabel.text = transaction.description
        cell.recipientLabel.text = transaction.recipient
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
