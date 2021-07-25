//
//  ClaimSegementPUTResponse.swift
//  NewMarketServices
//
//  Created by Sai Manikanta Siva Koti on 02/08/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
struct ClaimSegementPUTResponse: Codable
{
    var data : ClaimSegmentDetails?
}
struct ClaimSegmentDetails: Codable {
    var user :String?
    var role :String?
    var office :String?
    var segDate :String?
    var CreateDate :String?
    var TargetDate :String?
}

//{
//    data: {
//        "user": "",
//        "role": "",
//        "office": "",
//        "segDate": "2018-07-17T09:03:42.115Z",
//        "CreateDate": "2018-07-17T09:03:42.115Z",
//        "TargetDate": "2018-07-17T09:03:42.115Z",
//    }
//}
