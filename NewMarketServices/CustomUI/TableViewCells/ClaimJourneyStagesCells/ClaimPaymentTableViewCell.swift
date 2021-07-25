//
//  ClaimPaymentTableViewCell.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/9/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class ClaimPaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var partyName: UILabel!
    @IBOutlet weak var partyType: UILabel!
    @IBOutlet weak var settlementAmount: UILabel!
    @IBOutlet weak var confirmationStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        partyName.layer.cornerRadius = 1
        partyName.layer.masksToBounds = true
        partyName.layer.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1).cgColor
        partyName.layer.borderWidth = 1.0
        
        partyType.layer.cornerRadius = 1
        partyType.layer.masksToBounds = true
        partyType.layer.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1).cgColor
        partyType.layer.borderWidth = 1.0
        
        settlementAmount.layer.cornerRadius = 1
        settlementAmount.layer.masksToBounds = true
        settlementAmount.layer.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1).cgColor
        settlementAmount.layer.borderWidth = 1.0
        
        confirmationStatus.layer.cornerRadius = 1
        confirmationStatus.layer.masksToBounds = true
        confirmationStatus.layer.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1).cgColor
        confirmationStatus.layer.borderWidth = 1.0
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setDataforCell(index: Int, claimPayment: ClaimSettlementDetails) {
        /*if (index % 2 == 0)
         {
         self.contentView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
         } else {
         self.contentView.backgroundColor = UIColor(red: 186/255, green: 227/255, blue: 250/255, alpha: 1)
         } */
        
        self.contentView.backgroundColor = UIColor.white
        partyName.text = claimPayment.partyName
        partyType.text = claimPayment.partyType
        settlementAmount.text = claimPayment.settlementAmount
        confirmationStatus.text = claimPayment.confirmation
    }
    
}
