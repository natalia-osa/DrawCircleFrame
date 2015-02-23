//
//  DCFButton.m
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 29.7.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "DCFButton.h"

@implementation DCFButton

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
    _dcfView = [[DCFView alloc] init];
    [self addSubview:_dcfView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.dcfView setFrame:self.bounds];
}

@end
