/**
 * Copyright (C) 2003-2018, Foxit Software Inc..
 * All Rights Reserved.
 *
 * http://www.foxitsoftware.com
 *
 * The following code is copyrighted and is the proprietary of Foxit Software Inc.. It is not allowed to
 * distribute any parts of Foxit Mobile PDF SDK to third party or public without permission unless an agreement
 * is signed between Foxit Software Inc. and customers to explicitly grant customers permissions.
 * Review legal.txt for additional license and legal information.
 */

#import "PropertyBar.h"
#import "UIExtensionsManager+Private.h"
#import "UIExtensionsManager.h"
#import <FoxitRDK/FSPDFViewControl.h>

// polygon and cloud
@interface PolygonAnnotHandler : NSObject <IAnnotHandler, IPropertyBarListener, IRotationEventListener, IGestureEventListener, IScrollViewEventListener, IAnnotPropertyListener, IDocEventListener> {
    //    EDIT_ANNOT_RECT_TYPE _editType;
    //
    //    float _minWidth;
    //    float _minHeight;
}

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) CGFloat minVertexDistance;

- (instancetype)initWithUIExtensionsManager:(UIExtensionsManager *)extensionsManager;

@end
