//
//  InfoTableViewCell.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/5/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var partyTypeLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var infoReceivedLabel: UILabel!
    @IBOutlet weak var infoReceivedDateLabel: UILabel!
    
    @IBOutlet weak var partyNameView: UIView!
    @IBOutlet weak var partyTypeView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var dateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.selectionStyle = .none
        partyNameView.borderWidth = 1
        partyNameView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
        partyTypeView.borderWidth = 1
        partyTypeView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
        detailsView.borderWidth = 1
        detailsView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
        statusView.borderWidth = 1
        statusView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
        dateView.borderWidth = 1
        dateView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataforCell(index: Int, additionalInfo: AdditionalInfo) {
        if (index % 2 == 0)
        {
            self.contentView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
        } else {
            self.contentView.backgroundColor = UIColor(red: 186/255, green: 227/255, blue: 250/255, alpha: 1)
        }
        partyNameLabel.text = additionalInfo.partyName
        partyTypeLabel.text = additionalInfo.partyType
        detailsLabel.text = additionalInfo.details
        infoReceivedLabel.text = additionalInfo.infoReceived
        self.infoReceivedDateLabel.text = DateUtilities.formattedDate(additionalInfo.infoReceivedDate!, dateFormat: CustomDateFormat.kDisplayDateFormat)
    }
    func setData () {
//        partyNameLabel.text = "Name"
//        partyTypeLabel.text = "Type"
//        detailsLabel.text = "Details"
//        infoReceivedLabel.text = "Details"
//        self.infoReceivedDateLabel.text = "20-May-2018"
    }
}
