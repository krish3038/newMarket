//
//  MyCasesResponse.swift
//  NewMarketServices
//
//  Created by administrator on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation


struct Section  {
    var collapsable : Bool
    var isOpened : Bool
    var myCase:MyCases
}

struct MyCasesResponse : Codable {
    var myCasesList : [MyCases]?
    
    private enum CodingKeys : String, CodingKey {
        case myCasesList = "jsonObj"
    }
}

//struct MyCases : Codable {
//    var InsuredCompanyName : String?
//    var ClaimNo : String?
//    var PolicyNo : String?
//    var ClaimCreateDate : String?
//    var ClaimUrgency : String?
//    var ClaimTargetDate : String?
//    var ClaimMode : String?
//    var eachCases: [EachCase]?
//}


struct MyCases : Codable {
    var InsuredCompanyName : String?
    var ClaimNo : String?
    var PolicyNo : String?
    var ClaimCreateDate : String?
    var ClaimUrgency : String?
    var ClaimTargetDate : String?
    var ClaimMode : String?
    var details: [EachCase]?
}

struct EachCase:Codable {
    var Name : String?
    var ClaimNo : String?
    var PolicyNo : String?
    var CreateDate : String?
    var Urgency : String?
    var TargetDate : String?
    var Status : String?
}
