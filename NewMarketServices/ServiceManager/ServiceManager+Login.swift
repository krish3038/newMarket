//
//  ServiceManager+Login.swift
//  NewMarketServices
//
//  Created by admin on 11/06/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
import Alamofire

let kLoginSuccessResponseString = "Login successfull"
let kLoginFailureResponseString = "Invalid credentials"


extension ServiceManager {
    func loginWith(username: String, password: String, completionHandler:@escaping (_ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        
        let endPointURL = API_Login
        let headers: HTTPHeaders = ["user": username, "password": password]
        
        UserDefaults.standard.removeObject(forKey: "UserName")
        UserDefaults.standard.removeObject(forKey: "Password")
        
        self.executeService(requestUrl: endPointURL, httpMethod: .get, requestObject: nil, encoding: URLEncoding.default, headers: headers) { (dataResponse, error, isSuccess) in
            if (dataResponse?.response?.statusCode == 200)
            {
                if (dataResponse?.result.isSuccess)!
                {
                    let loginModel = try! JSONDecoder().decode(LoginModel.self, from: (dataResponse?.data)!) as LoginModel
                    if loginModel.status == kLoginSuccessResponseString {
                        UserDefaults.standard.set(username, forKey: "UserName")
                        UserDefaults.standard.set(password, forKey: "Password")
                        completionHandler(true, "", loginModel)
                    }  else {
                        completionHandler(false, INVALID_LOGING_ERROR, loginModel)
                    }
                } else {
                    completionHandler(false, TIMEOUT_OR_FAILIURE, nil)
                }
            }
            else if (dataResponse?.result.error?.localizedDescription == REQUEST_TIME_OUT) {
                completionHandler(false, REQUEST_TIMEOUT, nil)
            }
            else if (dataResponse?.response?.statusCode == 401 || dataResponse?.response?.statusCode == 400) {
                completionHandler(false, INVALID_LOGING_ERROR, nil)
            }else {
                completionHandler(false, TIMEOUT_OR_FAILIURE, nil)
            }
        }
    }
}

