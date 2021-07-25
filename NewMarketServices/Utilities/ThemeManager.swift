//
//  ThemeManager.swift
//  NewMarketServices
//
//  Created by admin on 25/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit
import Foundation

/*
 /claimparties/100
 
 {
 "jsonObj": [
 {
 "ClaimNumber": "100",
 "owner": "JohnWhite",
 "LeadCarrier": "JohnWhite",
 "PlacingBroker": "DavidCoker",
 "ClaimsBroker": "GaingKim",
 "OverseasBroker": "JohnWhite",
 "PolicyOwner": "James Estate",
 "Followers1": "SIC10",
 "Followers2": "ABCUW",
 "Followers3": "SIC10",
 "Followers4": "ABCUW"
 }
 ]
 }
*/

enum Theme: String {
    case Broker = "Claims Broker"
    case Policyholder = "Policy Holder"
    case CarrierAndFollower = "Claims Technician"
    case TechnicalAccountant = "Technical Accountant"
    case PlacingBroker = "Placing Broker"
    
    var backgroundColor: UIColor {
        switch self {
        case .Broker, .PlacingBroker:
            return UIColor(red: 162/255, green: 28/255, blue: 33/255, alpha: 1.0) //Red
        case .Policyholder:
            return UIColor(red: 34/255, green: 157/255, blue: 212/255, alpha: 1.0) //Sky Blue
        case .CarrierAndFollower, .TechnicalAccountant:
            return UIColor(red: 0/255, green: 83/255, blue: 172/255, alpha: 1.0) //Dark Blue
        }
    }
}

// Enum declaration
let SelectedThemeKey = "SelectedTheme"

// This will let you use a theme in the app.
class ThemeManager {
    
    // ThemeManager
    static func currentTheme() -> Theme {

        if let storedTheme = UserDefaults.standard.string(forKey: SelectedThemeKey) {
            return Theme(rawValue: storedTheme)!
        } else {
            return .CarrierAndFollower
        }
    }
    
    static func applyTheme(theme: Theme) {
        // First persist the selected theme using NSUserDefaults.
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()
    }
}
