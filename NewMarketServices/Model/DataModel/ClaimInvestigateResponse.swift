//
//  ClaimInvestigateResponse.swift
//  NewMarketServices
//
//  Created by administrator on 30/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
struct ClaimInvestigateResponse : Codable {
    var claimInvestigateList : [ClaimInvestigateRecord]?
    private enum CodingKeys : String, CodingKey {
        case claimInvestigateList = "jsonObj"
    }
}

struct ClaimInvestigateRecord : Codable {
    var insuredCompanyName : String?
    var claimNumber : String?
    var policyNumber : String?
    var policyEffectiveDate : String?
    var policyExpiryDate : String?
    var claimDateofLoss : String?
    
    private enum CodingKeys : String, CodingKey {
        case insuredCompanyName = "InsuredCompanyName"
        case claimNumber = "ClaimNo"
        case policyNumber = "PolicyNo"
        case policyEffectiveDate = "PolicyEffectiveDate"
        case policyExpiryDate = "PolicyExpiryDate"
        case claimDateofLoss = "ClaimDateofLoss"
    }
}
