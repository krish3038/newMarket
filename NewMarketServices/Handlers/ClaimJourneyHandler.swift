//
//  ClaimJourneyHandler.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/9/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
class ClaimJourneyHandler : NSObject {
    
    class func getSegmentations(userID: String?, claimNumber: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        ServiceManager.sharedInstance.getSegmentations1(userID: userID!, claimNumber: claimNumber!) { (isSuccess, errorMessage, response) in
            completionHandler(isSuccess, errorMessage, response)
        }
    }
    
    class func getClaimPayment(userID: String?, claimNumber: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        ServiceManager.sharedInstance.getClaimPayment(userID: userID!, claimNumber: claimNumber!) { (isSuccess, errorMessage, response) in
            completionHandler(isSuccess, errorMessage, response)
        }
    }
}
