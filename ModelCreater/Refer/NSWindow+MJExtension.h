//
//  MJExtension.h
//  QQ
//
//  Created by Sundear on 2017/4/1.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSWindow (MJExtension)
@property (assign, nonatomic) CGFloat mj_x;
@property (assign, nonatomic) CGFloat mj_y;
@property (assign, nonatomic) CGFloat mj_w;
@property (assign, nonatomic) CGFloat mj_h;
@property (assign, nonatomic) CGSize mj_size;
@property (assign, nonatomic) CGPoint mj_origin;
@end
