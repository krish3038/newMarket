//
//  ClaimInvestigateManager.swift
//  NewMarketServices
//
//  Created by administrator on 30/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

class ClaimInvestigateManager {
    
    //MARK : Properties
    
    static let shared = ClaimInvestigateManager()
    var claimInvestigateData:ClaimInvestigateRecord?
    var selectedMyCaseTask : EachCase?
    private init() {
        
    }
    
}
