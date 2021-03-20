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
    
    var accountModel : AccountInfoModel? = AccountInfoModel(Balance: 50, card: AccountInfoModel.CardModel(firstName: "Garrett", lastName: "Mulroney", numberLast4: "0000", expirationDate: "12/12/21", status: AccountInfoModel.CardModel.CardStatus.Active))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Account Info"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
}
