//
//  SegmentationHandler.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/5/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

class SegmentationHandler : NSObject {
    
    class func getSegmentations(userID: String?, claimNumber: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        ServiceManager.sharedInstance.getSegmentations(userID: userID!, claimNumber: claimNumber!) { (isSuccess, errorMessage, response) in
            completionHandler(isSuccess, errorMessage, response)
        }
    }
}
