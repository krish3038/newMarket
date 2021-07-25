//
//  AppGlobal.swift
//  TestXC8.3
//
//  Created by Mohan Rao A on 19/07/18.
//  Copyright © 2018 Mohan Rao A. All rights reserved.
//

import Foundation
import UIKit

let DEBUG = true

public func consolelog(_ message: String, file: String = #file, function: String = #function, line: Int = #line ) {
    
    if DEBUG {
        //if DEBUG && line == 452 {
        
        print("\(function): \(message)")
        //print("\(message)")
    }
}

protocol SpinningWheelDelegate: class {
    
    func wheelDidSpin(bySelectedIndex: Int)
    func wheelDidRotateBy(angle: CGFloat)
}

//enum CircleRange: CGFloat {
//    case range0_59_9 = 60.0
//    case range60_119_9 = 120.0
//    case range120_179_9 = 180.0
//    case range180_239_9 = 240.0
//    case range240_299_9 = 300.0
//    case range300_359_9 = 360.0
//    case range360_360_9 = 361.0
//    
//    var range:Range<CGFloat> {
//        switch self {
//        case .range0_59_9 : return 0.0..<60.0
//        case .range60_119_9 : return 60.0..<120.0
//        case .range120_179_9 : return 120.0..<180.0
//        case .range180_239_9 : return 180.0..<240.0
//        case .range240_299_9 : return 240.0..<300.0
//        case .range300_359_9 : return 300.0..<360.0
//        case .range360_360_9 : return 360.0..<361.0
//        }
//    }
//}

enum CircleRange: CGFloat {
    case range0_59_9 = 60.0
    case range60_119_9 = 120.0
    case range120_179_9 = 180.0
    case range180_239_9 = 240.0
    case range240_299_9 = 300.0
    case range300_359_9 = 360.0
    case range360_360_9 = 361.0
    
    var range:Range<CGFloat> {
        switch self {
        case .range0_59_9 : return Range<CGFloat>(uncheckedBounds: (lower: 0.0, upper: 59.9))
        case .range60_119_9 : return Range<CGFloat>(uncheckedBounds: (lower: 60.0, upper: 119.9))
        case .range120_179_9 : return Range<CGFloat>(uncheckedBounds: (lower: 120.0, upper: 179.9))
        case .range180_239_9 : return Range<CGFloat>(uncheckedBounds: (lower: 180.0, upper: 239.9))
        case .range240_299_9 : return Range<CGFloat>(uncheckedBounds: (lower: 240.0, upper: 299.9))
        case .range300_359_9 : return Range<CGFloat>(uncheckedBounds: (lower: 300.0, upper: 359.9))
        case .range360_360_9 : return 360.0..<361.0
        }
    }
}

func >(left: CircleRange, right: CircleRange) -> Bool {
    
    return left.rawValue > right.rawValue
}

func <(left: CircleRange, right: CircleRange) -> Bool {
    
    return left.rawValue < right.rawValue
}



enum SpinningWheelError: Error {
    
    case invalidSectionsCount
    case invalid
}


func RadiansToDegree(rad: CGFloat) -> CGFloat {
    
    return ((rad * 180) / CGFloat(Float.pi))
}


enum Quadrant {
    
    case first
    case second
    case third
    case fourth
    case invalid
}

enum SpinningDirection: String {
    
    case backward = "backward"
    case forward = "forward"
}

enum TouchDirection: String {
    
    case backward = "backward"
    case forward = "forward"
    case none = "none"
}

