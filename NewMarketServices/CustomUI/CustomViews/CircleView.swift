//
//  CircleView.swift
//  NewMarketServices
//
//  Created by Vinay Kumar Yedla on 27/07/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        customizeUI()
    }
    
    func customizeUI()  {
        backgroundColor = UIColor.clear
        layer.cornerRadius = self.frame.width / 2
        
    }
    
}
