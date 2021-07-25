//
//  MenuTableViewCell.swift
//  NewMarketServices
//
//  Created by admin on 25/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var underlineColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureDisplayFor(indexPath: IndexPath) {
        self.backgroundColor = .clear
        underlineColor.backgroundColor = ThemeManager.currentTheme().backgroundColor
        
        switch indexPath.row {
        case 0, 1, 2:
            leftImageView.isHidden = true
            rightImageView.isHidden = false
        case 3:
            leftImageView.isHidden = false
            rightImageView.isHidden = true
        default:
            print("default case")
        }
    }
    
    func configureSelectedBackgroundView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = ThemeManager.currentTheme().backgroundColor//UIColor(red: 27/255, green: 36/255, blue: 63/255, alpha: 1.0)
        self.selectedBackgroundView = backgroundView
    }

}
