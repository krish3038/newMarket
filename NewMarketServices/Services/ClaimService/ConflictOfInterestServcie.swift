//
//  ConflictOfInterestService.swift
//  NewMarketServices
//
//  Created by administrator on 31/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

final class ConflictOfInterestServcie {
    
    func getConflictOfInterestData(credentials: LoginReq, claimNo : String , completion: @escaping ( _ result:Any? ,_ error:Error?) ->Void){
        let networkManager = NetworkService.shared
        
        let serviceUrl = ServiceUrls.hostUrl + ServiceUrls.ConflictOfInterestServiceApi.conflictOfInterestUrl + claimNo
        
        let url = URL(string: serviceUrl)
        let headers = [Constants.RequestContext.CONTENT_TYPE_KEY:Constants.RequestContext.CONTENT_TYPE_VALUE, Constants.RequestContext.ACCEPT_KEY:Constants.RequestContext.ACCEPT_VALUE,
                       "user": credentials.userName,
                       "password": credentials.UserPwd]
        
        let request = Request(url: url!, path: nil, method: .get, bodyParams: nil,requestBodyData:nil, headers:headers as? [String : String] )
        
        networkManager.process(request) { ( data,error) in
            
            if error == nil {
                let parseResponse =  self.parseResponseData(data: data!)
                if parseResponse is NetworkErrorType {
                    completion(nil,parseResponse as? NetworkErrorType)
                }else{
                    completion(parseResponse,nil)
                }
            }else {
                completion(nil,error)
            }
        }
        
    }
    
    func sendConflictOfIntrestStatus(credentials: LoginReq, claimNo : String ,status : String , completion: @escaping ( _ result:Any? ,_ error:Error?) ->Void)
    {
        let networkManager = NetworkService.shared
        
        let serviceUrl = ServiceUrls.hostUrl + ServiceUrls.ConflictOfInterestServiceApi.conflictOfInterestPUTUrl + claimNo
    
        let url = URL(string: serviceUrl)
        let headers = [Constants.RequestContext.CONTENT_TYPE_KEY:Constants.RequestContext.CONTENT_TYPE_VALUE, Constants.RequestContext.ACCEPT_KEY:Constants.RequestContext.ACCEPT_VALUE,
                       "user": credentials.userName,
                       "password": credentials.UserPwd]
        let conflicOfIntrestStatus = ConflictStatus(ClaimMode: status)
        let post = ConflictOfIntrestPUTModel(data: conflicOfIntrestStatus)
        print("Put : \(post)")

        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(post)
            let request = Request(url: url!, path: nil, method: .get, bodyParams: nil,requestBodyData:jsonData, headers:headers as? [String : String] )
            
            networkManager.process(request) { ( data,error) in
                
                if error == nil {
                    let parseResponse =  self.parseResponseData(data: data!)
                    if parseResponse is NetworkErrorType {
                        completion(nil,parseResponse as? NetworkErrorType)
                    }else{
                        completion(parseResponse,nil)
                    }
                }else {
                    completion(nil,error)
                }
            }
          print("jsonData: ", String(data: request.requestBodyData!, encoding: .utf8) ?? "no body data")
        } catch {
            print("Error : \(error.localizedDescription)")
        }
        
    }
    
    func parseResponseData(data:Any) -> Any? {
        // Parse data
        
        do {
            /*Login Response Data */
            //return try JSONDecoder().decode(Login.self, from: data as! Data)
            return try  ConflictOfInterestResponse.decode(data: data as! Data)
        }
        catch {
            return  NetworkErrorType.JSONParseError
        }
        
    }
}
