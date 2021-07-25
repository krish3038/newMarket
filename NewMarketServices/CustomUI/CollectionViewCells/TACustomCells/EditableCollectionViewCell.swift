//
//  EditableCollectionViewCell.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/30/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class EditableCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var editableTextField: UITextField!
    var indexPath: IndexPath? {
        didSet {
            setAlignment()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    func setDelegate(_ target: UITextFieldDelegate, index: IndexPath) {
//        editableTextField.delegate = target
//        indexPath = index
//    }
    
    func setAlignment() {
        editableTextField.textAlignment = .left
//        if indexPath?.row == 0 {
//            editableTextField.textAlignment = .center
//        }
//        else {
//            editableTextField.textAlignment = .left
//        }
    }
//
//    func setTextFieldTags() {
//        var tagValue = 0
//        switch indexPath?.row {
//        case 0:
//            tagValue = FinancialOverviewFieldTag.Section.rawValue
//        case 1:
//            tagValue = FinancialOverviewFieldTag.Premium.rawValue
//        case 2:
//            tagValue = FinancialOverviewFieldTag.London.rawValue
//        case 3:
//            tagValue = FinancialOverviewFieldTag.Overseas.rawValue
//        case 4:
//            tagValue = FinancialOverviewFieldTag.Fronting.rawValue
//        case 5:
//            tagValue = FinancialOverviewFieldTag.ThirdParty.rawValue
//        case 6:
//            tagValue = FinancialOverviewFieldTag.Ohter.rawValue
//        default:
//            print("")
//        }
//        editableTextField.tag = tagValue
//    }
//
//    func populateData(item: FOItem) {
//        var value = ""
//        switch indexPath?.row {
//        case 0:
//            value = item.Section!
//        case 1:
//            value = item.Premium!
//        case 2:
//            value = item.London!
//        case 3:
//            value = item.Overseas!
//        case 4:
//            value = item.Fronting!
//        case 5:
//            value = item.thirdParty!
//        case 6:
//            value = item.Other!
//        default:
//            print("")
//        }
//        editableTextField.text = value
//    }

}
