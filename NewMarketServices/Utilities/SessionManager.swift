//
//  SessionManager.swift
//  NewMarketServices
//
//  Created by administrator on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
class SessionManager {
    
    //MARK : Properties
    
    static let shared = SessionManager()
    var loginResponseData:LoginResponse?
    var loginReq:LoginReq?
    
    private init() {
        
    }
    
}
