//
//  ClaimAndPolicyHandler.swift
//  NewMarketServices
//
//  Created by admin on 11/06/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

class ClaimAndPolicyHandler: NSObject {
    class func getClaimAndPolicyDetailsFor(claimID: String, policyID: String, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void) {
        ServiceManager.sharedInstance.getClaimAndPolicyDetailsFor(claimID: "", policyID: "") { (isSuccess, errorMessage, response) in
            completionHandler(isSuccess, errorMessage, response)
        }
    }
}

