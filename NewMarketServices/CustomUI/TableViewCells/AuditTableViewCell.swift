//
//  AuditTableViewCell.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 7/30/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class AuditTableViewCell: UITableViewCell {

    @IBOutlet weak var participantView: UIView!
    @IBOutlet weak var DateTimeView: UIView!
    @IBOutlet weak var EntryTypeView: UIView!
    
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblEntryType: UILabel!
    @IBOutlet weak var lblParticipant: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        participantView.borderWidth = 1
        participantView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
        DateTimeView.borderWidth = 1
        DateTimeView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
        EntryTypeView.borderWidth = 1
        EntryTypeView.borderColor = UIColor(red: 161/255, green: 162/255, blue: 164/255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
