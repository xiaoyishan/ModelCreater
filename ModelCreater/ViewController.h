//
//  ViewController.h
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"
#import "JsonFormatToModel.h"
#import "NSWindow+MJExtension.h"
#import "NSView+MJExtension.h"
#import "NSTextView+MyViewController.h"


@interface ViewController : NSViewController

@property (unsafe_unretained) IBOutlet NSTextView *InputTextView;
@property (unsafe_unretained) IBOutlet NSTextView *OutputTextView;
@property (weak) IBOutlet NSScrollView *OutPutView;



@property (weak) IBOutlet NSTextField *RootNameField;
@property (weak) IBOutlet NSButton *IBCheckBtn;
@property (weak) IBOutlet NSButton *NullCheckBtn;
@property (weak) IBOutlet NSPopUpButton *CodemodeCheckBtn;



@property (weak) IBOutlet NSTextField *OutPutFeild;

@property (weak) IBOutlet NSPopUpButton *NoteTypeMenu;
@property (weak) IBOutlet NSPopUpButton *NoteDirectionMenu;


@end





