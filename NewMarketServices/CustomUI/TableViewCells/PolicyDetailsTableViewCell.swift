//
//  PolicyDetailsTableViewCell.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/11/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class PolicyDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    private static let displayDateFormat = "dd-MMM-yyyy"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    /*
     ["Claim Number",
     "Policy Number",
     "Company Name",
     "Police Type",
     "Police Effective Date",
     "Policy Expiry Date",
     "Date of Loss",
     "Action Required"]
     */
    func setDataforContentCell(key: String, value: String)  {
        self.nameLabel.text = key
        self.valueLabel.text = value
    }
    func setDataforCell(key: String, policy: Policy?)  {
        self.nameLabel.text = key
        self.valueLabel.text = ""
        if (policy != nil) {
            
            print("\nclaim Claim Number---> \(String(describing: policy?.claimNumber))")
            print("\nclaim Policy Number---> \(String(describing: policy?.policyNumber))")
            print("\nclaim companyName---> \(String(describing: policy?.companyName))")
            
            print("\nclaim policyType---> \(String(describing: policy?.policyType))")
            print("\nclaim policyEffectiveDate---> \(String(describing: policy?.policyEffectiveDate))")
            
            print("\nclaim policyExpiryDate---> \(String(describing: policy?.policyExpiryDate))")
            
            print("\nclaim Date of Loss---> \(String(describing: policy?.premiumStatus))")
            
            print("\nclaim policyStatus---> \(String(describing: policy?.policyStatus))")
            print("\nclaim actionRequired---> \(String(describing: policy?.actionRequired))")
            
            if (key == "Claim Number" && (policy!.claimNumber != nil))
            {
                self.valueLabel.text = policy!.claimNumber
            }else if (key == "Policy Number" && (policy!.policyNumber != nil))
            {
                self.valueLabel.text = policy!.policyNumber
            }else if (key == "Company Name" && (policy!.companyName != nil))
            {
                self.valueLabel.text = policy!.companyName
            }else if (key == "Police Type" && (policy!.policyType != nil))
            {
                self.valueLabel.text = policy!.policyType
            }
            else if (key == "Police Effective Date" && (policy!.policyEffectiveDate != nil))
            {
                //self.valueLabel.text = policy!.policyEffectiveDate
                self.valueLabel.text = DateUtilities.formattedDate(policy!.policyEffectiveDate!, dateFormat: PolicyDetailsTableViewCell.displayDateFormat)
            }else if (key == "Policy Expiry Date" && (policy!.policyExpiryDate != nil))
            {
                //self.valueLabel.text = policy!.policyExpiryDate
                self.valueLabel.text = DateUtilities.formattedDate(policy!.policyExpiryDate!, dateFormat: PolicyDetailsTableViewCell.displayDateFormat)
            }
            /*else if (key == "Premium Status" && (policy!.premiumStatus != nil))
            {
                self.valueLabel.text = policy!.premiumStatus
            }else if (key == "Policy Status" && (policy!.policyStatus != nil))
            {
                self.valueLabel.text = policy!.policyStatus
            }*/
            else if (key == "Date of Loss" && (policy!.dateOfLoss != nil))
            {
                //self.valueLabel.text = policy!.dateOfLoss
                self.valueLabel.text = DateUtilities.formattedDate(policy!.dateOfLoss!, dateFormat: PolicyDetailsTableViewCell.displayDateFormat)
            }
            else if (key == "Action Required" && (policy!.actionRequired != nil))
            {
                self.valueLabel.text = policy!.actionRequired
            }
        }
    }
}
