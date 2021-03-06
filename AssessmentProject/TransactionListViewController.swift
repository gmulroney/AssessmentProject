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
        self.title = "Transactions"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.loadTransactions()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count > 0 ? transactions.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (transactions.count > 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.cellIdentifier()) as!TransactionTableViewCell
            let transaction = transactions[indexPath.row]
            cell.transaction = transaction
            if let amount = transaction.amount {
                cell.amountLabel.text = String(format: "%.2f", amount)
            }
            cell.dateLabel.text = transaction.date
            cell.descriptionLabel.text = transaction.description
            cell.recipientLabel.text = transaction.recipient
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "noResultsCell")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @IBAction func refreshTransactions() {
        self.loadTransactions()
    }
    
    func loadTransactions() {
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
                switch error {
                case .connectionError:
                    let errorAlert = UIAlertController(title: "Error", message: "There was an error when trying to connect to the server. Please check your internet connection and try again.", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "Ok", style: .default))
                    DispatchQueue.main.async {
                        self?.loadingView.stopAnimating();
                        self?.present(errorAlert, animated: true)
                    }
                default:
                    let errorAlert = UIAlertController(title: "Error", message: "An error occured while loading your transactions. Please contact Support for more information.", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "Ok", style: .default))
                    DispatchQueue.main.async {
                        self?.loadingView.stopAnimating();
                        self?.present(errorAlert, animated: true)
                    }
                }
            }
        }
    }
}
