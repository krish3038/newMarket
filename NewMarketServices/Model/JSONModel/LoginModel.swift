//
//  LoginModel.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/1/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class LoginModel: Codable {
   
    var accessToken: String?
    var tokenType: String?
    var refreshToken: String?
    var expiresIn: Int?
    var userId: Int?
    var status: String?
    
    
    enum CodingKeys : String, CodingKey {
//        case accessToken = "access_token"
//        case tokenType = "token_type"
//        case refreshToken = "refresh_token"
//        case expiresIn = "expires_in"
//        case userId = "userId"
        case status = "status"
    }
    
}

