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

#import "UIGestureRecognizerThumbnailScrollViewAdditions.h"

@implementation UIGestureRecognizer (ThumbnailScrollViewAdditions)

- (void)end {
    BOOL currentStatus = self.enabled;
    self.enabled = NO;
    self.enabled = currentStatus;
}

- (BOOL)hasRecognizedValidGesture {
    return (self.state == UIGestureRecognizerStateChanged || self.state == UIGestureRecognizerStateBegan);
}

@end
