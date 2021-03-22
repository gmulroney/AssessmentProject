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
    
    static func loadAccountInfo(completionBlock: @escaping (Result<AccountInfoModel,NetworkError>) -> Void) {
        NetworkManager.sharedInstance.makeRequest(endPoint: "account/info", requestMethod: "GET") { (result) in
            switch result {
            case .success(let data) :
                do {
                    let decodedResponse = try JSONDecoder().decode(AccountInfoResponse.self, from: data!)
                    completionBlock(.success(decodedResponse.result))
                } catch {
                    completionBlock(.failure(.badResponseError))
                }
            case .failure(let error) :
                completionBlock(.failure(error))
            }
        }
    }
}

struct CardModel : Codable {
    struct Fullname : Codable {
        var givenName : String
        var familyName : String
        
        func stringValue() -> String {
            return String(format: "%@ %@", givenName, familyName).trimmingCharacters(in: .whitespaces)
        }
    }
    enum Status : String, Codable {
        case Active
        case Expired
        case Locked
    }
    var fullName : Fullname
    var numberLast4 : String
    var expirationDate : String
    var status : Status
}
