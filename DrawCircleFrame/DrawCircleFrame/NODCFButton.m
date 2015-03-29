//
//  NODCFButton.m
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 29.7.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import "NODCFButton.h"

@implementation NODCFButton

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
    _dcfView = [[NODCFView alloc] init];
    [self addSubview:_dcfView];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.dcfView setFrame:self.bounds];
}

@end
