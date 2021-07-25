//
//  CommentListTableViewCell.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 6/12/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class CommentListTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
