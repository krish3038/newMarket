//
//  ServiceManager+Search.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/12/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
extension ServiceManager {
    
    func getSearchHistory(userID: String?, searchString: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        
        let endPointURL = String(format: API_SearchClaimHistory)
        let url =  URL(string:endPointURL as String)
        
        self.executePostService(requestUrl: url, httpBody: nil, httpMethod: "GET", isAuthorise: true) { (dataResponse, errMsg, isSuccess) in
            //Server code
            // 201 - success
            
            //TODO :For testing uncomment below code
            //Using Policy JSON file data for testing
            
             let fileData = JSONParser.getDataFromFile(fileName: "ClaimsHistory", fileExtension: "json")! as Data
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
    
    func getClaimsFromSearchString(userID: String?, searchString: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        
        let endPointURL = String(format: API_SearchClaimHistoryWithString+searchString!)
        let url =  URL(string:endPointURL as String)
        
        self.executePostService(requestUrl: url, httpBody: nil, httpMethod: "GET", isAuthorise: true) { (dataResponse, errMsg, isSuccess) in
            //Server code
            // 201 - success
            
            //TODO :For testing uncomment below code
            //Using Policy JSON file data for testing
            
            let fileData = JSONParser.getDataFromFile(fileName: "SearchClaim", fileExtension: "json")! as Data
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
}

