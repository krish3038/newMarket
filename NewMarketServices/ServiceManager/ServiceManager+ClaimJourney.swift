//
//  ServiceManager+ClaimJourney.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/9/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
extension ServiceManager {
    
    func getSegmentations1(userID: String?, claimNumber: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        
        let endPointURL = String(format: API_ClaimJourney_Segmentation)
        let url =  URL(string:endPointURL as String)
        
        self.executePostService(requestUrl: url, httpBody: nil, httpMethod: "GET", isAuthorise: true) { (dataResponse, errMsg, isSuccess) in
            //Server code
            // 201 - success
            
            //TODO :For testing uncomment below code
            //Using AdditionalInfo JSON file data for testing
            
            let fileData = JSONParser.getDataFromFile(fileName: "AdditionalInfo", fileExtension: "json")! as Data
            let policies = try! JSONDecoder().decode(AdditionalInfos.self, from: fileData) as AnyObject
            completionHandler(true, "", policies)
            
            
            /*if (dataResponse?.response?.statusCode == 200)
             {
             if (dataResponse?.result.isSuccess)!
             {
             print(dataResponse?.result.value! as Any);
             let policies = try! JSONDecoder().decode(AdditionalInfos.self, from: (dataResponse?.data!)!) as AnyObject
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
    
    func getClaimPayment(userID: String?, claimNumber: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        
        let endPointURL = String(format: API_ClaimJourney_ClaimPayment)
        let url =  URL(string:endPointURL as String)
        
        self.executePostService(requestUrl: url, httpBody: nil, httpMethod: "GET", isAuthorise: true) { (dataResponse, errMsg, isSuccess) in
            //Server code
            // 201 - success
            
            //TODO :For testing uncomment below code
            //Using ClaimPayment JSON file data for testing
            
            let fileData = JSONParser.getDataFromFile(fileName: "ClaimPayment", fileExtension: "json")! as Data
            let claimPayments = try! JSONDecoder().decode(ClaimPayments.self, from: fileData) as AnyObject
            completionHandler(true, "", claimPayments)
            
            
           /* if (dataResponse?.response?.statusCode == 200)
             {
             if (dataResponse?.result.isSuccess)!
             {
             print(dataResponse?.result.value! as Any);
             let claimPayments = try! JSONDecoder().decode(ClaimPayments.self, from: (dataResponse?.data!)!) as AnyObject
             completionHandler(true, "", claimPayments)
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
