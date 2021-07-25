//
//  ClaimHousekeepCheckResponse.swift
//  NewMarketServices
//
//  Created by administrator on 01/08/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

struct ClaimHousekeepCheckResponse : Codable {
    
    var jsonData : HouseKeepCheckData?
    
    private enum CodingKeys : String, CodingKey {
        case jsonData = "jsonObj"
    }
}

struct HouseKeepCheckData: Codable {
    var claimNumber : String?
    var houseKeepDetailData : HouseKeepCheckDetailData?
    
    private enum CodingKeys : String, CodingKey {
        case claimNumber = "ClaimNo"
        case houseKeepDetailData = "houseKeeping"
    }
}

struct HouseKeepCheckDetailData: Codable {
    var premiumPaidByPolHolder : Bool?
    var reinstatementPremiumPaid : Bool?
    var anyFraud : Bool?
    var createDate : String?
    var targetDate : String?
    var status : String?
    
    private enum CodingKeys : String, CodingKey {
        case premiumPaidByPolHolder = "premiumBeenPaidByPolHolder"
        case reinstatementPremiumPaid = "reinstatementPremiumPaid"
        case anyFraud = "anyFraud"
        case createDate = "CreateDate"
        case targetDate = "TargetDate"
        case status = "Status"
    }
}

