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

#import "TextMKToolHandler.h"
#import "Preference.h"
#import "UIExtensionsManager+Private.h"
#import <FoxitRDK/FSPDFViewControl.h>

@interface MKToolHandler ()

@property (nonatomic, assign) int pageindex;
@property (nonatomic, strong) NSArray *arraySelectedRect;
@property (nonatomic, assign) CGRect currentEditRect;
@property (nonatomic, assign) CGRect oldEditRect;

@end

@implementation MKToolHandler {
    UIExtensionsManager *_extensionsManager;
    FSPDFViewCtrl *_pdfViewCtrl;
    TaskServer *_taskServer;
}

- (instancetype)initWithUIExtensionsManager:(UIExtensionsManager *)extensionsManager {
    self = [super init];
    if (self) {
        _extensionsManager = extensionsManager;
        _pdfViewCtrl = extensionsManager.pdfViewCtrl;
        _taskServer = _extensionsManager.taskServer;
        _type = e_annotHighlight;
        [self clearSelection];
    }
    return self;
}

- (int)getCharIndexAtPos:(int)pageIndex point:(CGPoint)point {
    FSPointF *dibPoint = [_pdfViewCtrl convertPageViewPtToPdfPt:point pageIndex:pageIndex];
    return (int) [[Utility getTextSelect:_pdfViewCtrl.currentDoc pageIndex:pageIndex] getIndexAtPos:dibPoint.x y:dibPoint.y tolerance:5];
}

- (NSArray *)getCurrentSelectRects:(int)pageIndex {
    UIView *view = [_pdfViewCtrl getPageView:pageIndex];
    CGSize size = view.frame.size;
    int offsetY = 0;
    int offsetX = 0;
    __block CGRect unionRect = CGRectZero;
    NSMutableArray *ret = [NSMutableArray array];

    FSPDFTextSelect *textPage = [Utility getTextSelect:_pdfViewCtrl.currentDoc pageIndex:pageIndex];
    assert(_startPosIndex != -1 && _endPosIndex != -1);
    int start = MIN(_startPosIndex, _endPosIndex);
    int count = ABS(_endPosIndex - _startPosIndex) + 1;
    NSArray *array = [Utility getTextRects:textPage start:start count:count];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGRect rect = [[obj objectAtIndex:0] CGRectValue];
        FSRectF *dibRect = [Utility CGRect2FSRectF:rect];
        CGRect selfRect = [self getRealRectWithOptions:pageIndex dibRect:dibRect size:size offsetY:offsetY offsetX:offsetX];
        [ret addObject:[NSValue valueWithCGRect:selfRect]];
        if (CGRectEqualToRect(unionRect, CGRectZero)) {
            unionRect = selfRect;
        } else {
            unionRect = CGRectUnion(unionRect, selfRect);
        }
    }];
    self.oldEditRect = self.currentEditRect;
    self.currentEditRect = unionRect;
    return ret;
}

- (CGRect)getRealRectWithOptions:(int)pageIndex dibRect:(FSRectF *)dibRect size:(CGSize)size offsetY:(int)offsetY offsetX:(int)offsetX {
    CGRect rect = [_pdfViewCtrl convertPdfRectToPageViewRect:dibRect pageIndex:pageIndex];
    return rect;
}

- (void)clearSelection {
    _startPosIndex = -1;
    _endPosIndex = -1;
    self.arraySelectedRect = nil;
    self.currentEditRect = CGRectZero;
    self.oldEditRect = CGRectZero;
}

#pragma mark - Magnifier

- (void)showMagnifier:(int)pageIndex index:(int)index point:(CGPoint)point {
    if (_magnifierView == nil) {
        FSPDFTextSelect *textPage = [Utility getTextSelect:_pdfViewCtrl.currentDoc pageIndex:pageIndex];
        NSArray *array = [Utility getTextRects:textPage start:index count:1];
        if (array.count > 0) {
            FSRectF *dibRect = [Utility CGRect2FSRectF:[[[array objectAtIndex:0] objectAtIndex:0] CGRectValue]];
            CGRect rect = [_pdfViewCtrl convertPdfRectToPageViewRect:dibRect pageIndex:pageIndex];
            point = CGPointMake(point.x, CGRectGetMidY(rect));
        }
        _magnifierView = [[MagnifierView alloc] init];
        _magnifierView.viewToMagnify = [_pdfViewCtrl getDisplayView];
        _magnifierView.touchPoint = point;
        _magnifierView.magnifyPoint = [[_pdfViewCtrl getPageView:pageIndex] convertPoint:point toView:[_pdfViewCtrl getDisplayView]];
        [[_pdfViewCtrl getPageView:pageIndex] addSubview:_magnifierView];
    }
}

- (void)moveMagnifier:(int)pageIndex index:(int)index point:(CGPoint)point {
    FSPDFTextSelect *textPage = [Utility getTextSelect:_pdfViewCtrl.currentDoc pageIndex:pageIndex];
    NSArray *array = [Utility getTextRects:textPage start:index count:1];
    if (array.count > 0) {
        FSRectF *dibRect = [Utility CGRect2FSRectF:[[[array objectAtIndex:0] objectAtIndex:0] CGRectValue]];
        CGRect rect = [_pdfViewCtrl convertPdfRectToPageViewRect:dibRect pageIndex:pageIndex];
        point = CGPointMake(point.x, CGRectGetMidY(rect));
    }
    _magnifierView.touchPoint = point;
    _magnifierView.magnifyPoint = [[_pdfViewCtrl getPageView:pageIndex] convertPoint:point toView:[_pdfViewCtrl getDisplayView]];
    [_magnifierView setNeedsDisplay];
}

- (void)closeMagnifier {
    [_magnifierView removeFromSuperview];
    _magnifierView = nil;
}

- (NSArray *)getAnnotationQuad:(FSTextMarkup *)annot {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    FSTextMarkup *markup = annot;
    int quadCount = [markup getQuadPointsCount];
    if (quadCount < 0) {
        return nil;
    }

    for (int i = 0; i < quadCount; i++) {
        FSQuadPoints *quadPoints = [markup getQuadPoints:i];
        if (!quadPoints) {
            goto END;
        }
        [array addObject:quadPoints];
    }

END:
    return array;
}

- (NSString *)getName {
    return Tool_Markup;
}

- (BOOL)isEnabled {
    return YES;
}

- (void)onActivate {
}

- (void)onDeactivate {
}

// PageView Gesture+Touch
- (BOOL)onPageViewLongPress:(int)pageIndex recognizer:(UILongPressGestureRecognizer *)recognizer {
    return YES;
}

- (BOOL)onPageViewTap:(int)pageIndex recognizer:(UITapGestureRecognizer *)recognizer {
    return NO;
}

- (BOOL)onPageViewPan:(int)pageIndex recognizer:(UIPanGestureRecognizer *)recognizer {
    UIView *view = [_pdfViewCtrl getPageView:pageIndex];
    CGPoint point = [recognizer locationInView:view];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.pageindex = pageIndex;
        [self clearSelection];
        int index = [self getCharIndexAtPos:pageIndex point:point];
        if (index > -1) {
            if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
                FSPDFTextSelect *textPage = [Utility getTextSelect:_pdfViewCtrl.currentDoc pageIndex:pageIndex];
                NSRange range = [Utility getWordByTextIndex:index textPage:textPage];

                self.startPosIndex = (int) range.location;
                self.endPosIndex = (int) (range.location + range.length - 1);
                [self getCurrentSelectRects:pageIndex];
                CGRect refreshRect = CGRectIsEmpty(self.oldEditRect) ? self.currentEditRect : CGRectUnion(self.currentEditRect, self.oldEditRect);
                [_pdfViewCtrl refresh:CGRectInset(refreshRect, RECT_INSET, RECT_INSET) pageIndex:pageIndex needRender:NO];
            } else {
                self.startPosIndex = index;
                self.endPosIndex = index;
            }
            [self showMagnifier:pageIndex index:index point:point];
        }

    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (pageIndex != self.pageindex) {
            return NO;
        }
        CGPoint point = [recognizer locationInView:[_pdfViewCtrl getPageView:pageIndex]];
        int index = [self getCharIndexAtPos:pageIndex point:point];
        if (index > -1) {
            if (self.startPosIndex == -1) {
                self.startPosIndex = index;
                self.endPosIndex = index;
            } else {
                self.endPosIndex = index;
            }
            [self getCurrentSelectRects:pageIndex];
            CGRect refreshRect = CGRectIsEmpty(self.oldEditRect) ? self.currentEditRect : CGRectUnion(self.currentEditRect, self.oldEditRect);
            [_pdfViewCtrl refresh:CGRectInset(refreshRect, RECT_INSET, RECT_INSET) pageIndex:pageIndex needRender:NO];
            [self moveMagnifier:pageIndex index:index point:point];
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        [self closeMagnifier];
        if (self.startPosIndex == -1 || self.endPosIndex == -1) {
            return YES;
        }

        FSPDFTextSelect *textPage = [Utility getTextSelect:_pdfViewCtrl.currentDoc pageIndex:self.pageindex];
        NSArray *array = [Utility getTextRects:textPage start:MIN(self.startPosIndex, self.endPosIndex) count:ABS(self.endPosIndex - self.startPosIndex) + 1];
        NSMutableArray *arrayQuads = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            FSRectF *dibRect = [Utility CGRect2FSRectF:[[[array objectAtIndex:i] objectAtIndex:0] CGRectValue]];
            int direction = [[[array objectAtIndex:i] objectAtIndex:1] intValue];
            FSQuadPoints *fsqps = [[FSQuadPoints alloc] init];
            if (direction == 0 || direction == 4) //text is horizontal or unknown, left to right
            {
                FSPointF *first = [[FSPointF alloc] init];
                [first set:dibRect.left y:dibRect.top];
                FSPointF *second = [[FSPointF alloc] init];
                [second set:dibRect.right y:dibRect.top];
                FSPointF *third = [[FSPointF alloc] init];
                [third set:dibRect.left y:dibRect.bottom];
                FSPointF *fourth = [[FSPointF alloc] init];
                [fourth set:dibRect.right y:dibRect.bottom];
                [fsqps set:first second:second third:third fourth:fourth];
            } else if (direction == 1) // test is vertical, left to right
            {
                FSPointF *first = [[FSPointF alloc] init];
                [first set:dibRect.left y:dibRect.bottom];
                FSPointF *second = [[FSPointF alloc] init];
                [second set:dibRect.left y:dibRect.top];
                FSPointF *third = [[FSPointF alloc] init];
                [third set:dibRect.right y:dibRect.bottom];
                FSPointF *fourth = [[FSPointF alloc] init];
                [fourth set:dibRect.right y:dibRect.top];
                [fsqps set:first second:second third:third fourth:fourth];
            } else if (direction == 2) //text is horizontal, right to left
            {
                FSPointF *first = [[FSPointF alloc] init];
                [first set:dibRect.right y:dibRect.bottom];
                FSPointF *second = [[FSPointF alloc] init];
                [second set:dibRect.left y:dibRect.bottom];
                FSPointF *third = [[FSPointF alloc] init];
                [third set:dibRect.right y:dibRect.top];
                FSPointF *fourth = [[FSPointF alloc] init];
                [fourth set:dibRect.left y:dibRect.top];
                [fsqps set:first second:second third:third fourth:fourth];
            } else if (direction == 3) //text is vertical, right to left
            {
                FSPointF *first = [[FSPointF alloc] init];
                [first set:dibRect.right y:dibRect.top];
                FSPointF *second = [[FSPointF alloc] init];
                [second set:dibRect.right y:dibRect.bottom];
                FSPointF *third = [[FSPointF alloc] init];
                [third set:dibRect.left y:dibRect.top];
                FSPointF *fourth = [[FSPointF alloc] init];
                [fourth set:dibRect.left y:dibRect.bottom];
                [fsqps set:first second:second third:third fourth:fourth];
            }
            [arrayQuads addObject:fsqps];
        }

        FSRectF *rect = [_pdfViewCtrl convertPageViewRectToPdfRect:self.currentEditRect pageIndex:self.pageindex];
        FSPDFPage *page = [_pdfViewCtrl.currentDoc getPage:self.pageindex];
        if (!page)
            return;
        FSMarkup *annot = (FSMarkup *) [page addAnnot:self.type rect:rect];
        annot.NM = [Utility getUUID];
        annot.author = [SettingPreference getAnnotationAuthor];
        annot.color = [_extensionsManager getPropertyBarSettingColor:self.type];
        annot.opacity = [_extensionsManager getAnnotOpacity:self.type] / 100.0;
        annot.quads = arrayQuads;
        annot.createDate = [NSDate date];
        annot.modifiedDate = [NSDate date];
        annot.flags = e_annotFlagPrint;

        if (textPage) {
            NSString *tmp = @"";
            for (int i = 0; i < arrayQuads.count; i++) {
                FSQuadPoints *arrayQuad = [arrayQuads objectAtIndex:i];
                FSRectF *rect = [Utility convertToFSRect:arrayQuad.getFirst p2:arrayQuad.getFourth];
                NSString *text = [textPage getTextInRect:rect];
                if (text.length > 0) {
                    tmp = [tmp stringByAppendingString:[textPage getTextInRect:rect]];
                }
            }
            [annot setContents:tmp];
        }

        if (self.type == e_annotHighlight) {
            annot.subject = @"Highlight";
        } else if (self.type == e_annotSquiggly) {
            annot.subject = @"Squiggly";
        } else if (self.type == e_annotStrikeOut) {
            annot.subject = @"Strikeout";
        } else if (self.type == e_annotUnderline) {
            annot.subject = @"Underline";
        }

        Task *task = [[Task alloc] init];
        task.run = ^() {

            id<IAnnotHandler> annotHandler = [_extensionsManager getAnnotHandlerByAnnot:annot];
            [annotHandler addAnnot:annot];

            CGRect cgRect = [_pdfViewCtrl convertPdfRectToPageViewRect:annot.fsrect pageIndex:self.pageindex];
            cgRect = CGRectInset(cgRect, -20, -20);

            [_pdfViewCtrl refresh:cgRect pageIndex:self.pageindex];
            [self clearSelection];

        };
        [_taskServer executeSync:task];
    }
    return NO;
}

- (BOOL)onPageViewShouldBegin:(int)pageIndex recognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (_extensionsManager.currentToolHandler != self) {
        return NO;
    }
    return YES;
}

- (BOOL)onPageViewTouchesBegan:(int)pageIndex touches:(NSSet *)touches withEvent:(UIEvent *)event {
    return NO;
}

- (BOOL)onPageViewTouchesMoved:(int)pageIndex touches:(NSSet *)touches withEvent:(UIEvent *)event {
    return NO;
}

- (BOOL)onPageViewTouchesEnded:(int)pageIndex touches:(NSSet *)touches withEvent:(UIEvent *)event {
    return NO;
}

- (BOOL)onPageViewTouchesCancelled:(int)pageIndex touches:(NSSet *)touches withEvent:(UIEvent *)event {
    return NO;
}

- (void)onDraw:(int)pageIndex inContext:(CGContextRef)context {
    if (_extensionsManager.currentToolHandler != self) {
        return;
    }
    if (self.startPosIndex == -1 || self.endPosIndex == -1) {
        return;
    }

    self.arraySelectedRect = [self getCurrentSelectRects:pageIndex];
    [self.arraySelectedRect enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGRect selfRect = [obj CGRectValue];
        CGContextSetRGBFillColor(context, 0, 0, 1, 0.3);
        CGContextFillRect(context, selfRect);
    }];
}

@end
