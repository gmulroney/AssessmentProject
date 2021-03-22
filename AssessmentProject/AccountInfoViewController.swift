//
//  AccountInfoViewController.swift
//  AssessmentProject
//
//  Created by Garrett Mulroney on 3/17/21.
//

import UIKit

class AccountInfoViewController : UIViewController {
    @IBOutlet weak var balanceLabel : UILabel!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var last4Label : UILabel!
    @IBOutlet weak var expirationDateLabel : UILabel!
    @IBOutlet weak var cardStatusLabel : UILabel!
    
    @IBOutlet weak var loadingView : UIActivityIndicatorView!
    
    var accountModel : AccountInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Account Info"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.loadAccountInfo()
    }
    
    @IBAction func refreshAccountInfo() {
        self.loadAccountInfo()
    }
    
    func loadAccountInfo() {
        loadingView.startAnimating()
        AccountInfoModel.loadAccountInfo { [weak self] (result) in
            switch result {
            case .success(let account) :
                self?.accountModel = account
                DispatchQueue.main.async {
                    self?.loadingView.stopAnimating()
                    if let balance = self?.accountModel?.balance {
                        self?.balanceLabel.text = String(format: "%.2f", balance)
                    }
                    if let last4 = self?.accountModel?.card.numberLast4 {
                        self?.last4Label.text = last4
                    }
                    if let expirationDate = self?.accountModel?.card.expirationDate {
                        self?.expirationDateLabel.text = expirationDate
                    }
                    if let cardStatus = self?.accountModel?.card.status {
                        self?.cardStatusLabel.text = cardStatus.rawValue
                    }
                    self?.nameLabel.text = self?.accountModel?.card.fullName.stringValue()
                }
            case .failure(_) :
                let errorAlert = UIAlertController(title: "Error", message: "An error occured while loading your account information.", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Ok", style: .default))
                DispatchQueue.main.async {
                    self?.loadingView.stopAnimating();
                    self?.present(errorAlert, animated: true)
                }
            }
        }
    }
}
