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

@interface WheelColorView()
- (void)createWheelColorImg;
- (CGPoint)positionOfColor:(UIColor*)color;
@end

@implementation WheelColorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = CGSizeMake(270, 178);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
        [self createWheelColorImg];
        mpSelectedColPos = CGPointZero;
    }
    return self;
}

- (void)dealloc{
    [mpWheelColorImg release];
    [super dealloc];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSaveGState(context);
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, COLOR_PANE_WIDTH, COLOR_PANE_HEIGHT));
    CGContextClip(context);

    CGContextDrawImage(context, CGRectMake(0, 0, COLOR_PANE_WIDTH, COLOR_PANE_HEIGHT), mpWheelColorImg.CGImage);
    CGContextRestoreGState(context);
    if (!(mpSelectedColPos.x == 0 && mpSelectedColPos.y == 0)) 
        CGContextStrokeEllipseInRect(context, CGRectMake(mpSelectedColPos.x - 4, mpSelectedColPos.y - 4, 9, 9));
}

- (UIColor*)colorAtPoint:(CGPoint)point
{
    CGPoint center;
    center.x = COLOR_PANE_WIDTH / 2.0f;
    center.y = COLOR_PANE_HEIGHT / 2.0f;
    float radius = sqrtf(center.x * center.x + center.y * center.y);
    float xdis = point.x - center.x;
    float ydis = point.y - center.y;
    if (xdis * xdis + ydis * ydis > center.x * center.x) {
        return nil;
    }
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
    UIColor* color = [self colorAtPoint:point];
    if (color != nil) {
        mpSelectedColPos = point;
        [self.delegate onColorSelected:color];
        [self setNeedsDisplay];
    }
    
}

- (void)createWheelColorImg
{
    size_t width = COLOR_PANE_WIDTH;
    size_t height = COLOR_PANE_HEIGHT;
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = 4 * COLOR_PANE_WIDTH;
    void* data = malloc(bytesPerRow * COLOR_PANE_HEIGHT);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(data, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    
    float halfWidth = COLOR_PANE_WIDTH / 2.0f;
    float halfHeight = COLOR_PANE_HEIGHT / 2.0f;
    float radius = halfWidth;
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
            CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
            CGContextAddRect(bitmapContext, CGRectMake(i, j, 1, 1));
            CGContextFillPath(bitmapContext);
        }
    }
    mpWheelColorImg = [[UIImage alloc] initWithCGImage:CGBitmapContextCreateImage(bitmapContext)];
    CGColorSpaceRelease(colorSpace);
    char* data2 = CGBitmapContextGetData(bitmapContext);
    CGContextRelease(bitmapContext);
    if (data2 != NULL) {
        free(data2);
    }
}

- (CGPoint)positionOfColor:(UIColor *)color
{
    float hue,saturation,bright,alpha;
    [color getHue:&hue saturation:&saturation brightness:&bright alpha:&alpha];
    float radius = saturation * COLOR_PANE_WIDTH / 2;
    return CGPointMake(radius * cosf(hue) + COLOR_PANE_WIDTH / 2.0f, radius * sinf(hue) + COLOR_PANE_WIDTH / 2.0f);
    
}

@end
