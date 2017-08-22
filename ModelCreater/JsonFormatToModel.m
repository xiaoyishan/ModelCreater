//
//  JsonFormatToModel.m
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "JsonFormatToModel.h"


const NSString *End  = @"@end";

const NSString *FormatInt  = @"@property (nonatomic, assign) NSInteger ";
const NSString *FormatFlot = @"@property (nonatomic, assign) CGFloat   ";
const NSString *FormatStr  = @"@property (nonatomic, copy)   NSString *";
const NSString *FormatArr  = @"@property (nonatomic, strong) NSArray  *";
const NSString *FormatDic  = @"@property (nonatomic, strong) NSDictionary *";

const NSString *FormatNull  = @"@property (nonatomic, strong) NSObject  *";
const NSString *FormatBOOL  = @"@property (nonatomic, assign) BOOL  ";

const NSString *UIFormatLabel  = @"@property (nonatomic, weak) UILabel  *";
const NSString *UIFormatField  = @"@property (nonatomic, weak) UITextField *";
const NSString *UIFormatButton  = @"@property (nonatomic, weak) UIButton *";

const NSString *UIFormatLabelIB  = @"@property (nonatomic, weak) IBOutlet UILabel  *";
const NSString *UIFormatFieldIB  = @"@property (nonatomic, weak) IBOutlet UITextField *";
const NSString *UIFormatButtonIB  = @"@property (nonatomic, weak) IBOutlet UIButton *";



#define     CustomArr(x)    [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray<%@Model *> *", x]
#define     CustomDic(x)    [NSString stringWithFormat:@"@property (nonatomic, strong) %@Model *", x]

#define     Interface(name)    [NSString stringWithFormat:@"@interface %@Model : NSObject", name]
#define     implement(name)    [NSString stringWithFormat:@"@implementation %@ ", name]



@implementation JsonFormatToModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        ModelStr = @"";
        ViewStr =  @"";
        AllModelName = [NSMutableArray new];
    }
    return self;
}



-(NSMutableAttributedString*)TranslateToModelCode:(NSString*)json RootClassName:(NSString*)className showNull:(BOOL)hasNull{
    NSDictionary *Dic = [self JsonToDic:json];

    //if json is array
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id Data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if ([Data isKindOfClass:[NSArray class]]) {
        Dic = [(NSArray*)Data firstObject];//forgate olther item models
    }


    NSString *CurrentStr = @"";

    for (NSString *key in Dic.allKeys) {

        if ([Dic[key] isKindOfClass:[NSString class]]) {
            CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormatStr,key,CurrentStr];
        }
        if ([Dic[key] isKindOfClass:[NSArray class]]) {
            CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", CustomArr(key),key,CurrentStr];
        }
        if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
            CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", CustomDic(key),key,CurrentStr];
        }
        if ([Dic[key] isKindOfClass:[NSNumber class]]) {

            //dell __NSCFBoolean (false...)
            if ([Dic[key] isKindOfClass:[@(YES) class]]){

                CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormatBOOL,key,CurrentStr];

            }else{

                CGFloat X = [Dic[key] floatValue];
                if (X>floor(X)) {
                    CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormatFlot,key,CurrentStr];
                }else{
                    CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", FormatInt,key,CurrentStr];
                }
            }


        }

        // unknow class use nsobject
        if (![Dic[key] isKindOfClass:[NSString class]] &&
            ![Dic[key] isKindOfClass:[NSArray class]] &&
            ![Dic[key] isKindOfClass:[NSDictionary class]] &&
            ![Dic[key] isKindOfClass:[NSNumber class]]) {

            //dell null and so on
            if (hasNull) { // use "NSString" for the moment of custom setting
                CurrentStr = [NSString stringWithFormat:@"%@%@; //unknow \n%@", FormatStr,key,CurrentStr];
            }else{
                CurrentStr = [NSString stringWithFormat:@"%@%@; //please manually modify \n%@", FormatNull,key,CurrentStr];
            }

        }

    }


    if (![ModelStr containsString:CurrentStr]) {
        if(className.length==0)className=@"RootClass";
        ModelStr = [NSString stringWithFormat:@"\n//\n%@\n%@%@\n%@",Interface(className),CurrentStr, End,ModelStr];
    }


    for (NSString *key in Dic.allKeys) {
        if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
            [self TranslateToModelCode:[self Json:Dic[key]] RootClassName:key showNull:hasNull];
        }
        if ([Dic[key] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *ArrDic in Dic[key]) {
                [self TranslateToModelCode:[self Json:ArrDic] RootClassName:key showNull:hasNull];
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

        // add model name
        NSString *modelName = [NSString stringWithFormat:@"%@Model",name];
        if(![AllModelName containsObject:modelName])[AllModelName addObject:modelName];
    }

    NSString *resultStr = [ModelStr stringByAppendingString:implementStr];

    return [[NSMutableAttributedString new] YS_ColorStr:resultStr Font:14 CustomNameArr:AllModelName];


}





// ->view
-(NSString*)TranslateToViewCode:(NSString*)json HasIB:(BOOL)IB{
    NSDictionary *Dic = [self JsonToDic:json];
    
    NSString *CurrentStr = @"";
    for (NSString *key in Dic.allKeys) {
        if(IB){
            CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", UIFormatLabelIB,key,CurrentStr];
        }else{
            CurrentStr = [NSString stringWithFormat:@"%@%@; // \n%@", UIFormatLabel,key,CurrentStr];
        }
    }
    
    if (![ViewStr containsString:CurrentStr]) {
        ViewStr = [NSString stringWithFormat:@"\n%@\n%@", CurrentStr,ViewStr];
    }
    
    
    
    
    for (NSString *key in Dic.allKeys) {
        if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
            [self TranslateToViewCode:[self Json:Dic[key]] HasIB:IB];
        }
        if ([Dic[key] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *ArrDic in Dic[key]) {
                [self TranslateToViewCode:[self Json:ArrDic] HasIB:IB];
            }
        }
        
        
    }
    return ViewStr;
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
