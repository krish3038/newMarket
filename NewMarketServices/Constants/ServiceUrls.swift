//


import Foundation
struct ServiceUrls {
    static let hostUrl = "http://34.246.21.248:3001/"
    
    struct LoginServiceApi{
        static let loginUrl = "login"
    }
    
    struct MypolicyServiceApi{
        static let myPolicyUrl = "MyPolicy"
        
    }
    struct MyCasesServiceApi{
        static let myCasesUrl = "MyCases"
        
    }
    
    struct ClaimInvestigateServiceApi{
        static let claimInvestigateUrl = "ClaimInvestigate/"
        
    }
    
    struct ClaimSettlementServiceApi{
        static let claimSettlementUrl = "getClaimSettlement/"
        
    }
    
    struct ClaimEvaluationServiceApi{
        static let claimEvaluationUrl = "ClaimEvaluation/"
        
    }
    
    struct ClaimPremiumCheckServiceApi{
        static let claimPremiumCheckUrl = "ClaimPremiumCheck/"
    }
    
    struct ClaimHousekeepCheckServiceApi{
        static let claimHousekeepCheckUrl = "HouseKeepCheck/"
        
        
    }
    
    struct ConflictOfInterestServiceApi{
        static let conflictOfInterestUrl = "getConflictOfInterest/"
        static let conflictOfInterestPUTUrl = "ClaimConflict/"

        
    }
    
    struct PDFType{
        static let CLAIM_PDF = "claimpdf/"
        static let POLICY_PDF = "PolicyPDF/"
    }
    
}
