//
//  DCFView.h
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 22.7.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DCFStartPosition) {
    DCFStartPositionTopRight = 0,
    DCFStartPositionTopLeft,
    DCFStartPositionBottomRight,
    DCFStartPositionBottomLeft
};

@interface DCFView : UIView

/// Defines the color of drawn line. Default is redColor.
@property (nonatomic, strong) UIColor *lineColor;

/// Defines the duration of drawing in seconds. Default is 1.5f.
@property (nonatomic, assign) CGFloat animationDuration;

/// Defines the width of drawn line in pixels. Default is 2.f.
@property (nonatomic, assign) CGFloat lineWidth;

/// This is a multiplier to fit the drawing exactly in frame and around the text. Default is 2.25f. Usually will not be changed, you may need to change it if something gets drawn inpropery (too close to the drawing or outside of bounds).
@property (nonatomic, assign) CGFloat bezierApproximation;

/// self.bounds of the drawing gets increased by margin, it is a place where we can draw our line. This way, you can simply set a frame of your button and it will be nicely highlighted. Default 10.f. If you don't want to increase a frame, set it to 0.f.
@property (nonatomic, assign) CGFloat marginValue;

/// Describes start point position of the drawing. Default is DCFStartPositionTopLeft.
@property (nonatomic, assign) DCFStartPosition startPosition;

/// Completion block called when the drawing is finished.
@property (nonatomic, copy) void (^completionBlock)();

/**
 * Advanced:
 * Overload to add custom subviews etc. Please don't forget to call super.
 */
- (void)commonInit;

/**
 * Call this method to redraw whole view. Keep in mind that in meantime you can change all parameters. Changing the params without calling this method won't update the drawing.
 */
- (void)drawBezierAnimated:(BOOL)animate;

@end
