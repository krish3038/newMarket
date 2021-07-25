//
//  ClaimSegmentationTableViewCell.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/23/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class ClaimSegmentationTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var roleView: UIView!
    @IBOutlet weak var dateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.selectionStyle = .none
        nameView.borderWidth = 1
        nameView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
        roleView.borderWidth = 1
        roleView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
        dateView.borderWidth = 1
        dateView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData () {
                nameLabel.text = "Isabelle Smith"
                roleLabel.text = "Claim Technician"
                dateLabel.text = "20 May 2018"
    }

}
