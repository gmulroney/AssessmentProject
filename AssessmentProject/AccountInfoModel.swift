//
//  AccountInfoModel.swift
//  AssessmentProject
//
//  Created by Garrett Mulroney on 3/19/21.
//

import Foundation

struct AccountInfoModel : Codable {
    struct CardModel : Codable {
        enum CardStatus : String, Codable {
            case Active
            case Expired
            case Locked
        }
        var firstName : String = ""
        var lastName : String = ""
        var numberLast4 : String = ""
        var expirationDate : String = ""
        var status : CardStatus
    }
    
    var Balance : Float = 0
    var card : CardModel
}
