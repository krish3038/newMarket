//
//  LoginResponse.swift
//  NewMarketServices
//
//  Created by administrator on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
struct LoginResponse : Codable {
    var userName : String?
    var name : String?
    var userRole : String?
    var userCompanyName : String?
    var useremail : String?
    
   private enum CodingKeys : String, CodingKey {
        case userName = "UserName"
        case name = "Name"
        case userRole = "Role"
        case userCompanyName = "CompanyName"
        case useremail = "Email"

    }
}

struct LoginReq {
    var userName : String?
    var UserPwd : String?
}
