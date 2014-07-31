//
//  DCFExampleView.m
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 22.7.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "DCFExampleView.h"
#import "NSString+Size.h"

@interface DCFExampleView ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation DCFExampleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentMode:UIViewContentModeRedraw];
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor orangeColor] CGColor], (id)[[UIColor yellowColor] CGColor], nil];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
        
        _button = [[DCFButton alloc] init];
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
    
    CGSize buttonSize = [_button.titleLabel.text ios67sizeWithFont:_button.titleLabel.font constrainedToSize:CGSizeMake(300.f, 200.f)];
    CGRect buttonRect = CGRectMake(floorf((CGRectGetWidth(rect) - buttonSize.width) / 2.f), floorf((CGRectGetHeight(rect) - buttonSize.height) / 2.f), buttonSize.width, buttonSize.height);
    [_button setFrame:buttonRect];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    
    [self.layer.sublayers[0] setFrame:self.bounds];
}

@end
