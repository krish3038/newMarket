//
//  ClaimPdfService.swift
//  NewMarketServices
//
//  Created by Sai Manikanta Siva Koti on 01/08/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

final class ClaimPdfService: NSObject
{
    func getClaimPdf(credentials: LoginReq, claimNo : String ,pdfService:String, completion: @escaping ( _ result:Any? ,_ error:Error?) ->Void){
        let networkManager = NetworkService.shared
        var serviceUrl : String = ""
        if pdfService == ServiceUrls.PDFType.POLICY_PDF {
            let urlString = claimNo.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            serviceUrl = ServiceUrls.hostUrl + pdfService + urlString!
        }
        else
        {
            serviceUrl = ServiceUrls.hostUrl + pdfService + claimNo
        }
        let url = URL(string: serviceUrl)
        let headers = [Constants.RequestContext.CONTENT_TYPE_KEY:Constants.RequestContext.CONTENT_TYPE_VALUE, Constants.RequestContext.ACCEPT_KEY:Constants.RequestContext.ACCEPT_VALUE,
                       "user": credentials.userName,
                       "password": credentials.UserPwd]
        
        let request = Request(url: url!, path: nil, method: .get, bodyParams: nil,requestBodyData:nil, headers:headers as? [String : String] )
        
        networkManager.process(request) { ( data,error) in
            
            if error == nil {
                let parseResponse =  self.parseResponseData(data: data!,pdfType:pdfService)
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
    
    func parseResponseData(data:Any , pdfType:String) -> Any? {
        // Parse data
        
        do {
            if pdfType == ServiceUrls.PDFType.CLAIM_PDF
            {
                return try  ClaimPdfResponse.decode(data: data as! Data)
                
            }
            else if pdfType == ServiceUrls.PDFType.POLICY_PDF
            {
                return try  PolicyPdfResponse.decode(data: data as! Data)
                
            }
            return (Any).self
            /*Login Response Data */
            //return try JSONDecoder().decode(Login.self, from: data as! Data)
        }
        catch {
            return  NetworkErrorType.JSONParseError
        }
    }
}
