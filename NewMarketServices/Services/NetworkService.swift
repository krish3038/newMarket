//
//  NetworkService.swift
//  NewMarketServices
//
//  Created by administrator on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
import Foundation

enum ResponseStatus :String {
    case Success = "200"
    case InternalError = "400"
}

enum HTTPMethod: String {
    case get, post, put, patch, delete
}

enum NetworkErrorType : Error {
    case NoInternetConnection
    case JSONParseError
    
}

struct Request {
    var url : URL
    var path        : String?
    var method      : HTTPMethod
    var bodyParams  : [String: Any]?
    var requestBodyData : Data?
    var headers     : [String: String]?
}

final class NetworkService :NSObject,URLSessionDataDelegate {
    
    //MARK : Properties
    static let shared = NetworkService()
    
    var token:String!
    
    private override init() {
        
    }
    
    
    //MARK : Accessors
    
    func process(_ request:Request, completion:  @escaping (_ responseData:Any?, _ error:Error? )->Void){
        
        //Reachability
        if Utilities.isNetworkNotReachable(){
            completion(nil, NetworkErrorType.NoInternetConnection)
            return
        }
        
        // Request Configuration
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 20//300.0
        sessionConfiguration.timeoutIntervalForResource = 30//400.0
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: .main)
        let requestObj = NSMutableURLRequest(url: request.url)
        requestObj.httpMethod = request.method.rawValue
        
        if let headers = request.headers{
            updateRequestHeaders(requestObj, headers)
        }
        if let bodyParams = request.bodyParams{
            let  jsonData = try? JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
            requestObj.httpBody = jsonData
        }else if (request.requestBodyData != nil){
            requestObj.httpBody = request.requestBodyData
        }
        
        // Network Call
        let dataTask = session.dataTask(with: requestObj as URLRequest) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil,error)
            }else{
                guard let data = data else {
                    return completion(nil,error)
                }
                if let response = response as? HTTPURLResponse,  response.statusCode == 200 {
                    completion(data,nil)
                }
            }
        }
        
        dataTask.resume()
        
    }
    
    //    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    //
    //    }
    
    func updateRequestHeaders(_ request:NSMutableURLRequest , _ headers:[String:String]) {
        for (key,value) in headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
