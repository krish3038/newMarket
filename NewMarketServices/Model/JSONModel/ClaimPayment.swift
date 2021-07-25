//
//  ClaimPayment.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/9/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//


/*
 {
 "jsonObj": [
 {
 "ClaimNo": "678XZ76502",
 "PolicyNo": "CCR K0001FR0020184",
 "PartyName": "James Lawel",
 "PartyType": "Policyholder",
 "SettlementAmount": "£ 15,000.00",
 "ConfirmationStatus": "Agreed"
 },
 {
 "ClaimNo": "678XZ76502",
 "PolicyNo": "CCR K0001FR0020184",
 "PartyName": "Paul Marvel",
 "PartyType": "Placing Broker",
 "SettlementAmount": "£ 15,000.00",
 "ConfirmationStatus": "Disagreed"
 }
 ]
 }
 */

import Foundation
class ClaimPayments: Codable {
    
    var claimPaymentList: [ClaimPayment]?
    
    enum CodingKeys : String, CodingKey {
        
        case claimPaymentList = "jsonObj"
    }
}

class ClaimPayment: Codable {
    
    var partyName: String?
    var partyType: String?
    var settlementAmount: String?
    var confirmationStatus: String?
    var policyNumber : String?
    var claimNumber : String?
    
    enum CodingKeys : String, CodingKey {
        case partyName = "PartyName"
        case partyType = "PartyType"
        case settlementAmount = "SettlementAmount"
        case confirmationStatus = "ConfirmationStatus"
        case policyNumber = "PolicyNo"
        case claimNumber = "ClaimNo"
    }
}
