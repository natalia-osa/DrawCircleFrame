//
//  NODCFView.m
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 22.7.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import "NODCFView.h"
#import <QuartzCore/QuartzCore.h>
#import <NOCategories/NOCMacros.h>

@interface NODCFView ()

@property (nonatomic) CAShapeLayer *bezierLayer;

@end

@implementation NODCFView

#pragma mark - Memory management

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
    _startPosition = DCFStartPositionTopLeft;
    _animationDuration = 1.5f;
    _lineWidth = 2.f;
    _lineColor = [UIColor redColor];
    _bezierApproximation = 2.25f;
    _marginValue = 10.f;
}

// increase frame by marginValue
- (void)setFrame:(CGRect)frame {
    frame = CGRectInset(frame, - self.marginValue, - self.marginValue);
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
    CAShapeLayer *bezierLayer = self.bezierLayer;
    if (!bezierLayer) {
        bezierLayer = [[CAShapeLayer alloc] init];
    }
    bezierLayer.path = [self bezierPath].CGPath;
    bezierLayer.strokeColor = self.lineColor.CGColor;
    bezierLayer.fillColor = [UIColor clearColor].CGColor;
    bezierLayer.lineWidth = self.lineWidth;
    bezierLayer.strokeStart = 0.f;
    bezierLayer.strokeEnd = 1.f;
    if (!bezierLayer.superlayer || ![bezierLayer.superlayer isEqual:self.layer]) {
        [self.layer addSublayer:bezierLayer];
    }
    self.bezierLayer = bezierLayer;
    
    if (animate) {
        CABasicAnimation *animateStrokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animateStrokeEnd.duration = self.animationDuration;
        animateStrokeEnd.fromValue = @0.f;
        animateStrokeEnd.toValue = @1.f;
        [CATransaction setCompletionBlock:self.completionBlock];
        [self.bezierLayer addAnimation:animateStrokeEnd forKey:@"strokeEndAnimation"];
        [CATransaction commit];
    }
}

- (UIBezierPath *)bezierPath {
    // circle points
    CGRect rect = CGRectMake(self.marginValue,
                             self.marginValue,
                             CGRectGetWidth(self.bounds) - 2 * self.marginValue,
                             CGRectGetHeight(self.bounds) - 2 * self.marginValue);
    CGPoint point1, point2, point12, point21;;
    
    switch (self.startPosition) {
        case DCFStartPositionTopRight: {
            point1 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + noc_floorCGFloat(self.marginValue / 2));
            point2 = CGPointMake(CGRectGetMaxX(rect) - noc_floorCGFloat(self.marginValue / 2), CGRectGetMinY(rect) - self.marginValue);
            point12 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) * self.bezierApproximation);
            point21 = CGPointMake(- noc_floorCGFloat(CGRectGetMaxX(rect) * self.bezierApproximation / 2), CGRectGetMinY(rect));
            break;
        } case DCFStartPositionTopLeft: {
            point1 = CGPointMake(CGRectGetMinX(rect) - self.marginValue, CGRectGetMinY(rect) + noc_floorCGFloat(self.marginValue / 2));
            point2 = CGPointMake(CGRectGetMinX(rect) + noc_floorCGFloat(self.marginValue / 2), CGRectGetMinY(rect) - self.marginValue);
            point12 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) * self.bezierApproximation);
            point21 = CGPointMake(CGRectGetMaxX(rect) * self.bezierApproximation, CGRectGetMinY(rect));
            break;
        } case DCFStartPositionBottomRight: {
            point1 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - noc_floorCGFloat(self.marginValue / 2));
            point2 = CGPointMake(CGRectGetMaxX(rect) - noc_floorCGFloat(self.marginValue / 2), CGRectGetMaxY(rect) + self.marginValue);
            point12 = CGPointMake(CGRectGetMaxX(rect), - CGRectGetMinY(rect) * self.bezierApproximation);
            point21 = CGPointMake(- noc_floorCGFloat(CGRectGetMaxX(rect) * self.bezierApproximation / 2), CGRectGetMaxY(rect));
            break;
        } case DCFStartPositionBottomLeft: {
            point1 = CGPointMake(CGRectGetMinX(rect) - self.marginValue, CGRectGetMaxY(rect) - noc_floorCGFloat(self.marginValue / 2));
            point2 = CGPointMake(CGRectGetMinX(rect) + noc_floorCGFloat(self.marginValue / 2), CGRectGetMaxY(rect) + self.marginValue);
            point12 = CGPointMake(CGRectGetMinX(rect), - CGRectGetMinY(rect) * self.bezierApproximation);
            point21 = CGPointMake(CGRectGetMaxX(rect) * self.bezierApproximation, CGRectGetMaxY(rect));
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

#pragma mark - Logging

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@: %lu, %@: %@, %@: %f, %@: %f>",
            NSStringFromClass([self class]), self,
            NSStringFromSelector(@selector(startPosition)), (long)self.startPosition,
            NSStringFromSelector(@selector(lineColor)), self.lineColor,
            NSStringFromSelector(@selector(lineWidth)), self.lineWidth,
            NSStringFromSelector(@selector(animationDuration)), self.animationDuration];
}

@end
