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

    NSColor *IvarColor = [NSColor colorWithRed:43/255.0 green:131/255.0 blue:159/255.0 alpha:1];
    NSColor *NoteColor = [NSColor colorWithRed:15/255.0 green:112/255.0 blue:1/255.0 alpha:1];


//    //blue
//    NSArray *Ivar = @[@"@property (nonatomic,",
//                      @"weak)",
//                      @"assign)",
//                      @"strong)",
//                      @"copy)",
//                      @"unsafe_unretained)",
//                      @"nonatomic)",
//                      @"IBOutlet",
//                      @"@end",
//                      @"@implementation",
//                      @"@interface",
//                      ];
//
//    //dark green
//    NSMutableArray *Type = @[@"//",
//                             @"IBOutlet",
//                             @"NSInteger",
//                             @"CGFloat",
//                             @"NSString",
//                             @"NSArray",
//                             @"NSDictionary",
//                             @"NSObject",
//                             @"BOOL",
//                             @"UILabel",
//                             @"UITextField",
//                             @"UIButton",
//                             ].mutableCopy;
//    if(TypeArr)[Type addObjectsFromArray:TypeArr];



    // property type List
    NSArray *types = @[@"NSInteger",
                       @"CGFloat",
                       @"NSString",
                       @"NSArray",
                       @"NSDictionary",
                       @"NSObject",
                       @"BOOL",
                       @"UILabel",
                       @"UITextField",
                       @"UIButton",
                       ];



    NSMutableAttributedString *attributeString  = [NSMutableAttributedString new];
    [attributeString beginEditing];


    NSArray *attArr = [str componentsSeparatedByString:@"\n"];

    for (int k=0; k<attArr.count; k++) {
        NSString *subString = [NSString stringWithFormat:@"%@\n",attArr[k]];
        NSMutableAttributedString *subAtt = [[NSMutableAttributedString alloc]initWithString:subString];

        // property
        if ([subString componentsSeparatedByString:@")"].count==2) {

            NSInteger propertyLength = [subString componentsSeparatedByString:@")"].firstObject.length+1;
            [subAtt addAttribute:NSForegroundColorAttributeName
                                    value:[NSColor blueColor]
                                    range:NSMakeRange(0, propertyLength)];


            // green type
            for (NSString *key in types) {
                if ([subString containsString:key]) {

                    NSInteger length = [subString componentsSeparatedByString:key].firstObject.length + key.length - propertyLength;
                    [subAtt addAttribute:NSForegroundColorAttributeName
                                   value:IvarColor
                                   range:NSMakeRange(propertyLength, length)];
                }
            }

            //custom TypeArr
            if ([subString containsString:@"Model *"]) {

                NSInteger modelP = [subString componentsSeparatedByString:@"Model *"].firstObject.length;
                NSInteger location;
                // “<” " "
                if ([subString containsString:@"<"]) {
                    location = [subString componentsSeparatedByString:@"<"].firstObject.length+1;
                }else{
                    location = [subString componentsSeparatedByString:@") "].firstObject.length+1;
                }

                [subAtt addAttribute:NSForegroundColorAttributeName
                               value:IvarColor
                               range:NSMakeRange(location, modelP-location+5)];
            }




        }








        // interface
        if ([subString containsString:@"@interface"]) {
            [subAtt addAttribute:NSForegroundColorAttributeName
                           value:[NSColor blueColor]
                           range:NSMakeRange(0, 10)];
            [subAtt addAttribute:NSForegroundColorAttributeName
                           value:IvarColor
                           range:NSMakeRange(10, subString.length-10)];
            [subAtt addAttribute:NSForegroundColorAttributeName
                           value:[NSColor blackColor]
                           range:NSMakeRange([subString componentsSeparatedByString:@":"].firstObject.length, 1)];

        }
        // implementation
        if ([subString containsString:@"@implementation"]) {
            [subAtt addAttribute:NSForegroundColorAttributeName
                           value:[NSColor blueColor]
                           range:NSMakeRange(0, 15)];
            [subAtt addAttribute:NSForegroundColorAttributeName
                           value:IvarColor
                           range:NSMakeRange(15, subString.length-15)];
        }
        // end
        if ([subString containsString:@"@end"]) {
            [subAtt addAttribute:NSForegroundColorAttributeName
                           value:[NSColor blueColor]
                           range:NSMakeRange(0, 4)];
        }

        //note
        if ([subString containsString:@"//"]) {
            NSInteger localtion = [subString componentsSeparatedByString:@"//"].firstObject.length;
            [subAtt addAttribute:NSForegroundColorAttributeName
                           value:NoteColor
                           range:NSMakeRange(localtion, subString.length-localtion)];
        }
        if ([subString containsString:@"/**/"]) {
            NSInteger localtion = [subString componentsSeparatedByString:@"//"].firstObject.length;
            [subAtt addAttribute:NSForegroundColorAttributeName
                           value:NoteColor
                           range:NSMakeRange(localtion, subString.length-localtion)];
        }




        [attributeString appendAttributedString:subAtt];
    }




    [attributeString endEditing];

    return attributeString;
}

@end
