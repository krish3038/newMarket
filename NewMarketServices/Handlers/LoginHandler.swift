//
//  LoginHandler.swift
//  NewMarketServices
//
//  Created by admin on 11/06/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

class LoginHandler: NSObject {
    class func getloginWith(username: String, password: String, completionHandler:@escaping (_ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        ServiceManager.sharedInstance.loginWith(username: username, password: password) { (isSuccess, errorMessage, response) in completionHandler(isSuccess, errorMessage, response)
        }
    }
}
