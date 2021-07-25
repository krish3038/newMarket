//
//  MyCasesService.swift
//  NewMarketServices
//
//  Created by administrator on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

final class MyCasesService {
    
    func getMyCases(credentials: LoginReq, completion: @escaping ( _ result:Any? ,_ error:Error?) ->Void){
        let networkManager = NetworkService.shared
        
        let serviceUrl = ServiceUrls.hostUrl + ServiceUrls.MyCasesServiceApi.myCasesUrl
        
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
    
    func parseResponseData(data:Any) -> Any? {
        // Parse data
        
        do {
            /*Login Response Data */
            //return try JSONDecoder().decode(Login.self, from: data as! Data)
            return try  MyCasesResponse.decode(data: data as! Data)
        }
        catch {
            return  NetworkErrorType.JSONParseError
        }
    }
}

