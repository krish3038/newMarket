//
//  ConflictOfIntrestPUTModel.swift
//  NewMarketServices
//
//  Created by Sai Manikanta Siva Koti on 02/08/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

struct ConflictOfIntrestPUTModel: Codable
{
    var data : ConflictStatus?
}
struct ConflictStatus: Codable {
    var ClaimMode :String?
}
