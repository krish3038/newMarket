//
//  ClaimEvaluationDataModel.swift
//  NewMarketServices
//
//  Created by RAMESH on 7/21/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import Foundation

public struct ClaimEvaluationSection {
    var name: String?
    var items: [AnyObject]?
    var collapsed: Bool?
    
    public init(name: String?, items: [AnyObject]?, collapsed: Bool? = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}
public struct ClaimSegmentationItem {
    var name: String?
    var role: String?
    var date: String?
    public init(name: String?, role: String?, date: String?) {
        self.name = name
        self.role = role
        self.date = date
    }
}

public struct ClaimSegmentationSection {
    var name: String?
    var segmentationMessage: String?
    var items: [ClaimSegmentationItem]?
    public init(name: String?, segmentationMessage: String?, items: [ClaimSegmentationItem]?) {
        self.name = name
        self.segmentationMessage = segmentationMessage
        self.items = items
    }
}

class ClaimEvaluationDataModel {
    var claimSegmentation: ClaimSegmentationSection?
    var sections : [ClaimEvaluationSection]?
    public init(claimSegmentation: ClaimSegmentationSection?, sections: [ClaimEvaluationSection]) {
        self.claimSegmentation = claimSegmentation
        self.sections = sections
    }
}

//public var claimSegmentationSection : ClaimSegmentationSection = ClaimSegmentationSection(

//public var claimEvaluationDataModel : ClaimEvaluationDataModel = ClaimEvaluationDataModel
