//
//  NSString+Size.m
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 28.7.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)ios67sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize textSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        textSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        textSize = [self sizeWithFont:font constrainedToSize:size];
#pragma clang diagnostic pop
    }
    
    return textSize;
}

@end
