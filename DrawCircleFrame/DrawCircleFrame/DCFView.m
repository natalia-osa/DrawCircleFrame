//
//  DCFView.m
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 22.7.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "DCFView.h"
#import <QuartzCore/QuartzCore.h>

@interface DCFView ()

@property (nonatomic, strong) CAShapeLayer *bezierLayer;

@end

@implementation DCFView

#pragma mark - Inits

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setOpaque:NO];
    [self setAutoresizesSubviews:YES];
    [self setContentMode:UIViewContentModeRedraw];
    [self.layer setMasksToBounds:YES];
    
    // default values
    self.startPosition = DCFStartPositionTopLeft;
    self.animationDuration = 1.5f;
    self.lineWidth = 2.f;
    self.lineColor = [UIColor redColor];
    self.bezierApproximation = 2.25f;
    self.marginValue = 10.f;
}

// increase frame by marginValue
- (void)setFrame:(CGRect)frame {
    frame = CGRectInset(frame, - _marginValue, - _marginValue);
    [super setFrame:frame];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    // setup context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    // draw background color
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, self.bounds);
}

#pragma mark - Bezier path

- (void)drawBezierAnimated:(BOOL)animate {
    if (!_bezierLayer) {
        _bezierLayer = [[CAShapeLayer alloc] init];
    }
    _bezierLayer.path = [self bezierPath].CGPath;
    _bezierLayer.strokeColor = _lineColor.CGColor;
    _bezierLayer.fillColor = [UIColor clearColor].CGColor;
    _bezierLayer.lineWidth = _lineWidth;
    _bezierLayer.strokeStart = 0.f;
    _bezierLayer.strokeEnd = 1.f;
    if (!_bezierLayer.superlayer || ![_bezierLayer.superlayer isEqual:self.layer]) {
        [self.layer addSublayer:_bezierLayer];
    }
    
    if (animate) {
        CABasicAnimation *animateStrokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animateStrokeEnd.duration = _animationDuration;
        animateStrokeEnd.fromValue = @0.f;
        animateStrokeEnd.toValue = @1.f;
        [CATransaction setCompletionBlock:_completionBlock];
        [_bezierLayer addAnimation:animateStrokeEnd forKey:@"strokeEndAnimation"];
        [CATransaction commit];
    }
}

- (UIBezierPath *)bezierPath {
    // circle points
    CGRect rect = CGRectMake(_marginValue, _marginValue, CGRectGetWidth(self.bounds) - 2 * _marginValue, CGRectGetHeight(self.bounds) - 2 * _marginValue);
    CGPoint point1, point2, point12, point21;;
    
    switch (_startPosition) {
        case DCFStartPositionTopRight: {
            point1 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + floorf(_marginValue / 2));
            point2 = CGPointMake(CGRectGetMaxX(rect) - floorf(_marginValue / 2), CGRectGetMinY(rect) - _marginValue);
            point12 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) * _bezierApproximation);
            point21 = CGPointMake(- floorf(CGRectGetMaxX(rect) * _bezierApproximation / 2), CGRectGetMinY(rect));
            break;
        } case DCFStartPositionTopLeft: {
            point1 = CGPointMake(CGRectGetMinX(rect) - _marginValue, CGRectGetMinY(rect) + floorf(_marginValue / 2));
            point2 = CGPointMake(CGRectGetMinX(rect) + floorf(_marginValue / 2), CGRectGetMinY(rect) - _marginValue);
            point12 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) * _bezierApproximation);
            point21 = CGPointMake(CGRectGetMaxX(rect) * _bezierApproximation, CGRectGetMinY(rect));
            break;
        } case DCFStartPositionBottomRight: {
            point1 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - floorf(_marginValue / 2));
            point2 = CGPointMake(CGRectGetMaxX(rect) - floorf(_marginValue / 2), CGRectGetMaxY(rect) + _marginValue);
            point12 = CGPointMake(CGRectGetMaxX(rect), - CGRectGetMinY(rect) * _bezierApproximation);
            point21 = CGPointMake(- floorf(CGRectGetMaxX(rect) * _bezierApproximation / 2), CGRectGetMaxY(rect));
            break;
        } case DCFStartPositionBottomLeft: {
            point1 = CGPointMake(CGRectGetMinX(rect) - _marginValue, CGRectGetMaxY(rect) - floorf(_marginValue / 2));
            point2 = CGPointMake(CGRectGetMinX(rect) + floorf(_marginValue / 2), CGRectGetMaxY(rect) + _marginValue);
            point12 = CGPointMake(CGRectGetMinX(rect), - CGRectGetMinY(rect) * _bezierApproximation);
            point21 = CGPointMake(CGRectGetMaxX(rect) * _bezierApproximation, CGRectGetMaxY(rect));
            break;
        } default: {
            NSAssert(NO, @"You have provided unhandled start position of DCF");
            
            return nil;
        }
    }
    
    // create bezier path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addCurveToPoint:point2 controlPoint1:point12 controlPoint2:point21];
    
    return path;
}

@end
