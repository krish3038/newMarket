//
//  ClaimInvestigate.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 6/19/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

/*
 {
 "jsonObj": [
 {
 "ClaimNo": "678XZ76502",
 "PolicyNo": "CCR K0001FR0020184",
 "InsuredCompanyName": "Southern Medical Centre",
 "PolicyType": "Commercial Prop.",
 "PolicyEffectiveDate": "2018-01-11T06:47:00.105Z",
 "PolicyExpiryDate": "2018-12-30T06:47:00.105Z",
 "ClaimDateofLoss": "2018-05-01T06:46:38.247Z",
 "ClaimActionRequired": "yes",
 "ClaimDetails1": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
 "ClaimDetails2": "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
 "PolicyDetails1": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"
 }
 ]
 }
 */


class ClaimInvestigates: Codable {
    var claimInvestigateList: [ClaimInvestigate]?
    enum CodingKeys : String, CodingKey {
        case claimInvestigateList = "jsonObj"
    }
}

class ClaimInvestigate: Codable {
    
    var policyNumber: String?
    var policyType: String?
    var policyEffectiveDate: String?
    var policyExpiryDate: String?
    var actionRequired: String?
    var dateOfLoss: String?
    var claimNumber: String?
    var companyName: String?
    
    var ClaimDetails1: String?
    var ClaimDetails2: String?
    var ClaimNotes: String?
    var PolicyDetail: String?
    
    
    enum CodingKeys : String, CodingKey {
        case policyNumber = "PolicyNo"
        case policyType = "PolicyType"
        case policyEffectiveDate = "PolicyEffectiveDate"
        case policyExpiryDate = "PolicyExpiryDate"
        case actionRequired = "ClaimActionRequired"
        case dateOfLoss = "ClaimDateofLoss"
        case claimNumber = "ClaimNo"
        case companyName = "InsuredCompanyName"
        
        case ClaimDetails1 = "ClaimDetails1"
        case ClaimDetails2 = "ClaimDetails2"
        case ClaimNotes = "ClaimNotes"
        case PolicyDetail = "PolicyDetails1"
    }

}
