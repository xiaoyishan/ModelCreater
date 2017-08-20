//
//  RootWindowC.m
//  AutoCode
//
//  Created by Ys on 2017/8/20.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "RootWindowC.h"
#import "AppDelegate.h"

@interface RootWindowC ()

@end

@implementation RootWindowC

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    AppDelegate* app =(AppDelegate*)[NSApplication sharedApplication].delegate;
    
    [self.window makeKeyWindow];
//    self.window.accessibilityHidden = NO;
//    self.window.titleVisibility = NSWindowTitleHidden;
//    self.window.styleMask |= NSFullSizeContentViewWindowMask;
//    self.window.titlebarAppearsTransparent = YES;
    
    app.RootWindow = self.window;
}

@end
