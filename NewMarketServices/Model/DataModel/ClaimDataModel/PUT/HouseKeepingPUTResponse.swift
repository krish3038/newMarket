//
//  HouseKeepingPUTResponse.swift
//  NewMarketServices
//
//  Created by Sai Manikanta Siva Koti on 02/08/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
struct HouseKeepingPUTResponse: Codable
{
    var data : HouseKeepoingDetails?
}
struct HouseKeepoingDetails: Codable {
    var premiumBeenPaidByPolHolder :String?
    var reinstatementPremiumPaid :String?
    var anyFraud :String?
    var CreateDate :String?
    var TargetDate :String?
    var status :String?
}

//{
//    data: {
//        "premiumBeenPaidByPolHolder": false,
//        "reinstatementPremiumPaid": false,
//        "anyFraud": false,
//        "CreateDate": "2018-07-17T09:03:42.115Z",
//        "TargetDate": "2018-07-17T09:03:42.115Z",
//        "status": "Approved"
//    }
//}
