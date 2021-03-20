//
//  TransactionModel.swift
//  AssessmentProject
//
//  Created by Garrett Mulroney on 3/19/21.
//

import Foundation

struct TransactionModel : Codable {
    var id : String
    var amount : Float
    var date : String
    var recipient : String
    var description : String
}
