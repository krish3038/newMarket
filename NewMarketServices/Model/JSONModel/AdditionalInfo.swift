//
//  AdditionalInfo.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/5/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

class AdditionalInfos: Codable {
    
    var additionalInfoList: [AdditionalInfo]?
    
    enum CodingKeys : String, CodingKey {
        
        case additionalInfoList = "jsonObj"
    }
}

class AdditionalInfo: Codable {
    
    var partyName: String?
    var partyType: String?
    var details: String?
    var infoReceived: String?
    var infoReceivedDate: String?
    var policyNumber : String?
    var claimNumber : String?
    
    enum CodingKeys : String, CodingKey {
        case partyName = "PartyName"
        case partyType = "PartyType"
        case details = "Details"
        case infoReceived = "InfoReceived"
        case infoReceivedDate = "InfoReceivedDate"
        case policyNumber = "PolicyNo"
        case claimNumber = "ClaimNo"
    }
}
