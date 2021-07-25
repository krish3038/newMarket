//
//  FinancialDetailsTableViewCell.swift
//  NewMarketServices
//
//  Created by admin on 11/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

enum FinancialFieldTag: Int {
    case Premium = 500
    case London
    case Overseas
    case Fronting
    case ThirdParty
    case Ohter
}

class FinancialDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var premiumFiled: UITextField!
    @IBOutlet weak var londonField: UITextField!
    @IBOutlet weak var overseasField: UITextField!
    @IBOutlet weak var frontingField: UITextField!
    @IBOutlet weak var thirdPartyField: UITextField!
    @IBOutlet weak var otherField: UITextField!
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setTextFieldTags()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDelegate(_ target: UITextFieldDelegate, index: IndexPath) {
        premiumFiled.delegate = target
        londonField.delegate = target
        overseasField.delegate = target
        frontingField.delegate = target
        thirdPartyField.delegate = target
        otherField.delegate = target
        
//        premiumFiled.delegate = self
//        londonField.delegate = self
//        overseasField.delegate = self
//        frontingField.delegate = self
//        thirdPartyField.delegate = self
//        otherField.delegate = self

        indexPath = index
        
        section.text = "\(index.row + 1)"
    }
    
    func setTextFieldTags() {
        premiumFiled.tag = FinancialFieldTag.Premium.rawValue
        londonField.tag = FinancialFieldTag.London.rawValue
        overseasField.tag = FinancialFieldTag.Overseas.rawValue
        frontingField.tag = FinancialFieldTag.Fronting.rawValue
        thirdPartyField.tag = FinancialFieldTag.ThirdParty.rawValue
        otherField.tag = FinancialFieldTag.Ohter.rawValue
    }
}
