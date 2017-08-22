//
//  NSTextView+MyViewController.h
//  AutoCode
//
//  Created by Sundear on 2017/8/22.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTextView (MyViewController)
- (NSDictionary *)defaultTextAttributes:(BOOL)forRichText;
- (void)removeAttachments;
//- (void)setRichText:(BOOL)flag;
@end
