//
//  DashboardHandler.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/11/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class DashboardHandler: NSObject {
    
    class func getPolicyDetails(userID: String?, claimNumber: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        ServiceManager.sharedInstance.getPolicyDetails(userID: userID!, claimNumber: claimNumber!) { (isSuccess, errorMessage, response) in
            completionHandler(isSuccess, errorMessage, response)
        }
    }
    
    class func getPendingTasks(userID: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        ServiceManager.sharedInstance.getPendingTasks(userID: userID!) { (isSuccess, errorMessage, response) in
            completionHandler(isSuccess, errorMessage, response)
        }
    }
    
    class func getAllClaims(userID: String?, completionHandler: @escaping (_ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        ServiceManager.sharedInstance.getAllClaims(userID: userID!) {
            (isSuccess, errorMessage, response) in
            completionHandler(isSuccess, errorMessage, response)
        }
    }
}
