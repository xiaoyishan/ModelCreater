//
//  ViewController.h
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "JsonFormatToModel.h"

@interface ViewController : NSViewController
@property (unsafe_unretained) IBOutlet NSTextView *InputTextView;
@property (unsafe_unretained) IBOutlet NSTextView *OutputTextView;
@property (weak) IBOutlet NSTextField *RootNameField;
@end




