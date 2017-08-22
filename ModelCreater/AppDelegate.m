//
//  AppDelegate.m
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    // Insert code here to initialize your application
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication
                    hasVisibleWindows:(BOOL)flag{

    [self.RootWindow makeKeyAndOrderFront:self];
    return YES;
}


- (void)applicationWillFinishLaunching:(NSNotification *)notification{

}

- (void)applicationWillHide:(NSNotification *)notification{

}
- (void)applicationDidHide:(NSNotification *)notification{

}
- (void)applicationWillUnhide:(NSNotification *)notification{

}
- (void)applicationDidUnhide:(NSNotification *)notification{

}
- (void)applicationWillBecomeActive:(NSNotification *)notification{

}
- (void)applicationDidBecomeActive:(NSNotification *)notification{

}
- (void)applicationWillResignActive:(NSNotification *)notification{
    [self.RootWindow makeKeyAndOrderFront:self];
}



- (void)applicationDidResignActive:(NSNotification *)notification{

}
- (void)applicationWillUpdate:(NSNotification *)notification{

}
- (void)applicationDidUpdate:(NSNotification *)notification{

}
- (void)applicationWillTerminate:(NSNotification *)notification{

}
- (void)applicationDidChangeScreenParameters:(NSNotification *)notification{

}
- (void)applicationDidChangeOcclusionState:(NSNotification *)notification{

}


@end
