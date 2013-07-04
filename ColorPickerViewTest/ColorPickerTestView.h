//
//  ColorPickerTestView.h
//  ColorPickerViewTest
//
//  Created by Chen, Duanjin on 7/4/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorView.h"
#import "GridColorView.h"
#import "WheelColorView.h"

@interface ColorPickerTestView : UIView < ColorSelectionDelegate >
{
    GridColorView* mpGridColorView;
    WheelColorView* mpWheelColorView;
    UIButton* mpChangeViewBtn;
    UIColor* selectedColor;
    bool isGridColorView;
    UIImage* mpWheelViewImg;
    UIImage* mpGridViewImg;
}

@end
