//
//  Claim.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/6/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

/*
 {
 "$class": "org.lloyds.marketplace.Claims",
 "ClaimNo": "678XZ76501",
 "CompanyName": "Northmedical",
 "MovementDate": "01-Jan-2018",
 "Days": "1d",
 "Status": "Active"
 }
 */

/*
 {
 "jsonObj": [
 {
 "ClaimNo": "678XZ76502",
 "InsuredCompanyName": "Southern Medical Centre",
 "PolicyNo": "CCR K0001FR0020184",
 "Day": "17 days",
 "MovementDate": "2018-01-11T06:47:00.105Z"
 }
 ]
 }
 */

class Claims: Codable {
    var claimlist: [Claim]?
    enum CodingKeys : String, CodingKey {
        case claimlist = "jsonObj"
    }
}

class Claim: Codable {
  
    var claimNumber: String?
    var companyName: String?
    var days: String?
    var movementDate: String?
    var status: String?
    var policyNumner : String?
    
    enum CodingKeys : String, CodingKey {
        case claimNumber = "ClaimNo"
        case companyName = "InsuredCompanyName"
        case movementDate = "MovementDate"
        case days = "Day"
        case policyNumner = "PolicyNo"
        case status = "Status"
    }
}

