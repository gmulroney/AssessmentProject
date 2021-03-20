//
//  AccountInfoModel.swift
//  AssessmentProject
//
//  Created by Garrett Mulroney on 3/19/21.
//

import Foundation

struct AccountInfoResponse : Codable {
    var result : AccountInfoModel
}

struct AccountInfoModel : Codable {
    var balance : Float = 0
    var card : CardModel
    
    static func loadAccountInfo(completionBlock: @escaping (Result<AccountInfoModel,Error>) -> Void) {
        NetworkManager.sharedInstance.makeRequest(endPoint: "account/info", requestMethod: "GET") { (result) in
            switch result {
            case .success(let data) :
                do {
                    let decodedResponse = try JSONDecoder().decode(AccountInfoResponse.self, from: data!)
                    completionBlock(.success(decodedResponse.result))
                } catch {
                    completionBlock(.failure(error))
                }
            case .failure(let error) :
                completionBlock(.failure(error))
            }
        }
    }
}

enum CardStatus : String, Codable {
    case Active
    case Expired
    case Locked
}

struct CardModel : Codable {
    var numberLast4 : String = ""
    var expirationDate : String = ""
    var status : CardStatus
}
