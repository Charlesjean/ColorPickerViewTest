//
//  ColorWheelView.m
//  ColorPickerViewTest
//
//  Created by Chen, Duanjin on 7/4/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import "WheelColorView.h"
#define COLOR_PANE_WIDTH 178
#define COLOR_PANE_HEIGHT 178

@implementation WheelColorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = CGSizeMake(270, 178);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSaveGState(context);
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, COLOR_PANE_WIDTH, COLOR_PANE_HEIGHT));
    CGContextClip(context);
    float halfWidth = COLOR_PANE_WIDTH / 2.0f;
    float halfHeight = COLOR_PANE_HEIGHT / 2.0f;
    float radius = sqrtf(halfWidth * halfWidth + halfHeight * halfHeight);
    CGPoint center;
    center.x = COLOR_PANE_WIDTH / 2.0f;
    center.y = COLOR_PANE_HEIGHT / 2.0f;
    for (int i = 0; i < COLOR_PANE_WIDTH; ++i) {
        for (int j = 0; j < COLOR_PANE_HEIGHT; ++j) {
            float xdis = i - center.x;
            float ydis = j - center.y;
            float hue =atan2f(xdis, ydis);
            if (hue < 0) {
                hue += 2* M_PI;
            }
            hue = hue / (2*M_PI);
            float saturation = sqrtf(xdis * xdis + ydis * ydis) / radius;
            float brightness = 1.0;
            UIColor* color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
            CGContextSetFillColorWithColor(context, color.CGColor);
            CGContextAddRect(context, CGRectMake(i, j, 1, 1));
            CGContextFillPath(context);
            CGContextClosePath(context);
        }
    }
    CGContextRestoreGState(context);
}

- (UIColor*)colorAtPoint:(CGPoint)point
{
    CGPoint center;
    center.x = COLOR_PANE_WIDTH / 2.0f;
    center.y = COLOR_PANE_HEIGHT / 2.0f;
    float radius = sqrtf(center.x * center.x + center.y * center.y);
    float xdis = point.x - center.x;
    float ydis = point.y - center.y;
    float hue =atan2f(xdis, ydis);
    if (hue < 0) {
        hue += 2* M_PI;
    }
    hue = hue / (2*M_PI);
    float saturation = sqrtf(xdis * xdis + ydis * ydis) / radius;
    float brightness = 1.0;
    UIColor* color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
    return color;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.delegate onColorSelected:[self colorAtPoint:point]];
}
@end
