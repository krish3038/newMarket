//
//  ClaimEvaluationResponse.swift
//  NewMarketServices
//
//  Created by administrator on 31/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

struct ClaimEvaluationResponse : Codable {
    var claimSegmentationInfo : [ClaimSegmentationDetails]?
    var claimAckBy : String?
    var additionalInfo : [AdditionalInfoDetails]?
    var claimExpertOpinion : String?
    var claimQuery : String?
    
    private enum CodingKeys : String, CodingKey {
        case claimSegmentationInfo = "ClaimSegmentation"
        case claimAckBy = "ClaimAckBy"
        case additionalInfo = "AdditionalInfo"
        case claimExpertOpinion = "ClaimExpertOpinion"
        case claimQuery = "ClaimQuery"
    }
}

struct ClaimSegmentationDetails : Codable {
    var claimSegmentationType : String?
    var name : String?
    var tableInfo : [ClaimSegmentationTableInfo]?
    
    private enum CodingKeys : String, CodingKey {
        case claimSegmentationType = "CSType"
        case name = "Name"
        case tableInfo = "table"
    }
}

struct ClaimSegmentationTableInfo : Codable {
    var claimSegmentationTableInfoName : String?
    var claimSegmentationTableInfoRole : String?
    var claimSegmentationTableInfoDate : String?
    
    private enum CodingKeys : String, CodingKey {
        case claimSegmentationTableInfoName = "Name"
        case claimSegmentationTableInfoRole = "Role"
        case claimSegmentationTableInfoDate = "Date"
    }
}

struct AdditionalInfoDetails : Codable {
    var name : String?
    var tableInfo : [AdditionalDetailsTableInfo]?
    
    private enum CodingKeys : String, CodingKey {
        case name = "Name"
        case tableInfo = "table"
    }
}

struct AdditionalDetailsTableInfo : Codable {
    var additionalTableInfoPartyName : String?
    var additionalTableInfoPartyType : String?
    var additionalTableInfoDetails : String?
    var additionalTableInfoStatus : String?
    var additionalTableInfoReceivedOn : String?
    
    private enum CodingKeys : String, CodingKey {
        case additionalTableInfoPartyName = "PartyName"
        case additionalTableInfoPartyType = "PartyType"
        case additionalTableInfoDetails = "Details"
        case additionalTableInfoStatus = "Status"
        case additionalTableInfoReceivedOn = "ReceivedOn"
    }
}
