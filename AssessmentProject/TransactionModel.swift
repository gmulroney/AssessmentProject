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
    
    static func fetchTransactions(_ completionBlock: @escaping (Result<Array<TransactionModel>, NetworkError>) -> Void) {
        NetworkManager.sharedInstance.makeRequest(endPoint: "account/transactions", requestMethod: "GET") { (result) in
            switch result {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode(TransactionResponse.self, from: data!)
                    completionBlock(.success(decodedResponse.result))
                } catch {
                    completionBlock(.failure(.badResponseError))
                }
            case .failure(let error):
                completionBlock(.failure(error))
            }
        }
    }
}
