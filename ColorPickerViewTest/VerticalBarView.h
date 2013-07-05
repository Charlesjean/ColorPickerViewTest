//
//  VerticalBarView.h
//  ColorPickerViewTest
//
//  Created by Chen Duanjin on 7/5/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalBarView : UIView
{
    UIColor* mpColor;
    float hue;
    float saturation;
    float brightness;
    CGPoint selectionPoint;
}
- (id)initWithFrame:(CGRect)frame withColor:(UIColor*)color;
- (void)updateColor:(UIColor*)color;
- (UIColor*)colorAtPoint:(CGPoint)point;
@end
