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
    
    @IBOutlet weak var cardStatusView : UIView!
    @IBOutlet weak var cardStatusLabel : UILabel!
    @IBOutlet weak var cardStatusImageView : UIImageView!
    
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
                        switch cardStatus {
                        case .Active:
                            self?.cardStatusLabel.text = "ACTIVE"
                            self?.cardStatusView.backgroundColor = UIColor(named: "SuccessColor")
                            self?.cardStatusImageView.image = UIImage(systemName: "checkmark.circle.fill")
                        case .Expired:
                            self?.cardStatusLabel.text = "EXPIRED"
                            self?.cardStatusView.backgroundColor = UIColor(named: "WarningColor")
                            self?.cardStatusImageView.image = UIImage(systemName: "exclamationmark.circle")
                        case .Locked:
                            self?.cardStatusLabel.text = "LOCKED"
                            self?.cardStatusView.backgroundColor = UIColor(named: "ErrorColor")
                            self?.cardStatusImageView.image = UIImage(systemName: "lock.circle")
                        }
                        self?.cardStatusLabel.text = cardStatus.rawValue
                    }
                    self?.nameLabel.text = self?.accountModel?.card.fullName.stringValue()
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
                    let errorAlert = UIAlertController(title: "Error", message: "An error occured while loading account information. Please contact Support for more information.", preferredStyle: .alert)
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
