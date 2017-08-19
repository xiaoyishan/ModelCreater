//
//  MJExtension.m
//  QQ
//
//  Created by Sundear on 2017/4/1.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "NSWindow+MJExtension.h"

@implementation NSWindow (MJExtension)
- (void)setMj_x:(CGFloat)mj_x
{
    CGRect frame = self.frame;
    frame.origin.x = mj_x;
    [self setFrame:frame display:YES];
}

- (CGFloat)mj_x
{
    return self.frame.origin.x;
}

- (void)setMj_y:(CGFloat)mj_y
{
    CGRect frame = self.frame;
    frame.origin.y = mj_y;
    [self setFrame:frame display:YES];
}

- (CGFloat)mj_y
{
    return self.frame.origin.y;
}

- (void)setMj_w:(CGFloat)mj_w
{
    CGRect frame = self.frame;
    frame.size.width = mj_w;
    [self setFrame:frame display:YES];
}

- (CGFloat)mj_w
{
    return self.frame.size.width;
}

- (void)setMj_h:(CGFloat)mj_h
{
    CGRect frame = self.frame;
    frame.size.height = mj_h;
    [self setFrame:frame display:YES];
}

- (CGFloat)mj_h
{
    return self.frame.size.height;
}

- (void)setMj_size:(CGSize)mj_size
{
    CGRect frame = self.frame;
    frame.size = mj_size;
    [self setFrame:frame display:YES];
}

- (CGSize)mj_size
{
    return self.frame.size;
}

- (void)setMj_origin:(CGPoint)mj_origin
{
    CGRect frame = self.frame;
    frame.origin = mj_origin;
    [self setFrame:frame display:YES];
}

- (CGPoint)mj_origin
{
    return self.frame.origin;
}
@end
