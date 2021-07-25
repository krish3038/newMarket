//
//  MyPolicyResponse.swift
//  NewMarketServices
//
//  Created by administrator on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

struct MyPolicyResponse : Codable {
    var myPolicyList : [MyPolicyDetails]?
    private enum CodingKeys : String, CodingKey {
        case myPolicyList = "jsonObj"
    }
}

struct MyPolicyDetails : Codable {
    var policyHolder : String?
    var policyNumber : String?
    var policyEffectiveDate : String?
    var policyExpiryDate : String?
    var policyLOB : String?
    var policyStatus : String?
    
    private enum CodingKeys : String, CodingKey {
        case policyHolder = "PolicyHolder"
        case policyNumber = "PolicyNo"
        case policyEffectiveDate = "PolicyEffectiveDate"
        case policyExpiryDate = "PolicyExpiryDate"
        case policyLOB = "PolicyLOB"
        case policyStatus = "PolicyStatus"
    }
}


