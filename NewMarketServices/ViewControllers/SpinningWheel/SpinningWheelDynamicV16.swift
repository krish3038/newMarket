//
//  SpinningWheel.swift
//  SpinningWheel
//
//  Created by Mohan Rao A on 15/06/18.
//  Copyright © 2018 Mohan Rao A. All rights reserved.
//

import Foundation
import UIKit



public class SpinningWheelDynamicV16: UIControl{
    
    var container: UIImageView?
    var overlayContainer: UIView?
    var startTransform: CGAffineTransform?
    var deltaAngle: CGFloat!
    var touchStartAngle: CGFloat!
    var endAngle: CGFloat!
    var previousRange:CircleRange?
    var direction: SpinningDirection
    private static let minAlphavalue:CGFloat = 0.6
    private static let maxAlphavalue:CGFloat = 1.0
    private var numberOfSections: Int!
    private var sectors: [SectorV10] = []
    private weak var delegate: SpinningWheelDelegate?
    private let listSeries:[String]!
    
    init(frame: CGRect, delegate: SpinningWheelDelegate, sections: Int, listSeries: [String]) throws {
        
        guard (sections > 2 ) else{
            
            throw SpinningWheelError.invalidSectionsCount
        }
        self.delegate = delegate
        self.numberOfSections = sections
        self.listSeries = listSeries
        self.direction = .forward
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        drawWheel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawWheel(){
        
        
        //container = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        container = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width*2, height: self.bounds.height))
        container!.image = UIImage(named: "circle")
        container!.isUserInteractionEnabled = false
        self.clipsToBounds = true
        
        if (numberOfSections % 2 == 0) {
            buildSectorsEven()
        } else {
            buildSectorsOdd()
        }
        
        for i in 0..<numberOfSections {
            
            
            container!.addSubview(sectors[i].backGroundImage!)
        }
        
        container?.backgroundColor = UIColor.clear
        self.addSubview(container!)
        
        
        let bgView = UIImageView(frame: self.bounds)
        bgView.image = UIImage(named: "bg")
        //self.addSubview(bgView)
        
        let mask = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        mask.image = UIImage(named: "mask")
        mask.center = CGPoint(x: self.bounds.width, y: self.bounds.height / 2)
        //mask.isUserInteractionEnabled = false
        //mask.center = CGPoint(x: mask.center.x, y: mask.center.y)
        mask.isUserInteractionEnabled = true
        self.addSubview(mask)
        
        //Initialize sections 1,2,3,6,5
        //Lookup for values from first 3 values
        
        //previousRange = .range300_360
        
        container?.backgroundColor = UIColor.clear
        self.addSubview(container!)
        
        for i in 0...3 {
            
            sectors[i].sectorValue = (listSeries[i], i)
        }
        sectors[5].sectorValue = (listSeries[listSeries.count - 1], listSeries.count - 1)
        sectors[4].sectorValue = (listSeries[listSeries.count - 2], listSeries.count - 2)
        
        container!.transform = CGAffineTransform(rotationAngle: -1.0472)
        direction = .backward
        
        var containerCurrentAngle = CGFloat(atan2f(Float(container!.transform.b), Float(container!.transform.a)))
        // To convert negative quadrant values -180 to -1 as 180 to 360
        if containerCurrentAngle < 0 {
            containerCurrentAngle = 6.28319 + containerCurrentAngle
        }
        containerCurrentAngle = ceil(containerCurrentAngle * 10000.0)/10000.0
        let containerEndAngle_inDegree = rad2Degree(rad: CGFloat(containerCurrentAngle))
        
        if let currentRange = findMatchingRange(angle: containerEndAngle_inDegree) {
            
            findAndUpdateSectors(forContainerInRange: currentRange, inTheDirection: direction)
            findCenterSectorAndHighlight(forContainerInRange: currentRange, andDirection: direction)
        }
    }
    
    public func rotateTo(index: Int) {
    
        guard index >= 0 && index < listSeries.count else {
            
            return
        }
        
        undoHighlight()
        var stopIterating = false
        while !stopIterating {
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.2)
            container!.transform = container!.transform.rotated(by: 1.0472)
            UIView.commitAnimations()
            direction = .forward
            
            let containerCurrentAngle = calculateContainerCurrentAngle()
            let containerEndAngle_inDegree = rad2Degree(rad: CGFloat(containerCurrentAngle))
            
            if let currentRange = findMatchingRange(angle: containerEndAngle_inDegree) {
                
                findAndUpdateSectors(forContainerInRange: currentRange, inTheDirection: direction)
                let centerSectorNumber = findCenterSector(forContainerInRange: currentRange, andDirection: direction)
                if sectors[centerSectorNumber].referenceIndex! == index {
                    stopIterating = true
                    sectors[centerSectorNumber].centered = true
                }
            }
            
        }
    }
    
    private func handleTap(tapLocation: CGPoint) {
        
        rotateWheelForSingleTap(point: tapLocation)
    }
    
    
    private func rotateWheelForSingleTap(point: CGPoint){
        
        let quadrant = findQuadrantForPoint(point: point)
        
        switch quadrant {
            
        case .first:
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.2)
            container!.transform = container!.transform.rotated(by: -1.0472)
            UIView.commitAnimations()
            direction = .backward
            break
            
        case .second:
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.2)
            container!.transform = container!.transform.rotated(by: -1.0472)
            UIView.commitAnimations()
            direction = .backward
            break
            
        case .third:
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.2)
            container!.transform = container!.transform.rotated(by: 1.0472)
            UIView.commitAnimations()
            direction = .forward
            break
            
        case .fourth:
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.2)
            container!.transform = container!.transform.rotated(by: 1.0472)
            UIView.commitAnimations()
            direction = .forward
            break
            
        default:
            break
        }
        
        findRangeAndUpdateSectors()
        
    }
    
    private func findRangeAndHighlight() {
        
        let containerCurrentAngle = calculateContainerCurrentAngle()
        
        //let containerCurrentAngleTemp = (Float(containerCurrentAngle)/1000000.0)
        let containerEndAngle_inDegree = rad2Degree(rad: CGFloat(containerCurrentAngle))
        
        if let currentRange = findMatchingRange(angle: containerEndAngle_inDegree) {
            
            findCenterSectorAndHighlight(forContainerInRange: currentRange, andDirection: direction)
        }
        
    }
    
    private func calculateContainerCurrentAngle() -> CGFloat {
        
        var containerCurrentAngle = CGFloat(atan2f(Float(container!.transform.b), Float(container!.transform.a)))
        // To convert negative quadrant values -180 to -1 as 180 to 360
        if containerCurrentAngle < 0 {
            containerCurrentAngle = 6.28319 + containerCurrentAngle
        }
        
        containerCurrentAngle = ceil(containerCurrentAngle * 10000.0)/10000.0
        return containerCurrentAngle
    }
    
    private func findRangeAndUpdateSectors() {
        
        var containerCurrentAngle = CGFloat(atan2f(Float(container!.transform.b), Float(container!.transform.a)))
        // To convert negative quadrant values -180 to -1 as 180 to 360
        if containerCurrentAngle < 0 {
            containerCurrentAngle = 6.28319 + containerCurrentAngle
        }
        
        containerCurrentAngle = ceil(containerCurrentAngle * 10000.0)/10000.0
        //let containerCurrentAngleTemp = (Float(containerCurrentAngle)/1000000.0)
        let containerEndAngle_inDegree = rad2Degree(rad: CGFloat(containerCurrentAngle))
        
        if let currentRange = findMatchingRange(angle: containerEndAngle_inDegree) {
            
            findAndUpdateSectors(forContainerInRange: currentRange, inTheDirection: direction)
            findCenterSectorAndHighlight(forContainerInRange: currentRange, andDirection: direction)
//delegate?.wheelDidSpin(bySelectedIndex: findCenterSector(forContainerInRange: currentRange, andDirection: direction))
            let centerSector = findCenterSector(forContainerInRange: currentRange, andDirection: direction)
            
            delegate?.wheelDidSpin(bySelectedIndex: sectors[centerSector].referenceIndex!)
        }
        
    }
    
    private func findQuadrantForPoint(point: CGPoint) -> Quadrant{
        
        
        let dx = point.x - container!.center.x
        let dy = point.y - container!.center.y
        let angleInRadian = atan2(dx, dy)
        let angleInDegree = RadiansToDegree(rad: angleInRadian)
        
        
        switch angleInDegree {
        case -180 ... -90 :
            return .first
        case 90...180 :
            return .second
        case 0...90 :
            return .third
        case -90 ... 0 :
            return .fourth
        default:
            return .invalid
        }
        
    }
    
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let touchPoint = touch.location(in: self)
        let dx = touchPoint.x - container!.center.x
        let dy = touchPoint.y - container!.center.y
        deltaAngle = atan2(dx, dy)
        touchStartAngle = deltaAngle
        startTransform = container!.transform;
        touchPreviousAngle = touchStartAngle
        
        undoHighlight()
        return true
    }
    
    var accumlatedAngle:CGFloat = 0.0
    var containerPreviousAngle: CGFloat = 0.0
    var touchPreviousAngle: CGFloat = 0.0
    
    public func continueTracking_disabled(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let touchPoint = touch.location(in: self)
        let dx = touchPoint.x - container!.center.x
        let dy = touchPoint.y - container!.center.y
        var touchCurrentAngle = atan2(dx, dy)
        let angleDifference = touchStartAngle - touchCurrentAngle
        var touchDiff = touchCurrentAngle - touchPreviousAngle
        var touchDirection = TouchDirection.none
        touchDiff = touchDiff >= 0 ? touchDiff : -touchDiff
        if (touchDiff >= 5.2  || touchDiff == 0) {
            
            // Ignore the shift from +ve to -ve / -ve to +ve quadrant
        } else {
            
            //            let tempCurrentAngle = minusPieToPlusPie(radians: touchCurrentAngle)
            //            let tempPreviousAngle = minusPieToPlusPie(radians: touchCurrentAngle)
            if touchCurrentAngle > touchPreviousAngle {
                touchDirection = .backward
            }else {
                touchDirection = .forward
            }
        }
        touchPreviousAngle = touchCurrentAngle
        
        // Rotate the container as much as the touch has moved.
        container!.transform = startTransform!.rotated(by: angleDifference)
        
        var containerCurrentAngle = CGFloat(atan2f(Float(container!.transform.b), Float(container!.transform.a)))
        
        // To convert negative quadrant values -180 to -1 as 180 to 360
        if containerCurrentAngle < 0 {
            containerCurrentAngle = 6.28319 + containerCurrentAngle
        }
        containerCurrentAngle = ceil(containerCurrentAngle * 10000.0)/10000.0
        let containerEndAngle_inDegree = rad2Degree(rad: containerCurrentAngle)
        if let currentRange = findMatchingRange(angle: containerEndAngle_inDegree) {
            
            //To check if the wheel crossed +ve to -ve / -ve to +ve quadrant
            var diff = containerCurrentAngle - containerPreviousAngle
            diff = diff >= 0 ? diff : -diff
            if (diff >= 5.2  || diff == 0) {
                
                // Ignore the shift from +ve to -ve / -ve to +ve quadrant
            } else {
                
                if containerCurrentAngle < containerPreviousAngle {
                    direction = .backward
                }else {
                    direction = .forward
                }
            }
            
            //Trigger range-change only if previousRange is not nill, otherwise assign the currentRange to previousRange
            if currentRange != previousRange && previousRange != nil {
                
                previousRange = currentRange
                findAndUpdateSectors(forContainerInRange: currentRange, inTheDirection: direction)
            }
            
            // For the first time previousRange will be nil. Direction is unknown untill first currentRange is assigned to previousRange
            if previousRange == nil {
                
                previousRange = currentRange
            }
        }
        
        containerPreviousAngle = containerCurrentAngle
        return true
    }
    
    private func minusPieToPlusPie(radians: CGFloat) -> CGFloat {
        
        var convertedRadians = radians
        if convertedRadians < 0 {
            convertedRadians = 6.28319 + convertedRadians
        }
        
        return convertedRadians
    }
    
    public  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        
        if let touchPoint = touch?.location(in: self) {
            let dx = touchPoint.x - container!.center.x
            let dy = touchPoint.y - container!.center.y
            let angle = atan2(dx, dy)
            endAngle = angle
            
            if ((touchStartAngle - endAngle) == 0) {
                
                print("Performing Tap")
                container?.transform = startTransform!
                handleTap(tapLocation: touchPoint)
                return
            }
        }
        
        
        let radians = CGFloat(atan2f(Float(container!.transform.b), Float(container!.transform.a)))
        var newValue:CGFloat = 0.0
        
        for sector in sectors {
            
            if (sector.minValue > 0 && sector.maxValue < 0) {
                if (sector.maxValue > radians || sector.minValue < radians) {
                    
                    if (radians > 0) {
                        newValue = radians - CGFloat(Float.pi)
                    } else {
                        newValue = CGFloat(Float.pi) + radians
                    }
                    //currentSector = sector
                    // 6 - Get sector number
                }
            }
            if (radians > sector.minValue && radians < sector.maxValue) {
                newValue = radians - sector.midValue
                //currentSector = sector
                //break
            }
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = container!.transform.rotated(by: -newValue)
        container!.transform = transform
        UIView.commitAnimations()
        
        var containerCurrentAngle = CGFloat(atan2f(Float(container!.transform.b), Float(container!.transform.a)))
        
        // To convert negative quadrant values -180 to -1 as 180 to 360
        if containerCurrentAngle < 0 {
            containerCurrentAngle = 6.28319 + containerCurrentAngle
        }
        
        //let difference = round(calculateAngleDiffInDegree(x1: containerStartAngle, x2: containerEndAngle))
        
        //consolelog("containerStartAngle: \(rad2Degree(rad: containerCurrentAngle)), containerEndAngle: \(rad2Degree(rad: containerCurrentAngle))")
        containerCurrentAngle = ceil(containerCurrentAngle * 10000.0)/10000.0
        let containerEndAngle_inDegree = rad2Degree(rad: containerCurrentAngle)
        if let currentRange = findMatchingRange(angle: containerEndAngle_inDegree) {
            
            //consolelog("containerEndAngle_inDegree: \(containerEndAngle_inDegree)")
            
            //To check if the wheel crossed the significant ranges
            
            
            var diff = containerCurrentAngle - containerPreviousAngle
            diff = diff >= 0 ? diff : -diff
            if (diff >= 5.2 || diff == 0) {
                
                
            } else {
                
                if containerCurrentAngle < containerPreviousAngle {
                    direction = .backward
                }else {
                    direction = .forward
                }
            }
            
            //Trigger range-change only if previousRange is not nill, otherwise assign the currentRange to previousRange
            if currentRange != previousRange && previousRange != nil {
                
                previousRange = currentRange
                findAndUpdateSectors(forContainerInRange: currentRange, inTheDirection: direction)
            }
            
            findCenterSectorAndHighlight(forContainerInRange: currentRange, andDirection: direction)
            let centerSector = findCenterSector(forContainerInRange: currentRange, andDirection: direction)
            delegate?.wheelDidSpin(bySelectedIndex: sectors[centerSector].referenceIndex!)
            // For the first time previousRange will be nil. Direction is unknown untill first currentRange is assigned to previousRange
            if previousRange == nil {
                
                previousRange = currentRange
            }
        }
        
        containerPreviousAngle = containerCurrentAngle
    }
    
    
    private func findAndUpdateSectors(forContainerInRange containerInRange: CircleRange, inTheDirection: SpinningDirection){
        
        let sectorNumber = findSectorNumberTobeUpdated(forContainerInRange: containerInRange, andDirection: direction)
        var sectorAheadNumber = -1
        
        
        switch direction  {
            
        case .forward:
            sectorAheadNumber = sectorNumber + 1
            if sectorAheadNumber > 5 {
                
                sectorAheadNumber = 0
            }
            
        case .backward:
            sectorAheadNumber = sectorNumber - 1
            if sectorAheadNumber < 0 {
                
                sectorAheadNumber = 5
            }
            
        }
        let referenceIndex = sectors[sectorAheadNumber].referenceIndex
        updateSector(sectorNumber, itemNextTo: referenceIndex!, inTheDirection: direction)
        
    }
    
    
    private func updateSector(_ sectorNumber: Int, itemNextTo referenceIndex: Int, inTheDirection: SpinningDirection) {
        
        switch inTheDirection {
        case .backward:
            var refIndex = referenceIndex + 1
            if refIndex >= listSeries.count {
                refIndex = 0
            }
            sectors[sectorNumber].sectorValue = (listSeries[refIndex], refIndex)
            
        case .forward:
            var refIndex = referenceIndex - 1
            if refIndex < 0 {
                refIndex = listSeries.count - 1
            }
            sectors[sectorNumber].sectorValue = (listSeries[refIndex], refIndex)
        }
    }
    
    private func undoHighlight(){
        for i in 0..<numberOfSections {
            sectors[i].centered = false
        }
    }
    
    
    private func findCenterSector(forContainerInRange containerRange: CircleRange, andDirection direction: SpinningDirection) -> Int {
        
        
        var centerSectorNumber = -1
        switch containerRange {
        case .range0_59_9 :
            centerSectorNumber = 5
        case .range60_119_9 :
            centerSectorNumber = 4
        case .range120_179_9 :
            centerSectorNumber = 3
        case .range180_239_9 :
            centerSectorNumber = 2
        case .range240_299_9 :
            centerSectorNumber = 1
        case .range300_359_9 :
            centerSectorNumber = 0
        default:
            centerSectorNumber = -1
        }
        
        
        return centerSectorNumber
    }
    
    private func findCenterSectorAndHighlight(forContainerInRange containerRange: CircleRange, andDirection direction: SpinningDirection) -> Void {
        
        
        let centerSectorNumber = findCenterSector(forContainerInRange: containerRange, andDirection: direction)
        undoHighlight()
        sectors[centerSectorNumber].centered = true
    }
    
    private func findSectorNumberTobeUpdated(forContainerInRange containerRange: CircleRange, andDirection direction: SpinningDirection) -> Int {
        
        
        switch (containerRange, direction) {
        case (.range240_299_9, .backward) :
            return 3
        case (.range180_239_9, .backward) :
            return 4
        case (.range120_179_9, .backward) :
            return 5
        case (.range60_119_9, .backward) :
            return 0
        case (.range0_59_9, .backward) :
            return 1
        case (.range300_359_9, .backward) :
            return 2
            
        case (.range0_59_9, .forward) :
            return 3
        case (.range60_119_9, .forward) :
            return 2
        case (.range120_179_9, .forward) :
            return 1
        case (.range180_239_9, .forward) :
            return 0
        case (.range240_299_9, .forward) :
            return 5
        case (.range300_359_9, .forward) :
            return 4
        default:
            return -1
        }
    }
    
    private func findSectorNextToCenteredSector(forContainerInRange containerRange: CircleRange, andDirection direction: SpinningDirection) -> Int {
        
        switch (containerRange, direction) {
        case (.range240_299_9, .backward) :
            return 2
        case (.range180_239_9, .backward) :
            return 3
        case (.range120_179_9, .backward) :
            return 4
        case (.range60_119_9, .backward) :
            return 5
        case (.range0_59_9, .backward) :
            return 0
        case (.range300_359_9, .backward) :
            return 1
            
        case (.range0_59_9, .forward) :
            return 4
        case (.range60_119_9, .forward) :
            return 3
        case (.range120_179_9, .forward) :
            return 2
        case (.range180_239_9, .forward) :
            return 1
        case (.range240_299_9, .forward) :
            return 0
        case (.range300_359_9, .forward) :
            return 5
        default:
            return -1
        }
    }
    
    private func findMatchingRange(angle: CGFloat) -> CircleRange? {
        
        
        switch(angle) {
        case CircleRange.range0_59_9.range:
            return CircleRange.range0_59_9
            
        case CircleRange.range60_119_9.range:
            return CircleRange.range60_119_9
            
        case CircleRange.range120_179_9.range:
            return CircleRange.range120_179_9
            
        case CircleRange.range180_239_9.range:
            return CircleRange.range180_239_9
            
        case CircleRange.range240_299_9.range:
            return CircleRange.range240_299_9
            
        case CircleRange.range300_359_9.range:
            return CircleRange.range300_359_9
            
        case CircleRange.range360_360_9.range:
            return CircleRange.range0_59_9
        default: return nil
        }
    }
    
    private func calculateAngleDiffInDegree(x1: CGFloat, x2: CGFloat) -> CGFloat{
        
        let dx1 = (x1)
        let dx2 = (x2)
        
        //dx1 = dx1 > 0 ? dx1 : -dx1
        //dx2 = dx2 > 0 ? dx2 : -dx2
        
        let z = dx1 - dx2
        //z = z > 0 ? z : -z
        
        return ((z * 180) / CGFloat(Float.pi))
    }
    
    private func rad2Degree(rad: CGFloat) -> CGFloat {
        
        return ((rad * 180) / CGFloat(Float.pi))
    }
    
    private func buildSectorsEven(){
        
        let fanWidth = CGFloat.pi * 2 / CGFloat(numberOfSections)
        var mid:CGFloat = 0.0
        
        for i in 0..<numberOfSections {
            
            let sector = SectorV10(minValue: (mid - (fanWidth / 2)), maxValue: (mid + (fanWidth / 2)), midValue: mid, sectorNumber: i)
            
            if (sector.maxValue - fanWidth < -CGFloat.pi) {
                mid = CGFloat.pi;
                sector.midValue = mid
                sector.minValue = CGFloat(fabsf(Float(sector.maxValue)))
                
            }
            mid -= fanWidth
            
            let sectorBGImage = createSectorBackgroundImage(forSectorIndex: i)
            sector.backGroundImage = sectorBGImage
            
            sectors.append(sector)
            //print(sector)
        }
    }
    
    private func buildSectorsOdd(){
        
        let fanWidth: CGFloat = CGFloat.pi * 2 / CGFloat(numberOfSections)
        var mid:CGFloat = 0.0
        
        for i in 0..<numberOfSections {
            
            let sector = SectorV10(minValue: (mid - (fanWidth / 2)), maxValue: (mid + (fanWidth / 2)), midValue: mid, sectorNumber: i)
            mid -= fanWidth
            if (sector.minValue <= -CGFloat.pi) {
                
                mid = -mid
                mid -= fanWidth
            }
            
            let sectorBGImage = createSectorBackgroundImage(forSectorIndex: i)
            sector.backGroundImage = sectorBGImage
            sectors.append(sector)
            
            //print(sector)
            //sectorImage.layer.borderColor = UIColor.blue.cgColor
            //sectorImage.layer.borderWidth = 1
            //sectorBGImage.layer.borderColor = UIColor.red.cgColor
            //sectorBGImage.layer.borderWidth = 2
        }
    }
    
    private func createSectorBackgroundImage(forSectorIndex: Int) -> UIImageView{
        
        let angleSize = CGFloat(2.0) * CGFloat(M_PI) / CGFloat(numberOfSections)
        let tag = forSectorIndex + 1
        let sectorBGImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 320, height: 310))
        sectorBGImage.image = UIImage(named: "segment_big")
        //UIImageView(image: UIImage(named: "segment_big"))
        sectorBGImage.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        sectorBGImage.layer.position = CGPoint(x: container!.bounds.size.width/2.0, y: container!.bounds.size.height/2.0)
        sectorBGImage.transform = CGAffineTransform(rotationAngle: CGFloat(angleSize * CGFloat(forSectorIndex + 1)))
        sectorBGImage.tag = tag
        
        let label = UILabel(frame: CGRect(x: 20.0, y: 125, width: 220.0, height: 40.0))
        label.text = forSectorIndex.description
        label.textColor = UIColor.white
        label.font  = UIFont.boldSystemFont(ofSize: 30.0)//UIFont(name: label.font.fontName, size: 20)
        label.tag = tag * 10
        
//        let sectorNumberlabel = UILabel(frame: CGRect(x: 1.0, y: sectorBGImage.bounds.width / 3.0, width: 200.0, height: 40.0))
//        sectorNumberlabel.text = forSectorIndex.description
//        sectorNumberlabel.textColor = UIColor.black
//        sectorNumberlabel.font  = UIFont.boldSystemFont(ofSize: 50.0)//UIFont(name: label.font.fontName, size: 20)
//        sectorNumberlabel.tag = tag * 20
//        sectorBGImage.addSubview(sectorNumberlabel)
        
        let sectorImage = UIImageView(frame: CGRect(x: 20, y: 5, width: 300, height: 300))
        sectorImage.image = UIImage(named: "segment_big")
        sectorImage.tag = tag * 100
        
        sectorBGImage.addSubview(sectorImage)
        sectorBGImage.addSubview(label)
        
        return sectorBGImage
        
    }
}
