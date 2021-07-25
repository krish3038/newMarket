//
//  DashboardViewController.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/11/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

enum PolicyParameters: String {
    case ClaimNumber = "Claim Number"
    case PolicyNumber = "Policy Number"
    case CompanyName = "Company Name"
    case PoliceType = "Police Type"
    case PoliceEffectiveDate = "Police Effective Date"
    case PolicyExpiryDate = "Policy Expiry Date"
    case DateofLoss = "DateofLoss"
    case ActionRequired = "Action Required"
}

class DashboardViewController: BaseViewController {
    
    @IBOutlet weak var claimsHistoryTableView: UITableView!
    @IBOutlet weak var policyDetailsTableView: UITableView!
    
    @IBOutlet weak var userTitleView: UIView!
    @IBOutlet weak var policyDetailsBGView: UIView!
    
    @IBOutlet weak var investigateButton: UIButton!
    
    var policyParameters :[String] = ["Claim Number",
                                      "Policy Number",
                                      "Company Name",
                                      "Police Type",
                                      "Police Effective Date",
                                      "Policy Expiry Date",
                                      "Date of Loss",
                                      "Action Required"]
    var claimsList: [Claim] = [Claim]()
    var policiesList: [Policy] = [Policy]()
    var currentPlocyDetails: Policy?
    
    @IBOutlet weak var userNextTaskLabel: UILabel!
    
    @IBAction func investigateOnButtonClicked(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Custom UIDesign Configuration
        self.customUIDesignConfiguration()
        
        // Get all policy details from server call
        self.getPendingTask(userID: "")
        
        if let username = UserDefaults.standard.string(forKey: "UserName") {
            userNextTaskLabel.text = "Hello \(username), your next task is:"
        }else {
            userNextTaskLabel.text = "Hello, your next task is:"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: - Get ClaimDetails Service Integration
    func getPendingTask(userID: String){
        self.showActivityIndicator()
        DashboardHandler.getPendingTasks(userID: "") { [weak self] (isSuccess, errorMessage, response) in
            self?.stopActivityIndicator()
            guard let weakSelf = self else {
                return
            }
            if isSuccess == true {
                if let policies:Policies =  response as? Policies {
                    if policies.policyList != nil {
                        weakSelf.policiesList = policies.policyList!
                        print("Policy List\(String(describing: response))")
                        print("Policy List\(weakSelf.policiesList)")
                        //TableView reload
                        DispatchQueue.main.async {
                            if (weakSelf.policiesList.count > 0) {
                                weakSelf.currentPlocyDetails = weakSelf.policiesList[0]
                                weakSelf.policyDetailsTableView.reloadData()
                            }
                        }
                    }
                }
            }else {
                
                weakSelf.showSimpleAlert(title: "", message: errorMessage!, actionTitle: "Ok")
                //TODO
                /*if (errorMessage == REQUEST_TIMEOUT)
                 {
                 weakSelf.showAlertWithAction(title: "", message: errorMessage, actionTitles: ["TryAgain", "Cancel"], actions: [{tryAgationAction in
                 if (weakSelf.claimsList.count > 0) {
                 let claim: Claim = weakSelf.claimsList.first!
                 weakSelf.getPolicyDetails(claimNumber: claim.claimNumber!)
                 }
                 }])
                 }else{
                 weakSelf.showSimpleAlert(title: "", message: errorMessage!, actionTitle: "Ok")
                 }*/
            }
            
             weakSelf.getAllClaims(userID: "")
        }
    }
    
    //Mark: - Get ClaimDetails Service Integration
    func getPolicyDetails(userID: String, claimNumber: String){
        self.showActivityIndicator()
        DashboardHandler.getPolicyDetails(userID: "", claimNumber: claimNumber) { [weak self] (isSuccess, errorMessage, response) in
            self?.stopActivityIndicator()
            guard let weakSelf = self else {
                return
            }
            if isSuccess == true {
                if let policies:Policies =  response as? Policies {
                    if policies.policyList != nil {
                        weakSelf.policiesList = policies.policyList!
                        print("Policy List\(String(describing: response))")
                        print("Policy List\(weakSelf.policiesList)")
                        //TableView reload
                        DispatchQueue.main.async {
                            if (weakSelf.policiesList.count > 0) {
                                weakSelf.currentPlocyDetails = weakSelf.policiesList[0]
                                weakSelf.policyDetailsTableView.reloadData()
                            }
                        }
                    }
                }
            }else {
                
                weakSelf.showSimpleAlert(title: "", message: errorMessage!, actionTitle: "Ok")
                //TODO 
                /*if (errorMessage == REQUEST_TIMEOUT)
                {
                    weakSelf.showAlertWithAction(title: "", message: errorMessage, actionTitles: ["TryAgain", "Cancel"], actions: [{tryAgationAction in
                        if (weakSelf.claimsList.count > 0) {
                            let claim: Claim = weakSelf.claimsList.first!
                            weakSelf.getPolicyDetails(claimNumber: claim.claimNumber!)
                        }
                        }])
                }else{
                    weakSelf.showSimpleAlert(title: "", message: errorMessage!, actionTitle: "Ok")
                }*/
            }
        }
    }
    
    //Mark: - Get all Claims Service Integration
    func getAllClaims(userID: String) {
        self.showActivityIndicator()
        DashboardHandler.getAllClaims(userID: userID) { [weak self] (isSuccess, errorMessage, response) in
            self?.stopActivityIndicator()
            guard let weakSelf = self else {
                return
            }
            if isSuccess == true {
                if let claims:Claims =  response as? Claims {
                    if claims.claimlist != nil {
                        weakSelf.claimsList = claims.claimlist!
                        print("Claim List\(String(describing: response))")
                        print("Claim List\(weakSelf.claimsList)")
                        
                        //TableView reload
                        DispatchQueue.main.async {
                            if (weakSelf.claimsList.count > 0){
                                //weakSelf.slectedCliamDetails = weakSelf.claimsList[0]
                                weakSelf.claimsHistoryTableView.reloadData()
                            }
                        }
                        /*if (weakSelf.claimsList.count > 0) {
                            let claim: Claim = weakSelf.claimsList.first!
                            weakSelf.getPolicyDetails(claimNumber: claim.claimNumber!)
                        }*/
                    }
                }
            }else {
                weakSelf.showSimpleAlert(title: "", message: errorMessage!, actionTitle: "Ok")
            }
            
            
        }
    }
    
    // MARK: - UI Design configuration
    func customUIDesignConfiguration() {
        
        //InvestigateButton design configuration
        investigateButton.layer.cornerRadius = 5
        
        //claimsHistoryTableView
        self.addTopRightCornerMaskLayer()
    }
    
    // MARK: - Add RectCorner masklayer for View
    func addTopRightCornerMaskLayer() {
        //Add RectCorner masklayer for userTitleView
        self.userTitleView.addCorner(corner: UIRectCorner.topRight, size: CGSize(width: 15, height:15))
        //Add RectCorner masklayer for policyDetailsBGView
        self.policyDetailsBGView.addCorner(corner: UIRectCorner.topRight, size: CGSize(width: 15, height:15))
        self.viewWillLayoutSubviews()
    }
    
    
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "SearchVC" {
            
        }else if segue.identifier == "ClaimAndPolicyVC" {
            let claimAndPolicyVC = segue.destination as! ClaimAndPolicyViewController
            claimAndPolicyVC.claimNo = (currentPlocyDetails?.claimNumber)!
        }
     }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if(tableView.tag == 1){
            count = claimsList.count
        }else if(tableView.tag == 2){
            count = policyParameters.count
        }
        return count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = nil
        switch tableView.tag {
        case 1:
            let claimTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ClaimTableViewCell", for: indexPath) as! ClaimTableViewCell
            //Set up the cell contents
            claimTableViewCell.setDataforCell(index: indexPath.row, claim: claimsList[indexPath.row])
            claimTableViewCell.selectionStyle = .none
            cell = claimTableViewCell
        case 2:
            let policyDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PolicyDetailsTableViewCell", for: indexPath) as! PolicyDetailsTableViewCell
            //Set up the cell contents
            let key = policyParameters[indexPath.row]
            policyDetailsTableViewCell.setDataforCell(key: key, policy: currentPlocyDetails)
            policyDetailsTableViewCell.selectionStyle = .none
            cell = policyDetailsTableViewCell
        default:
            break
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView.tag == 1){
            print("ClaimTableViewCell -- didSelectRowAt --->\(indexPath.row)")
        }
    }
}




