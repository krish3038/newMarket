//
//  ServiceManager+Dashboard.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/11/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

extension ServiceManager {
    
    func getPolicyDetails(userID: String, claimNumber: String, completionHandler:@escaping (_ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        
        let endPointURL = String(format: API_ClaimDetails+claimNumber)
        let url =  URL(string:endPointURL as String)
        
        self.executePostService(requestUrl: url, httpBody: nil, httpMethod: "GET", isAuthorise: true) { (dataResponse, errMsg, isSuccess) in
            //Server code
            // 201 - success
            
            //TODO :For testing uncomment below code
            //Using Policy JSON file data for testing
            
             let fileData = JSONParser.getDataFromFile(fileName: "AllPolicies", fileExtension: "json")! as Data
             let policies = try! JSONDecoder().decode(Policies.self, from: fileData) as AnyObject
             completionHandler(true, "", policies)
            
            
            /*if (dataResponse?.response?.statusCode == 200)
            {
                if (dataResponse?.result.isSuccess)!
                {
                    print(dataResponse?.result.value! as Any);
                    let policies = try! JSONDecoder().decode(Policies.self, from: (dataResponse?.data!)!) as AnyObject
                    completionHandler(true, "", policies)
                } else {
                    completionHandler(false, TIMEOUT_OR_FAILIURE, nil)
                }
            }else if (dataResponse?.result.error?.localizedDescription == REQUEST_TIME_OUT) {
                completionHandler(false, REQUEST_TIMEOUT, nil)
            }
            else if (dataResponse?.response?.statusCode == 401)
            {
                completionHandler(false, INVALID_LOGING_ERROR, nil)
            }
            else {
                completionHandler(false, TIMEOUT_OR_FAILIURE, nil)
            }*/
        }
    }
    
    func getPendingTasks(userID: String, completionHandler:@escaping (_ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        
        let endPointURL = String(format: API_PendingTasks)
        let url =  URL(string:endPointURL as String)
        
        self.executePostService(requestUrl: url, httpBody: nil, httpMethod: "GET", isAuthorise: true) { (dataResponse, errMsg, isSuccess) in
            //Server code
            // 201 - success
            
            //TODO :For testing uncomment below code
            //Using Policy JSON file data for testing
            
            let fileData = JSONParser.getDataFromFile(fileName: "PendingTasks", fileExtension: "json")! as Data
            let policies = try! JSONDecoder().decode(Policies.self, from: fileData) as AnyObject
            completionHandler(true, "", policies)
            
            
            /*if (dataResponse?.response?.statusCode == 200)
             {
             if (dataResponse?.result.isSuccess)!
             {
             print(dataResponse?.result.value! as Any);
             let policies = try! JSONDecoder().decode(Policies.self, from: (dataResponse?.data!)!) as AnyObject
             completionHandler(true, "", policies)
             } else {
             completionHandler(false, TIMEOUT_OR_FAILIURE, nil)
             }
             }else if (dataResponse?.result.error?.localizedDescription == REQUEST_TIME_OUT) {
             completionHandler(false, REQUEST_TIMEOUT, nil)
             }
             else if (dataResponse?.response?.statusCode == 401)
             {
             completionHandler(false, INVALID_LOGING_ERROR, nil)
             }
             else {
             completionHandler(false, TIMEOUT_OR_FAILIURE, nil)
             }*/
        }
    }
    
    func getAllClaims(userID: String, completionHandler:@escaping (_ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        let endPointURL = String(format: API_Claims)
        let url =  URL(string:endPointURL as String)
        
        self.executePostService(requestUrl: url, httpBody: nil, httpMethod: "GET", isAuthorise: true) { (dataResponse, errMsg, isSuccess) in
            //Server code
            // 201 - success
            
            //TODO :For testing uncomment below code
            //Using Claims JSON file data for testing
            
            let fileData = JSONParser.getDataFromFile(fileName: "AllClaims", fileExtension: "json")! as Data
             let claims = try! JSONDecoder().decode(Claims.self, from: fileData) as AnyObject
             completionHandler(true, "", claims)
            
           /* if (dataResponse?.response?.statusCode == 200)
            {
                if (dataResponse?.result.isSuccess)!
                {
                    print(dataResponse?.result.value! as Any);
                    let claims = try! JSONDecoder().decode(Claims.self, from: (dataResponse?.data!)!) as AnyObject
                    completionHandler(true, "", claims)
                } else {
                    completionHandler(false, TIMEOUT_OR_FAILIURE, nil)
                }
            }else if (dataResponse?.result.error?.localizedDescription == REQUEST_TIME_OUT) {
                completionHandler(false, REQUEST_TIMEOUT, nil)
            }
            else if (dataResponse?.response?.statusCode == 401)
            {
                completionHandler(false, INVALID_LOGING_ERROR, nil)
            }
            else {
                completionHandler(false, TIMEOUT_OR_FAILIURE, nil)
            }*/
        }
    }
}

