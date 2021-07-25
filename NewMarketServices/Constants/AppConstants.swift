//
//  AppConstants.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/1/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

//Server API URL's
//public let BaseURL = "http://34.246.21.248:3000"
public let AllClaimsURL = BaseURL + "/api/queries/selectAllClaim"
public let AllPoliciesURL = BaseURL + "/api/queries/selectAllPolicy"
public let SearchHistory = BaseURL + "/api/queries/selectAllPolicy"

public let BaseURL = "http://34.246.21.248:3001"
public let API_Login = BaseURL + "/login"
public let API_Claims = BaseURL + "/Claims"
public let API_PendingTasks = BaseURL + "/ClaimDetails/Pending"
public let API_ClaimDetails = BaseURL + "/ClaimDetails/"
public let API_ClaimInvestigate = BaseURL + "/ClaimInvestigate/"
public let API_SearchClaimHistory = BaseURL + "/ClaimHistory"
public let API_SearchClaimHistoryWithString = BaseURL + "/ClaimHistory/"

public let API_Segmentation = BaseURL + "/ClaimHistory"
public let API_ClaimJourney = BaseURL + "/ClaimHistory"
public let API_ClaimJourney_Segmentation = BaseURL + "/ClaimHistory"
public let API_ClaimJourney_ClaimPayment = BaseURL + "/ClaimHistory"
// Segue's Names
struct SegueIdentifier {
    static let kMoveToDashBoard = "MoveToDashBoard"
    static let kMoveToLoginScreen = "LoginScreen"
}

struct AlertController {
    static let tabTitle = "\t"
    static let spaceMessage = "\n\n\n\n\n\n\n\n\n\n\n"
}

struct ErrorCodes {
    static let kgenericerror = 3000
    static let knonetworkConnection = 999
}

struct ErrorCodeType {
    static let kgenericerrorType = "GenericError"
    static let kConfigurationError = "ConfigurationError"
}

struct CustomDateFormat  {
    static let kDisplayDateFormat = "dd-MMM-yyyy"
}

struct CustomColors  {
   // static let kCommonBlue = UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
}

struct Constants {
    
    struct RequestContext {
        static let CONTENT_TYPE_KEY = "Content-Type"
        static let CONTENT_TYPE_VALUE = "application/json"
        static let ACCEPT_KEY = "Accept"
        static let ACCEPT_VALUE = "application/json"
        static let AUTHORIZATION_KEY = "Authorization"
    }
}

// Constant message/text
public let EMPTY_LOGIN_FIELDS = "Please enter your login credentials."
public let EMPTY_USERNAME_ERROR = "Please enter your username."
public let EMPTY_PASSWORD_ERROR = "Please enter your password."
public let INVALID_LOGING_ERROR  = "Please enter valid username and password."
public let NO_NETWORK_AVAILABLE = "No Network available. \nPlease check the network and try again."
public let MAINTANANCE_IN_PROGRESS = "Maintenance in progress, please try again later."
public let REQUEST_TIMEOUT = "The request timed out. Please try again."
public let TIMEOUT_OR_FAILIURE = "OOPS ! Our server is down at the moment. \nPlease try again after sometime."
