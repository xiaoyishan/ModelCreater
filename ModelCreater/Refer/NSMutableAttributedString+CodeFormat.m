//
//  NSMutableAttributedString+CodeFormat.m
//  AutoCode
//
//  Created by Sundear on 2017/8/22.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "NSMutableAttributedString+CodeFormat.h"

@implementation NSMutableAttributedString (CodeFormat)


-(NSMutableAttributedString*)YS_ColorStr:(NSString*)str Font:(int)font CustomNameArr:(NSArray*)TypeArr{

    //blue
    NSArray *Ivar = @[@"@property (nonatomic,",
                      @"weak)",
                      @"assign)",
                      @"strong)",
                      @"copy)",
                      @"unsafe_unretained)",
                      @"nonatomic)",
                      @"IBOutlet",
                      @"@end",
                      @"@implementation",
                      @"@interface",
                      ];

    //dark green
    NSMutableArray *Type = @[@"//",
                             @"IBOutlet",
                             @"NSInteger",
                             @"CGFloat",
                             @"NSString",
                             @"NSArray",
                             @"NSDictionary",
                             @"NSObject",
                             @"BOOL",
                             @"UILabel",
                             @"UITextField",
                             @"UIButton",
                             ].mutableCopy;
    if(TypeArr)[Type addObjectsFromArray:TypeArr];


    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:str];
    for (int i = 0; i < str.length; i ++) {
        NSString *a = [str substringWithRange:NSMakeRange(i, 1)];

        if ([Ivar containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:[NSColor blueColor],
                                             NSFontAttributeName:[NSFont systemFontOfSize:font]}
                                     range:NSMakeRange(i, 1)];
        }

        if ([Type containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:[NSColor greenColor],
                                             NSFontAttributeName:[NSFont systemFontOfSize:font]}
                                     range:NSMakeRange(i, 1)];
        }
    }

    return attributeString;
}

@end
