//
//  VerticalBarView.m
//  ColorPickerViewTest
//
//  Created by chenduanjin@gmail.com on 7/5/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import "VerticalBarView.h"

@implementation VerticalBarView

- (id)initWithFrame:(CGRect)frame withColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor redColor]];
        mpColor = [color retain];
        self.userInteractionEnabled = NO;
        selectionPoint = CGPointZero;
    }
    return self;
}

- (void)dealloc
{
    [mpColor release];
    [super dealloc];
}

- (void)drawRect:(CGRect)rect
{
    float alpha;
    [mpColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    CGContextRef context = UIGraphicsGetCurrentContext();
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    
    for (int i = 0; i < height; ++i) {
        UIColor* fillColor = [UIColor colorWithHue:hue saturation:saturation brightness:i / height alpha:1.0];
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillRect(context, CGRectMake(0, i, width, 1));
    }
    if (!(selectionPoint.x == 0 && selectionPoint.y == 0)) {
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillRect(context, CGRectMake(0, selectionPoint.y, self.frame.size.width, 1));
    }
}

- (void)updateColor:(UIColor *)color
{
    [mpColor release];
    mpColor = [color retain];
    [self setNeedsDisplay];
}

- (UIColor*)colorAtPoint:(CGPoint)point
{
    if (!CGRectContainsPoint(self.bounds, point))
        return nil;
    selectionPoint = point;
    UIColor* color = [UIColor colorWithHue:hue saturation:saturation brightness:point.y / self.bounds.size.height alpha:1.0];
    [self setNeedsDisplay];
    return  color;
}


@end
