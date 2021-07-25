//
//  ClaimPdfResponse.swift
//  NewMarketServices
//
//  Created by Sai Manikanta Siva Koti on 01/08/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

struct ClaimPdfResponse : Codable
{
    var jsonObj : [PdfDetails]?
}

struct PdfDetails : Codable {
    var ClaimDetails1 : String?
    var ClaimDetails2 : String?
}
