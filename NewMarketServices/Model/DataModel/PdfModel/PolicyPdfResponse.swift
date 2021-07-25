//
//  PolicyPdfResponse.swift
//  NewMarketServices
//
//  Created by Sai Manikanta Siva Koti on 01/08/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

struct PolicyPdfResponse : Codable
{
    var jsonObj : [PolicyPdfDetails]?
}

struct PolicyPdfDetails : Codable
{
    var PolicyDetails1 : String?
}
