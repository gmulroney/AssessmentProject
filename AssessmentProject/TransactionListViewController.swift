//
//  TransactionListViewController.swift
//  AssessmentProject
//
//  Created by Garrett Mulroney on 3/17/21.
//

import UIKit

class TransactionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var transactionsTable : UITableView!
    @IBOutlet weak var loadingView : UIActivityIndicatorView!
    
    var transactions : Array<TransactionModel> = [TransactionModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        loadingView.startAnimating()
        TransactionModel.fetchTransactions { [weak self] (result) in
            switch result {
            case .success(let transactions):
                self?.transactions = transactions
                DispatchQueue.main.async {
                    self?.loadingView.stopAnimating()
                    self?.transactionsTable.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    //print error
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.cellIdentifier()) as!TransactionTableViewCell
        let transaction = transactions[indexPath.row]
        if let amount = transaction.amount {
            cell.amountLabel.text = String(format: "%.2f", amount)
        }
        cell.dateLabel.text = transaction.date
        cell.descriptionLabel.text = transaction.description
        cell.recipientLabel.text = transaction.recipient
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
