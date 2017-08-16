//
//  JsonFormatToModel.m
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "JsonFormatToModel.h"

const NSString *FormateInt  = @"@property (nonatomic, assign) NSInteger ";
const NSString *FormateFlot = @"@property (nonatomic, assign) CGFloat ";
const NSString *FormateStr  = @"@property (nonatomic, copy) NSString *";
const NSString *FormateArr  = @"@property (nonatomic, strong) NSArray *";
const NSString *FormateDic  = @"@property (nonatomic, strong) NSDictionary *";




@implementation JsonFormatToModel

+(NSString*)TranslateToModelCode:(NSString*)json{
    NSDictionary *Dic = [self JsonToDic];
    return @"aasaa";
}



//json 到字典
+ (NSDictionary*)JsonToDic{
    if (self == nil) return nil;
    NSData *jsonData = [(NSString*)self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
