//
//  MyCasesDetailCell.swift
//  NewMarketServices
//
//  Created by Vinay Kumar Yedla on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class MyCasesDetailCell: UITableViewCell {

    
    var sectionsData : [Section]?

    @IBOutlet weak var detailsTableView: UITableView!

    
    @IBOutlet weak var insuredLabel: UILabel!
    @IBOutlet weak var claimNoLabel: UILabel!
    @IBOutlet weak var policyNoLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var line5: UIView!
    @IBOutlet weak var line6: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    var myCaseEachCaseDetails:EachCase? {
        didSet {
            insuredLabel.text = myCaseEachCaseDetails?.Name
            claimNoLabel.text = myCaseEachCaseDetails?.ClaimNo
            policyNoLabel.text = myCaseEachCaseDetails?.PolicyNo
            creationDateLabel.text = myCaseEachCaseDetails?.CreateDate
            urgencyLabel.text = myCaseEachCaseDetails?.Urgency
            targetLabel.text = myCaseEachCaseDetails?.TargetDate
            statusLabel.text = myCaseEachCaseDetails?.Status
            
            self.borderColor = UIColor(hex: 0x0053AB)
            self.layer.borderWidth = 1.0
                        
        }
    }
}
