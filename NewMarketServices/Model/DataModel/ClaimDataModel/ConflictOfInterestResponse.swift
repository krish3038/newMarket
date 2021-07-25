//
//  ConflictOfInterestResponse.swift
//  NewMarketServices
//
//  Created by administrator on 31/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

struct ConflictOfInterestResponse : Codable {
    var conflictOfInterestStatus : [ConflictOfInterestStatus]?
    
    private enum CodingKeys : String, CodingKey {
        case conflictOfInterestStatus = "jsonObj"
    }
    
}

struct ConflictOfInterestStatus: Codable {
    var status : Bool?
    
    private enum CodingKeys : String, CodingKey {
        case status = "Status"
    }
}
