//
//  UIButton+Extension.swift
//  NewMarketServices
//
//  Created by Mahalakshmi on 6/7/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extended from `UIButton`
extension UIButton{
    func roundedButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight],
                                     cornerRadii: CGSize(width: 18, height: 18))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}

