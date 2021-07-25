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

#import "../Common/UIExtensionsSharedHeader.h"
#import "IMvCallback.h"
#import <Foundation/Foundation.h>
#import <FoxitRDK/FSPDFViewControl.h>

// show extra file infomation about current pdf
@interface MoreModule : NSObject <IDocEventListener, UIDocumentInteractionControllerDelegate, UIPrintInteractionControllerDelegate, IRotationEventListener, UIPopoverControllerDelegate, IMvCallback>

- (instancetype)initWithUIExtensionsManager:(UIExtensionsManager *)extensionsManager;

@end
