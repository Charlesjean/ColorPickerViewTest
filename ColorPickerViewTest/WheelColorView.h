//
//  ColorWheelView.h
//  ColorPickerViewTest
//
//  Created by Chen, Duanjin on 7/4/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorView.h"
#import "VerticalBarView.h"
@interface WheelColorView : ColorView
{
    UIImage* mpWheelColorImg;
    CGPoint mpSelectedColPos;
    VerticalBarView* mpVerticalBar;
}
@end
