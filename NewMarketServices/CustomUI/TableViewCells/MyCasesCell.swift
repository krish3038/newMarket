//
//  MyCasesCell.swift
//  NewMarketServices
//
//  Created by Vinay Kumar Yedla on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

protocol MyCasesTableDelegate:class {
    func didTapHeader(cell:MyCasesCell)
}


class MyCasesCell: UITableViewCell {
    
    
    weak var delegate:MyCasesTableDelegate?
    
    var isSectionCellSelected:Bool = false {
        didSet {
            headerView.backgroundColor =  (isSectionCellSelected) ? UIColor(hex: 0x101E4E) : UIColor.black
            let imageName =  (isSectionCellSelected) ?  "remove" : "add"
            insuredButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    @IBOutlet weak var insuredButton: UIButton!
    

    @IBOutlet weak var insuredLabel: UILabel!
    @IBOutlet weak var claimNoLabel: UILabel!
    @IBOutlet weak var policyNoLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var line5: UIView!
    @IBOutlet weak var line6: UIView!
    
    var myCaseSection:MyCases? {
        didSet {
            insuredButton.setTitle( myCaseSection?.InsuredCompanyName, for: .normal)
            claimNoLabel.text = myCaseSection?.ClaimNo
            policyNoLabel.text = myCaseSection?.PolicyNo
            creationDateLabel.text = myCaseSection?.ClaimCreateDate
            
            if let hours = myCaseSection?.ClaimUrgency {
                urgencyLabel.text = "\(hours) hr(s)"
                showUrgencySymbols(hour: Int(hours)!)

            }
            targetLabel.text = myCaseSection?.ClaimTargetDate
            statusLabel.text = myCaseSection?.ClaimMode
   
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 1.0
            
            assignLines(color: UIColor.white, width: 1.0)
        }
    }
    
    
    func showUrgencySymbols(hour:Int)  {
//        guard let createDateString = myCaseSection?.ClaimCreateDate else { return }
//        guard let targetDateString = myCaseSection?.ClaimTargetDate else { return }
        
//                let createDateString = "2018-07-31 10:11:12"
//                let targetDateString = "2018-07-31 10:11:13"

//        let hoursDifference =  DateUtilities.hoursDifferenceBetweenDates(fromDateString: createDateString, toDateString: targetDateString)
        
//        if let hour = hoursDifference {
        
            switch hour {
            case 0..<8:
                circleView.backgroundColor = UIColor.red
            case 8..<60:
                circleView.backgroundColor = UIColor.orange
            case 60..<10000000:
                circleView.backgroundColor = UIColor.green
            default:
                circleView.backgroundColor = UIColor.clear
            }
//        }
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
            
            assignLines(color: UIColor(hex: 0x101E4E), width: 1.0)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        reload()
    }
    
    func assignLines(color:UIColor, width:CGFloat) {
        
        line1.backgroundColor = color
        line2.backgroundColor = color
        line3.backgroundColor = color
        line4.backgroundColor = color
        line5.backgroundColor = color
        line6.backgroundColor = color
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func addButtonTapped(sender:UIButton) {
        
        delegate?.didTapHeader(cell: self)
    }
    
    
    
}
