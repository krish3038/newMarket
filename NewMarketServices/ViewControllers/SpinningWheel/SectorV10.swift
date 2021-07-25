    //
    //  Sector.swift
    //  SpinningWheel
    //
    //  Created by Mohan Rao A on 15/06/18.
    //  Copyright © 2018 Mohan Rao A. All rights reserved.
    //
    
    import Foundation
    import UIKit
    
    protocol Copying {
        init(original: Self)
    }
    
    
    extension Copying {
        func copy() -> Self {
            return Self.init(original: self)
        }
    }
    
    
    extension Array where Element: Copying {
        func clone() -> Array {
            var copiedArray = Array<Element>()
            for element in self {
                copiedArray.append(element.copy())
            }
            return copiedArray
        }
    }

    
    class SectorV10: CustomStringConvertible, Copying {
        
        init(minValue:CGFloat, maxValue: CGFloat, midValue: CGFloat, sectorNumber: Int){
            
            self.minValue = minValue
            self.maxValue = maxValue
            self.midValue = midValue
            self.sectorNumber = sectorNumber
            self.backGroundImage = nil
            self.centered = nil
            self.referenceIndex = nil
        }
        
        
        required init(original: SectorV10) {
            
            self.minValue = original.minValue
            self.maxValue = original.maxValue
            self.midValue = original.midValue
            self.sectorNumber = original.sectorNumber
            self.sectorValue = original.sectorValue
            self.centered = original.centered
            self.referenceIndex = original.referenceIndex
        }
        
        
        var description: String {
            
            get {
                
                return "minValue \(minValue) maxValue \(maxValue) midValue \(midValue) sectorNumber \(sectorNumber) sectorValue \(sectorValue)"
            }
        }
        var minValue: CGFloat
        var maxValue: CGFloat
        var midValue: CGFloat
        var sectorNumber: Int
        var referenceIndex: Int?
        
        var backGroundImage: UIImageView?
        private var _centered: Bool?
        private var _sectorValue: String?
        var centered: Bool? {
            
            set{
                _centered = newValue
                if (newValue != nil && newValue!) {
                    
                    markAsCentered()
                }
                if (newValue != nil && !newValue!) {
                    
                    unMarkAsCentered()
                }
            }
            
            get{
                
                return _centered != nil ? _centered! : false
            }
        }
        
        var sectorValue: (value: String, refIndex: Int)? {
            
            set{
                
                _sectorValue = newValue?.value
                referenceIndex = newValue?.refIndex
                if let label = backGroundImage?.viewWithTag((sectorNumber + 1) * 10) as? UILabel {
                    
                    label.text = "   \(newValue!.value.description)"
                    backGroundImage?.image = UIImage(named: "i-\(referenceIndex! + 1)stage")
                }
                
                if let sectorImage =  backGroundImage?.viewWithTag((sectorNumber + 1) * 100) as? UIImageView {
                    
                    sectorImage.image = UIImage(named: self.backgroundImageFor(value: self._sectorValue!))
                }
            }
            
            get{
                
                return _sectorValue != nil ? (_sectorValue!, referenceIndex!) : nil
            }
        }
        
        private func backgroundImageFor(value: String) -> String{
            
            switch value {
            case "Pending":
                return "statusgray_big"
            case "In Progress":
                return "statusgray_big"
            case "Completed":
                return "statusblue_big"
            
            default:
                return "statuspurple"
            }
        }
        
        private func markAsCentered() {
            
            if let sectorImage =  backGroundImage?.viewWithTag((sectorNumber + 1) * 100) as? UIImageView {
                UIView.transition(with: backGroundImage!, duration: 0.4, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                    sectorImage.image = UIImage(named: "segment_big")
                }, completion: nil)
                
            }
            
        }
        
        func markAsReplaceable() {
            
            if let sectorImage =  backGroundImage!.viewWithTag((sectorNumber + 1) * 100) as? UIImageView {
                UIView.transition(with: backGroundImage!, duration: 0.4, options: UIViewAnimationOptions.transitionFlipFromTop, animations: {
                    sectorImage.image = UIImage(named: self.backgroundImageFor(value: self._sectorValue!))
                }, completion: nil)
                
            }
            
        }
        
        private func unMarkAsCentered() {
            
            if let sectorImage =  backGroundImage?.viewWithTag((sectorNumber + 1) * 100) as? UIImageView {
                sectorImage.image = UIImage(named: backgroundImageFor(value: _sectorValue!))
            }
            
        }
    }
