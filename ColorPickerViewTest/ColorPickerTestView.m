//
//  ColorPickerTestView.m
//  ColorPickerViewTest
//
//  Created by Chen, Duanjin on 7/4/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import "ColorPickerTestView.h"
#import "GridColorView.h"
#import "WheelColorView.h"

@implementation ColorPickerTestView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        selectedColor = [[UIColor whiteColor] retain];
        
        isGridColorView = YES;
        mpGridColorView = [[GridColorView alloc] initWithFrame:CGRectMake(20, 50, 50, 50)];
        mpGridColorView.delegate = self;
        [self addSubview:mpGridColorView];
        [mpGridColorView release];
        mpWheelColorView = [[WheelColorView alloc] initWithFrame:CGRectMake(20, 50, 50, 50)];
        mpWheelColorView.delegate = self;
        [self addSubview:mpWheelColorView];
        mpWheelColorView.hidden = YES;
        [mpWheelColorView release];
        
        mpChangeViewBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [mpChangeViewBtn setFrame:CGRectMake(20, mpGridColorView.frame.origin.y + mpGridColorView.frame.size.height + 10, mpGridColorView.frame.size.width, 40)];
        
        [mpChangeViewBtn setTitle:@"More Color..." forState:UIControlStateNormal];
        [mpChangeViewBtn addTarget:self action:@selector(changeColorView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mpChangeViewBtn];
        
        
    }
    return self;
}

- (void)dealloc
{
    [mpGridColorView removeFromSuperview];
    [selectedColor release];
    [super dealloc];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, selectedColor.CGColor);
    CGContextFillRect(context, rect);
    CGContextFillPath(context);
}

- (void)changeColorView
{
    
    [UIView animateWithDuration:0.4 animations:^{
        if (isGridColorView) {
            mpGridColorView.alpha = 0.0;
            mpWheelColorView.alpha = 1.0;
        }
        else{
            mpGridColorView.alpha = 1.0;
            mpWheelColorView.alpha = 0.0;
        }
        
    } completion:^(BOOL finished){
        if (isGridColorView) {
            mpGridColorView.hidden = YES;
            mpWheelColorView.hidden = NO;
            [mpChangeViewBtn setTitle:@"Less Color..." forState:UIControlStateNormal];
        }
        else
        {
            mpGridColorView.hidden = NO;
            mpWheelColorView.hidden = YES;
            [mpChangeViewBtn setTitle:@"More Color..." forState:UIControlStateNormal];
        }
        
        isGridColorView = !isGridColorView;
        
    }];
}

- (void)onColorSelected:(UIColor*)color
{
    [selectedColor release];
    selectedColor = [color retain];
    [self setNeedsDisplay];
}


@end
