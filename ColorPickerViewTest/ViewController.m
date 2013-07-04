//
//  ViewController.m
//  ColorPickerViewTest
//
//  Created by Chen, Duanjin on 7/4/13.
//  Copyright (c) 2013 Chen, Duanjin. All rights reserved.
//

#import "ViewController.h"

#import "ColorPickerTestView.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ColorPickerTestView* colorContainer = [[ColorPickerTestView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [self.view addSubview:colorContainer];
    [colorContainer release];    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
