//
//  ColorView.m
//  ColorPickerViewTest
//
//  Created by Chen, Duanjin on 7/4/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIColor*)colorFromInt:(int)value
{
    return [UIColor colorWithRed:((float)(value & 0xFF))/255.0
                           green:((float)((value & 0xFF00) >> 8))/255.0
							blue:((float)((value & 0xFF0000) >> 16))/255.0 alpha:1.0];
}

@end
