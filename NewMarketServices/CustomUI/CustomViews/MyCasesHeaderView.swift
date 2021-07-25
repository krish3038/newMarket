//
//  MyCasesHeaderView.swift
//  NewMarketServices
//
//  Created by Vinay Kumar Yedla on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

class MyCasesHeaderView: UIView {

    @IBOutlet weak var insuredLabel: UILabel!
    @IBOutlet weak var claimNoLabel: UILabel!
    @IBOutlet weak var policyNoLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    // #1
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // #2
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // #3
    public convenience init(image: UIImage, title: String) {
        self.init(frame: .zero)
       
        setupView()
    }
    
    private func setupView() {
        
        
    }
    
    override func awakeFromNib() {
        insuredLabel.text = "Insured \u{2304}"
        claimNoLabel.text = "Claim No \u{2304}"
        policyNoLabel.text = "Polic No \u{2304}"
        creationDateLabel.text = "Creation Date \u{2304}"
        urgencyLabel.text = "Urgency \u{2304}"
        targetLabel.text = "Target \u{2304}"
        statusLabel.text = "Status \u{2304}"
    }

}
