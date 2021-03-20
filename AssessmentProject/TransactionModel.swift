//
//  TransactionModel.swift
//  AssessmentProject
//
//  Created by Garrett Mulroney on 3/19/21.
//

import Foundation

struct TransactionResponse : Codable {
    var result : [TransactionModel]
}

struct TransactionModel : Codable {
    var id : Int
    var amount : Float?
    var date : String?
    var recipient : String?
    var description : String?
    
    static func fetchTransactions(_ completionBlock: @escaping (Result<Array<TransactionModel>, Error>) -> Void) {
        NetworkManager.sharedInstance.makeRequest(endPoint: "account/transactions", requestMethod: "GET") { (result) in
            switch result {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode(TransactionResponse.self, from: data!)
                    completionBlock(.success(decodedResponse.result))
                } catch {
                    completionBlock(.failure(error))
                }
            case .failure(let error):
                completionBlock(.failure(error))
            }
        }
    }
    
    static func mockData() -> Array<TransactionModel> {
        return [
            TransactionModel(id: 1234, amount: -5.00, date: "11/12/21", recipient: "Garrett Mulroney", description: "Debit Transaction"),
            TransactionModel(id: 2345, amount: 10.00, date: "10/12/21", recipient: "Bank of America", description: "Credit Transaction"),
            TransactionModel(id: 3456, amount: 15.00, date: "09/12/21", recipient: "Bank of America", description: "Credit Transaction"),
            TransactionModel(id: 4567, amount: -50.43, date: "08/12/21", recipient: "Garrett Mulroney", description: "Debit Transaction"),
            TransactionModel(id: 5678, amount: 7.00, date: "07/12/21", recipient: "Bank of America", description: "DebCreditit Transaction"),
            TransactionModel(id: 6789, amount: -35.00, date: "06/12/21", recipient: "Garrett Mulroney", description: "Debit Transaction"),
            TransactionModel(id: 7890, amount: 500.00, date: "05/12/21", recipient: "Bank of America", description: "Credit Transaction"),
            TransactionModel(id: 8901, amount: 90.12, date: "04/12/21", recipient: "Bank of America", description: "Credit Transaction"),
            TransactionModel(id: 9012, amount: -21.54, date: "02/12/21", recipient: "Garrett Mulroney", description: "Debit Transaction"),
            TransactionModel(id: 0123, amount: -5.45, date: "01/12/21", recipient: "Garrett Mulroney", description: "Debit Transaction"),
            TransactionModel(id: 0987, amount: 3.14, date: "03/14/21", recipient: "Bank of America", description: "Credit Transaction"),
        ]
    }
}
