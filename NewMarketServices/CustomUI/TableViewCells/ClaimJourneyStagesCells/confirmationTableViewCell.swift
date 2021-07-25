//
//  confirmationTableViewCell.swift
//  NewMarketServices
//
//  Created by Guest_mobility on 23/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class confirmationTableViewCell: UITableViewCell {
    @IBOutlet weak var lblConfirmation: UILabel!
    
    @IBOutlet weak var lblCarriername: UILabel!
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setDataforCell(index: Int) {
        
//          let object1 = Confirmobjects[index]
//       // self.contentView.backgroundColor = UIColor.white
//
//        lblConfirmation.text = claimPayment.partyType
       
    }
}
