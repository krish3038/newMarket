//
//  ServiceManager+ClaimInvestigate.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 6/19/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

extension ServiceManager {
    
    func getClaimInvestigateDetails(userID: String, claimNumber: String, completionHandler:@escaping (_ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        
        let endPointURL = String(format: API_ClaimInvestigate + claimNumber)
        let url =  URL(string:endPointURL as String)
        
        self.executePostService(requestUrl: url, httpBody: nil, httpMethod: "GET", isAuthorise: true) { (dataResponse, errMsg, isSuccess) in
            //Server code0
            // 201 - success
            
            
            let fileData = JSONParser.getDataFromFile(fileName: "ClaimInvestigate", fileExtension: "json")! as Data
            let claimInvestigates = try! JSONDecoder().decode(ClaimInvestigates.self, from: fileData) as AnyObject
             completionHandler(true, "", claimInvestigates)
            
            
           /* if (dataResponse?.response?.statusCode == 200)
            {
                if (dataResponse?.result.isSuccess)!
                {
                    print(dataResponse?.result.value! as Any);
                    let claimInvestigates = try! JSONDecoder().decode(ClaimInvestigates.self, from: (dataResponse?.data!)!) as AnyObject
                    completionHandler(true, "", claimInvestigates)
                } else {
                    completionHandler(false, TIMEOUT_OR_FAILIURE, nil)
                }
            }
            else if (dataResponse?.result.error?.localizedDescription == REQUEST_TIME_OUT) {
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

