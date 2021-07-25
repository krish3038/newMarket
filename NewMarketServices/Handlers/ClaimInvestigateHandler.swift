//
//  ClaimInvestigateHandler.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 6/19/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class ClaimInvestigateHandler: NSObject {
    
    class func getClaimInvestigateDetails(userID: String?, claimNumber: String?, completionHandler: @escaping ( _ isSuccess: Bool?, _ errorMessage: String?, _ response: AnyObject?) -> Void)
    {
        ServiceManager.sharedInstance.getClaimInvestigateDetails(userID: userID!, claimNumber: claimNumber!) { (isSuccess, errorMessage, response) in
            completionHandler(isSuccess, errorMessage, response)
        }
    }
}

