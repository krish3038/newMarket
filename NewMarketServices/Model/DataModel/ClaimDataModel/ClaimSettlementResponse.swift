//
//  ClaimSettlementResponse.swift
//  NewMarketServices
//
//  Created by administrator on 31/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

struct ClaimSettlementResponse : Codable {
    var claimSettlementData : [ClaimSettlementData]?
    
    private enum CodingKeys : String, CodingKey {
        case claimSettlementData = "jsonObj"
    }
    
}

struct ClaimSettlementData : Codable {
    var lead : String?
    var settlementAmount : String?
    var claimSettlementDetailsList : [ClaimSettlementDetails]?
    
    private enum CodingKeys : String, CodingKey {
        case lead = "Lead"
        case settlementAmount = "SettlementAmount"
        case claimSettlementDetailsList = "details"
    }
}

struct ClaimSettlementDetails : Codable {
    var name : String?
    var partyName : String?
    var partyType : String?
    var settlementAmount : String?
    var confirmation : String?
    
    private enum CodingKeys : String, CodingKey {
        case name = "Name"
        case partyName = "PartyName"
        case partyType = "PartyType"
        case settlementAmount = "SettlementAmount"
        case confirmation = "Confirmation"
    }
}
