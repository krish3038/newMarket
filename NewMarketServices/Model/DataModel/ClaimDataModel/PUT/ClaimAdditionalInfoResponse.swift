//
//  ClaimAdditionalInfoResponse.swift
//  NewMarketServices
//
//  Created by Sai Manikanta Siva Koti on 02/08/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

struct ClaimAdditionalInfoResponse: Codable
{
    var data : ClaimAdditionalDdetails?
}
struct ClaimAdditionalDdetails: Codable {
    var PartyName :String?
    var PartyType :String?
    var Details :String?
    var Status :String?
    var receivedOn :String?
}
//{
//    "data": {
//        "PartyName": "Asif",
//        "PartyType": "Lead",
//        "Details": "Office",
//        "Status": "OPEN",
//        "receivedOn": "2018-07-24T06:07:59.307Z"
//    }
//}
