//
//  ServiceManager.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/6/18.
//  Copyright © 2018 virtusa. All rights reserved.
//

import Foundation
import Alamofire

public let REQUEST_TIME_OUT = "The request timed out."
public let REQUEST_TIME_OUT_CODE = "-1001"

class ServiceManager: NSObject {
    
    
    static let _sharedObject = ServiceManager()
    
    class var sharedInstance : ServiceManager {
        return _sharedObject
    }
    
    public func executeService(requestUrl:String?, httpMethod: HTTPMethod?, requestObject: [String: Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?,  completionHandler:@escaping (DataResponse<Any>?, _ error: Error?, _ isSucces: Bool) -> Void) {
        
        // check 'Request Objects' before Service calls
        guard (requestObject != nil && requestUrl != nil) || httpMethod == .get else {
            let errorTemp:Error = NSError.init(domain: "", code: ErrorCodes.kgenericerror, userInfo:ErrorHandler.sharedInstance.getErrorDictionary(String(ErrorCodes.kgenericerror), ErrorCodeType.kgenericerrorType)) as Error
            completionHandler(nil, errorTemp, false)
            return
        }
        
        let reachability:Bool = Utilities.isConnectedToNetwork()
        guard reachability  else {
            let errorTemp:Error = NSError.init(domain: "", code: ErrorCodes.kgenericerror, userInfo:ErrorHandler.sharedInstance.getErrorDictionary(String(ErrorCodes.knonetworkConnection), ErrorCodeType.kgenericerrorType)) as Error
            completionHandler(nil, errorTemp, false)
            return
        }
        
//        Alamofire.request(requestUrl!, method:httpMethod!, parameters: requestObject, encoding: encoding, headers: headers).responseJSON { (dataResponse) in
//            if dataResponse.error == nil {
//                completionHandler(dataResponse, nil, true)
//            } else {
//                completionHandler(dataResponse, dataResponse.error, false)
//            }
//        }
    }
    
    
    public func executePostService(requestUrl: URL?, httpBody: NSMutableDictionary?, httpMethod: String?, isAuthorise: Bool, completionHandler:@escaping (DataResponse<Any>?, _ error: Error?, _ isSucces: Bool) -> Void) {
        
        var request = URLRequest(url: requestUrl!)
        request.httpMethod = httpMethod
        
        if isAuthorise == true {
            request.allHTTPHeaderFields = getAccessToken()
        }
        
        if httpBody != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let data = try! JSONSerialization.data(withJSONObject: httpBody!, options: JSONSerialization.WritingOptions.prettyPrinted)
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
        }
        
        Alamofire.request(request as URLRequestConvertible)
            .responseJSON { response in
                completionHandler(response, nil, true)
        }
    }
    
    public func executeUploadService(fileURL: URL?, requestUrl: URL?, parameters: [String : Any], httpMethod: String?, completionHandler:@escaping (DataResponse<Any>?, _ error: Error?, _ isSucces: Bool) -> Void) {
        
        var request = URLRequest(url: requestUrl!)
        request.httpMethod = httpMethod
        //request.timeoutInterval = 1800
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Authorization" : "Bearer " + UserDefaults.standard.string(forKey: "AccessToken")!
        ]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //Add params
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            //Add file
            multipartFormData.append(fileURL!, withName: "file", fileName: "file.txt", mimeType: "text/html")
            
        }, usingThreshold: UInt64.init(), to: requestUrl!, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let err = response.error {
                        print("file upload error - \(err)")
                        completionHandler(nil, err, false)
                        return
                    }
                    completionHandler(response, response.error, true)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completionHandler(nil, error, false)
            }
        }
    }
    
    public func getAccessToken() -> HTTPHeaders {
        if (UserDefaults.standard.string(forKey: "UserName") != nil  &&  UserDefaults.standard.string(forKey: "Password") != nil ) {
            return ["user" : UserDefaults.standard.string(forKey: "UserName")!, "password" : UserDefaults.standard.string(forKey: "Password")!]
        }
        return [:]
        //return ["Authorization" : "Bearer" + " " + UserDefaults.standard.string(forKey: "AccessToken")!]
    }
    public func getRefreshToken() -> String {
        return UserDefaults.standard.string(forKey: "RefreshToken")!
    }
}

