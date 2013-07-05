//
//  GridColorView.m
//  ColorPickerViewTest
//
//  Created by Chen, Duanjin on 7/4/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import "GridColorView.h"

#define COLOR_GRID_ROW 6
#define COLOR_GRID_COL 8
static int LESS_COLOR_TABLE[COLOR_GRID_ROW * COLOR_GRID_COL] = {
    0xffffff, 0xf4cccc, 0xfce5cd, 0xfff2cc, 0xd9ead3, 0xcbf1fe, 0xc9daf8, 0xead1dc,
    0xcccccc, 0xea9999, 0xf9cb9c, 0xffe599, 0xb6d7a8, 0x95e4fd, 0xa4c2f4, 0xd5a6bd,
    0x999999, 0xe06666, 0xf6b26b, 0xffd966, 0x93c47d, 0x00c8fa, 0x6d9eeb, 0xc27ba0,
    0x666666, 0xcc0000, 0xe69138, 0xf1c232, 0x6aa84f, 0x00a5d6, 0x3c78d8, 0xa64d79,
    0x333333, 0x990000, 0xb45f06, 0xbf9000, 0x38761d, 0x006f8e, 0x1155cc, 0x741b47,
    0x000000, 0x660000, 0x783f04, 0x7f6000, 0x274e13, 0x003749, 0x1c4587, 0x4c1130};

@interface GridColorView ()
- (CGRect)colorRectAtPoint:(CGPoint)point;
@end
@implementation GridColorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        rectWidth = 32;
        rectHeight = 28;
        rectSpace = 2;
        CGSize size = CGSizeMake(rectWidth * COLOR_GRID_COL + (COLOR_GRID_COL - 1) * rectSpace, rectHeight * COLOR_GRID_ROW + (COLOR_GRID_ROW - 1) * rectSpace);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
        colRectArray = [[NSMutableArray alloc] initWithCapacity:COLOR_GRID_COL * COLOR_GRID_ROW ];
        for (int row = 1; row <= COLOR_GRID_ROW; ++row) {
            for (int col = 1; col <= COLOR_GRID_COL; ++col) {
                
                CGRect colorRect = CGRectMake((col - 1) * rectWidth + (col - 1) * rectSpace ,
                                              (row -1) * rectHeight + (row - 1) * rectSpace,
                                              rectWidth, rectHeight);
                [colRectArray addObject:[NSValue valueWithCGRect:colorRect]];
            }
        }
    }
    return self;
}

- (void)dealloc
{
    
    [super dealloc];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillRect(context, rect);
    for (int row = 0; row < COLOR_GRID_ROW; ++row) {
        for (int col = 0; col < COLOR_GRID_COL; ++col) {
            UIColor* color = [self colorFromInt:LESS_COLOR_TABLE[row * COLOR_GRID_COL + col ]];
            CGRect colorRect = [[colRectArray objectAtIndex:COLOR_GRID_COL * row + col] CGRectValue];
            CGContextSetFillColorWithColor(context, color.CGColor);
            CGContextAddRect(context, colorRect);
            CGContextFillPath(context);
        }
    }
}

- (UIColor*)colorAtPoint:(CGPoint)point
{
    for (int i = 0; i < [colRectArray count]; ++i) {
        if (CGRectContainsPoint([[colRectArray objectAtIndex:i] CGRectValue], point)) {
            return [self colorFromInt:LESS_COLOR_TABLE[i]];
        }
    }
    return [UIColor whiteColor];
}

- (CGRect)colorRectAtPoint:(CGPoint)point
{
    for (int i = 0; i < [colRectArray count]; ++i) {
        if (CGRectContainsPoint([[colRectArray objectAtIndex:i] CGRectValue], point)) {
            
            return [[colRectArray objectAtIndex:i] CGRectValue];
        }
    }
    return CGRectZero;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    UIColor* color = [self colorAtPoint:point];
    [[self delegate] onColorSelected:color];
}
@end
