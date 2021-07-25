//
//  ClaimTableViewCell.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/6/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

enum ClaimStatus: String {
    case Active = "Active"
    case Processing = "Processing"
    case Inactive = "Inactive"
    case Completed = "Completed"
}

class ClaimTableViewCell: UITableViewCell {
    
    private static let displayDateFormat = "dd-MMM-yyyy"
    
    @IBOutlet weak var claimIDLabel: UILabel!
    @IBOutlet weak var claimCompanyLabel: UILabel!
    @IBOutlet weak var claimDateLabel: UILabel!
    @IBOutlet weak var movementDateLabel: UILabel!
    @IBOutlet weak var colorStatusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorStatusView.cornerRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setDataforCell(index: Int, claim: Claim) {
        colorStatusView.backgroundColor = UIColor.clear
        if (index % 2 == 0)
        {
            self.contentView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        } else {
            self.contentView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
        }
        claimIDLabel.text = claim.claimNumber
        claimCompanyLabel.text = claim.companyName
        claimDateLabel.text = claim.days
        movementDateLabel.text = claim.movementDate
        
        if (claim.movementDate != nil)
        {
            self.movementDateLabel.text = DateUtilities.formattedDate(claim.movementDate!, dateFormat: ClaimTableViewCell.displayDateFormat)
        }
        if (claim.claimNumber != nil)
        {
            claimIDLabel.text = claim.claimNumber
        }
        if (claim.companyName != nil)
        {
            claimCompanyLabel.text = claim.companyName
        }
        if (claim.days != nil)
        {
            claimDateLabel.text = claim.days
        }
        
        switch claim.status {
        case ClaimStatus.Active.rawValue:
            colorStatusView.backgroundColor = UIColor(red: 27/255, green: 99/255, blue: 203/255, alpha: 1)
        case ClaimStatus.Processing.rawValue:
            colorStatusView.backgroundColor = UIColor(red: 255/255, green: 190/255, blue: 0/255, alpha: 1)
        case ClaimStatus.Inactive.rawValue:
            colorStatusView.backgroundColor = UIColor(red: 237/255, green: 103/255, blue: 0/255, alpha: 1)
        case ClaimStatus.Completed.rawValue:
            colorStatusView.backgroundColor = UIColor.clear
        default:
            colorStatusView.backgroundColor = UIColor.clear
        }
        
    }
}

