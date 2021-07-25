//
//  Policy.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/11/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

/*
 {
 "$class": "org.lloyds.marketplace.Policy",
 "PolicyNo": "UMR B0001PR0020184",
 "CompanyName": "SuthernMedical  Center",
 "PolicyType": "Commercial Property All-Risk",
 "PolicyEffectiveDate": "2018-01-05T08:09:30.171Z",
 "PolicyExpiryDate": "2018-12-05T08:09:30.171Z",
 "PolicyStatus": "ACTIVE",
 "ClaimNo": "231XZ76501",
 "PremiumStatus": "Paid",
 "ActionRequired": "Conflict of Interest",
 "DateOfLoss": "2018-05-05T08:09:30.171Z"
 }
 
 "$class": "org.lloyds.marketplace.Policy",
 "PolicyNo": "UMR B0001PR0020184",
 "CompanyName": "SuthernMedical  Center",
 "PolicyType": "Commercial Property All-Risk",
 "PolicyEffectiveDate": "2018-06-05T08:09:30.171Z",
 "PolicyExpiryDate": "2018-06-05T08:09:30.171Z",
 "PolicyStatus": "ACTIVE",
 "ActionRequired": "Yes",
 "DateUpdated": "2018-06-05T08:09:30.171Z",
 "Mode": "Closed",
 "PremiumStatus": "Paid"
 */

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
 "ClaimActionRequired": "yes"
 }
 ]
 }
 */

/*
 {
 "jsonObj": [
 {
 "PolicyNo": "CCR K0001FR0020184",
 "InsuredCompanyName": "Southern Medical Centre",
 "PolicyType": "Commercial Prop.",
 "PolicyEffectiveDate": "2018-01-11T06:47:00.105Z",
 "PolicyExpiryDate": "2018-12-30T06:47:00.105Z",
 "ClaimPremiumStatus": "Paid",
 "ClaimActionRequired": "yes",
 "ClaimUpdateDate": "2018-06-20T05:59:56.178Z",
 "ClaimMode": "Pending",
 "ClaimNo": "678XZ76502"
 }
 ]
 }
 */

class Policies: Codable {
    var policyList: [Policy]?
    enum CodingKeys : String, CodingKey {
        case policyList = "jsonObj"
    }
}

class Policy: Codable {
    
    var policyNumber: String?
    var policyType: String?
    var policyEffectiveDate: String?
    var policyExpiryDate: String?
    var actionRequired: String?
    var dateOfLoss: String?
    var claimNumber: String?
    var companyName: String?
    
    var premiumStatus: String?
    var policyStatus: String?
    var dateUpdated: String?
    var mode: String?
    
    
    enum CodingKeys : String, CodingKey {
        case policyNumber = "PolicyNo"
        case policyType = "PolicyType"
        case policyEffectiveDate = "PolicyEffectiveDate"
        case policyExpiryDate = "PolicyExpiryDate"
        case actionRequired = "ClaimActionRequired"
        case dateOfLoss = "ClaimDateofLoss"
        case claimNumber = "ClaimNo"
        case companyName = "InsuredCompanyName"
        
        case policyStatus = "PolicyStatus"
        case premiumStatus = "ClaimPremiumStatus"
        case dateUpdated = "ClaimUpdateDate"
        case mode = "ClaimMode"
    }
}
