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

#define     CustomArr(x)    [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray<%@ *> *", x]
#define     CustomDic(x)    [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *", x]


const NSString *End  = @"@end";

#define     Interface(name)    [NSString stringWithFormat:@"@interface %@ : NSObject", name]
#define     implement(name)    [NSString stringWithFormat:@"@implementation %@ ", name]

@implementation JsonFormatToModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        ModelStr = @"";
    }
    return self;
}



-(NSString*)TranslateToModelCode:(NSString*)json RootClassName:(NSString*)className{
    NSDictionary *Dic = [self JsonToDic:json];

    NSString *CurrentStr = @"";

    for (NSString *key in Dic.allKeys) {

        if ([Dic[key] isKindOfClass:[NSString class]]) {
            CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormateStr,key,CurrentStr];
        }
        if ([Dic[key] isKindOfClass:[NSArray class]]) {
            CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", CustomArr(key),key,CurrentStr];
        }
        if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
            CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", CustomDic(key),key,CurrentStr];
        }
        if ([Dic[key] isKindOfClass:[NSNumber class]]) {
            CGFloat X = [Dic[key] floatValue];
            if (X>floor(X)) {
                CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormateFlot,key,CurrentStr];
            }else{
                CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormateInt,key,CurrentStr];
            }
        }

    }


    if (![ModelStr containsString:CurrentStr]) {
        if(className.length==0)className=@"RootClass";
        ModelStr = [NSString stringWithFormat:@"\n//\n%@\n%@%@\n%@",Interface(className),CurrentStr, End,ModelStr];
    }


    for (NSString *key in Dic.allKeys) {
        if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
            [self TranslateToModelCode:[self Json:Dic[key]] RootClassName:key];
        }
        if ([Dic[key] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *ArrDic in Dic[key]) {
                [self TranslateToModelCode:[self Json:ArrDic] RootClassName:key];
            }
        }

        
    }

    // implementation add
    ModelStr = [ModelStr stringByAppendingString:@"\n"];
    NSString *implementStr = @"";
    NSMutableArray *ImplentArr = [ModelStr componentsSeparatedByString:@"@interface "].mutableCopy;
    ImplentArr = (NSMutableArray *)[[ImplentArr reverseObjectEnumerator] allObjects];
    [ImplentArr removeObject:ImplentArr.lastObject];

    for (NSString *str in ImplentArr) {
        NSString *name = [str componentsSeparatedByString:@" "].firstObject;
        implementStr = [NSString stringWithFormat:@"\n//\n%@ \n%@\n%@" ,implement(name), End, implementStr];
    }
//    ModelStr = [NSString stringWithFormat:@"%@\n---\n%@",ModelStr,implementStr];


    return [ModelStr stringByAppendingString:implementStr];


}

-(NSString*)Json:(NSDictionary*)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//json -> dic
- (NSDictionary*)JsonToDic:(NSString*)json{

    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    return dic;
}


@end
