//
//  NODCFExampleView.m
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 22.7.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import "NODCFExampleView.h"
#import <NOCategories/NSString+NOCSize.h>
#import <NOCategories/NOCCGFloatMath.h>

@interface NODCFExampleView ()

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;

@end

@implementation NODCFExampleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentMode:UIViewContentModeRedraw];
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor orangeColor] CGColor], (id)[[UIColor yellowColor] CGColor], nil];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
        
        _button = [[NODCFButton alloc] init];
        [_button setTitle:NSLocalizedString(@"There is an animation around me!", nil) forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button.dcfView setLineColor:[UIColor blueColor]];
        [_button.dcfView setStartPosition:DCFStartPositionBottomLeft];
        [_button.dcfView setLineWidth:5.f];
        [_button.dcfView setAnimationDuration:4.f];
        [self addSubview:_button];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.bounds;
    
    CGSize maxButtonSize = CGSizeMake(300.f, 200.f);
    CGSize buttonSize = [self.button.titleLabel.text noc_backwardCompatibleSizeWithFont:self.button.titleLabel.font constrainedToSize:maxButtonSize];
    CGRect buttonRect = CGRectMake(noc_floorCGFloat((CGRectGetWidth(rect) - buttonSize.width) / 2.f),
                                   noc_floorCGFloat((CGRectGetHeight(rect) - buttonSize.height) / 2.f),
                                   buttonSize.width, buttonSize.height);
    [self.button setFrame:buttonRect];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    
    [self.layer.sublayers[0] setFrame:self.bounds];
}

@end
