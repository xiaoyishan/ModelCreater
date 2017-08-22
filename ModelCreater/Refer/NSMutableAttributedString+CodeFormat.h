//
//  NSMutableAttributedString+CodeFormat.h
//  AutoCode
//
//  Created by Sundear on 2017/8/22.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface NSMutableAttributedString (CodeFormat)
-(NSMutableAttributedString*)YS_ColorStr:(NSString*)str Font:(int)font CustomNameArr:(NSArray*)TypeArr;
@end
