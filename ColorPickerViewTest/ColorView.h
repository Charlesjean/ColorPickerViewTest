//
//  ColorView.h
//  ColorPickerViewTest
//
//  Created by Chen, Duanjin on 7/4/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorSelectionDelegate <NSObject>
- (void)onColorSelected:(UIColor*)color;
@end

@interface ColorView : UIView
- (UIColor*)colorFromInt:(int)value;
@property(nonatomic, assign)id<ColorSelectionDelegate> delegate;
@end
