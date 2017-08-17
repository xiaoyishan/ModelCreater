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
    NSDictionary *Dic = [self JsonToDic:json];

    NSString *ModelStr = @"\n\n";

    for (NSString *key in Dic.allKeys) {

        if ([Dic[key] isKindOfClass:[NSString class]]) {
            ModelStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormateStr,key,ModelStr];
        }
        if ([Dic[key] isKindOfClass:[NSArray class]]) {
            ModelStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormateArr,key,ModelStr];
        }
        if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
            ModelStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormateDic,key,ModelStr];
        }
        if ([Dic[key] isKindOfClass:[NSNumber class]]) {
            CGFloat X = [Dic[key] floatValue];
            if (X>floor(X)) {
                ModelStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormateFlot,key,ModelStr];
            }else{
                ModelStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormateInt,key,ModelStr];
            }
        }

    }





    return ModelStr;


}



//json 到字典
+ (NSDictionary*)JsonToDic:(NSString*)json{

    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
