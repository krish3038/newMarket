//
//  SearchHandler.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/12/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

class SearchHandler : NSObject {
    
    class func getSearchHistory(userID: String?, searchString: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        ServiceManager.sharedInstance.getSearchHistory(userID: userID!, searchString: searchString!) { (isSuccess, errorMessage, response) in
            completionHandler(isSuccess, errorMessage, response)
        }
    }
    
    class func getClaimsFromSearchString(userID: String?, searchString: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        ServiceManager.sharedInstance.getClaimsFromSearchString(userID: userID!, searchString: searchString!) { (isSuccess, errorMessage, response) in
            completionHandler(isSuccess, errorMessage, response)
        }
    }
}

