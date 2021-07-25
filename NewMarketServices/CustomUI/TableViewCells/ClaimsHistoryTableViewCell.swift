//
//  ClaimsHistoryTableViewCell.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/12/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class ClaimsHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var policyNumberLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var policyType: UILabel!
    @IBOutlet weak var policyDate: UILabel!
    @IBOutlet weak var policyExpiryDateLabel: UILabel!
    @IBOutlet weak var premiumStatusLabel: UILabel!
    @IBOutlet weak var actionRequiredLabel: UILabel!
    @IBOutlet weak var dateUpdatedLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    
    private static let displayDateFormat = "dd-MMM-yyyy"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func clearAll()  {
        policyNumberLabel.text = ""
        companyNameLabel.text = ""
        policyType.text = ""
        policyDate.text = ""
        policyExpiryDateLabel.text = ""
        premiumStatusLabel.text = ""
        actionRequiredLabel.text = ""
        dateUpdatedLabel.text = ""
        modeLabel.text = ""
    }
    
    func setDataforCell(index: Int, policy: Policy?)  {
        self.clearAll()
        if (index % 2 == 0)
        {
            self.contentView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        } else {
            self.contentView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
        }
        
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
 
            if (policy!.policyNumber != nil)
            {
                self.policyNumberLabel.text = policy!.policyNumber
            }
            if (policy!.companyName != nil)
            {
                self.companyNameLabel.text = policy!.companyName
            }
            if (policy!.policyType != nil)
            {
                self.policyType.text = policy!.policyType
            }
            
            if (policy!.policyEffectiveDate != nil)
            {
                self.policyDate.text = DateUtilities.formattedDate(policy!.policyEffectiveDate!, dateFormat: ClaimsHistoryTableViewCell.displayDateFormat)
            }
            if (policy!.policyExpiryDate != nil)
            {
                self.policyExpiryDateLabel.text = DateUtilities.formattedDate(policy!.policyExpiryDate!, dateFormat: ClaimsHistoryTableViewCell.displayDateFormat)
            }
            
            if (policy!.premiumStatus != nil)
            {
                self.premiumStatusLabel.text = policy!.premiumStatus
            }
            if (policy!.mode != nil)
            {
                self.modeLabel.text = policy!.mode
            }
            
            if (policy!.dateUpdated != nil)
            {
                self.dateUpdatedLabel.text = DateUtilities.formattedDate(policy!.dateUpdated!, dateFormat: ClaimsHistoryTableViewCell.displayDateFormat)
            }
            
            if (policy!.actionRequired != nil)
            {
                self.actionRequiredLabel.text = policy!.actionRequired
            }
        }
    }
    
}
