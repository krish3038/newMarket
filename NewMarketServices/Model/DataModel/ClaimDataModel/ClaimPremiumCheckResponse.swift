//
//  ClaimPremiumCheckResponse.swift
//  NewMarketServices
//
//  Created by administrator on 01/08/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

struct ClaimPremiumCheckResponse : Codable {
    
    var jsonData : PremiumCheckData?
    
    private enum CodingKeys : String, CodingKey {
        case jsonData = "jsonObj"
    }
}

struct PremiumCheckData: Codable {
    var claimNumber : String?
    var premiumCheckDetailData : PremiumCheckDetailData?
    
    private enum CodingKeys : String, CodingKey {
        case claimNumber = "ClaimNo"
        case premiumCheckDetailData = "checkPremium"
    }
}

struct PremiumCheckDetailData: Codable {
    var premiumBeenPaiByPolHolder : Bool?
    var reinstatementApplicable : Bool?
    var reinstatementPaidByPolHolder : Bool?
    
    private enum CodingKeys : String, CodingKey {
        case premiumBeenPaiByPolHolder = "premiumBeenPaiByPolHolder"
        case reinstatementApplicable = "reinstatementApplicable"
        case reinstatementPaidByPolHolder = "reinstatementPaidByPolHolder"
    }
}
