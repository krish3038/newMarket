//
//  PendingTask.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/10/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
class PendingTasks: Codable {
    var policy: Policy?
    enum CodingKeys : String, CodingKey {
        case policy = "jsonObj"
    }
}
