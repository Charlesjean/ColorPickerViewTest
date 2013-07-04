//
//  GridColorView.h
//  ColorPickerViewTest
//
//  Created by Chen, Duanjin on 7/4/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorView.h"

@interface GridColorView : ColorView
{
    int rectWidth;
    int rectHeight;
    int rectSpace;
    NSMutableArray* colRectArray;
}
@end
