//
//  ViewController.m
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)ToModel:(id)sender {
    NSString *json = [_InputTextView accessibilityValue];
    _OutputTextView.accessibilityValue = [[JsonFormatToModel new] TranslateToModelCode:json RootClassName:_RootNameField.stringValue];
}
- (IBAction)ToView:(id)sender {
    
}

@end
