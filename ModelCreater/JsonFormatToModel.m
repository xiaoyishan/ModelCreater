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



-(NSMutableAttributedString*)TranslateToModelCode:(NSString*)json
                                    RootClassName:(NSString*)className
                                         showNull:(BOOL)hasNull
                                         NoteType:(NoteType)noteType
                                    NoteDirection:(NoteDirection)noteDirection{
    NSDictionary *Dic = [self JsonToDic:json];

    //if json is array
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id Data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if ([Data isKindOfClass:[NSArray class]]) {
        Dic = [(NSArray*)Data firstObject];//forgate olther item models
    }


    NSString *NoteStr = @"//";
    if(noteType==NoteTypeDocument)NoteStr = @"/**/";

    

    NSString *CurrentStr = @"";

    for (NSString *key in Dic.allKeys) {


        // NoteDirectionRight   "→"
        if (noteDirection == NoteDirectionRight) {



            if ([Dic[key] isKindOfClass:[NSString class]]) {
                CurrentStr = [NSString stringWithFormat:@"%@%@; %@ \n%@", FormatStr, key,NoteStr,CurrentStr];
            }
            if ([Dic[key] isKindOfClass:[NSArray class]]) {
                NSArray *temp = Dic[key];
                if (temp.count==0 || ![temp.firstObject isKindOfClass:[NSDictionary class]] ) {
                    CurrentStr = [NSString stringWithFormat:@"%@%@; %@ \n%@", FormatArr, key,NoteStr,CurrentStr];
                }else{
                    CurrentStr = [NSString stringWithFormat:@"%@%@; %@ \n%@", CustomArr(key), key,NoteStr,CurrentStr];
                }
                
            }
            if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
                CurrentStr = [NSString stringWithFormat:@"%@%@; %@ \n%@", CustomDic(key), key,NoteStr,CurrentStr];
            }
            if ([Dic[key] isKindOfClass:[NSNumber class]]) {

                //deal __NSCFBoolean (false...)
                if ([Dic[key] isKindOfClass:[@(YES) class]]){

                    CurrentStr = [NSString stringWithFormat:@"%@%@; %@ \n%@", FormatBOOL,key, NoteStr,CurrentStr];

                }else{

                    CGFloat X = [Dic[key] floatValue];
                    if (X>floor(X)) {
                        CurrentStr = [NSString stringWithFormat:@"%@%@; %@ \n%@", FormatFlot,key, NoteStr,CurrentStr];
                    }else{
                        CurrentStr = [NSString stringWithFormat:@"%@%@; %@ \n%@", FormatInt,key, NoteStr,CurrentStr];
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
                    CurrentStr = [NSString stringWithFormat:@"%@%@; %@ //unknow \n%@", FormatStr,key, NoteStr,CurrentStr];
                }else{
                    CurrentStr = [NSString stringWithFormat:@"%@%@; %@ //please manually modify \n%@", FormatNull,key, NoteStr,CurrentStr];
                }
                
            }





        }
        // NoteDirectionRight   "↑"
        if (noteDirection == NoteDirectionTop) {


            if ([Dic[key] isKindOfClass:[NSString class]]) {
                CurrentStr = [NSString stringWithFormat:@"%@\n%@%@;  \n%@", NoteStr, FormatStr,key,CurrentStr];
            }
            if ([Dic[key] isKindOfClass:[NSArray class]]) {
                CurrentStr = [NSString stringWithFormat:@"%@\n%@%@;  \n%@", NoteStr, CustomArr(key),key,CurrentStr];
            }
            if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
                CurrentStr = [NSString stringWithFormat:@"%@\n%@%@;  \n%@", NoteStr, CustomDic(key),key,CurrentStr];
            }
            if ([Dic[key] isKindOfClass:[NSNumber class]]) {

                //deal __NSCFBoolean (false...)
                if ([Dic[key] isKindOfClass:[@(YES) class]]){

                    CurrentStr = [NSString stringWithFormat:@"%@\n%@%@;  \n%@",  NoteStr,FormatBOOL,key,CurrentStr];

                }else{

                    CGFloat X = [Dic[key] floatValue];
                    if (X>floor(X)) {
                        CurrentStr = [NSString stringWithFormat:@"%@\n%@%@;  \n%@", NoteStr, FormatFlot,key,CurrentStr];
                    }else{
                        CurrentStr = [NSString stringWithFormat:@"%@\n%@%@;  \n%@", NoteStr, FormatInt,key,CurrentStr];
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
                    CurrentStr = [NSString stringWithFormat:@"%@\n%@%@; //unknow \n%@", NoteStr, FormatStr,key,CurrentStr];
                }else{
                    CurrentStr = [NSString stringWithFormat:@"%@\n%@%@; //please manually modify \n%@", NoteStr, FormatNull,key,CurrentStr];
                }
            }






        }
    }


    if (![ModelStr containsString:CurrentStr]) {
        if(className.length==0)className=@"RootClass";
        ModelStr = [NSString stringWithFormat:@"\n%@\n%@\n%@%@\n%@", NoteStr,Interface(className),CurrentStr, End,ModelStr];
    }


    for (NSString *key in Dic.allKeys) {
        if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
            [self TranslateToModelCode:[self Json:Dic[key]]
                         RootClassName:key
                              showNull:hasNull
                              NoteType:noteType
                         NoteDirection:noteDirection];
        }
        if ([Dic[key] isKindOfClass:[NSArray class]]) {
            if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
                for (NSDictionary *ArrDic in Dic[key]) {
                    [self TranslateToModelCode:[self Json:ArrDic]
                                 RootClassName:key
                                      showNull:hasNull
                                      NoteType:noteType
                                 NoteDirection:noteDirection];
                }
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
        implementStr = [NSString stringWithFormat:@"\n%@\n%@ \n%@\n%@" ,NoteStr, implement(name), End, implementStr];

        // add model name
        NSString *modelName = [NSString stringWithFormat:@"%@Model",name];
        if(![AllModelName containsObject:modelName])[AllModelName addObject:modelName];
    }

    NSString *resultStr = [ModelStr stringByAppendingString:implementStr];

    return [[NSMutableAttributedString new] YS_ColorStr:resultStr Font:14 CustomNameArr:AllModelName];


}





// ->view
-(NSMutableAttributedString*)TranslateToViewCode:(NSString*)json
                                           HasIB:(BOOL)IB
                                        NoteType:(NoteType)noteType
                                   NoteDirection:(NoteDirection)noteDirection{
    NSDictionary *Dic = [self JsonToDic:json];


    NSString *NoteStr = @"//";
    if(noteType==NoteTypeDocument)NoteStr = @"/**/";


    NSString *CurrentStr = @"";


    for (NSString *key in Dic.allKeys) {

        // NoteDirectionRight   "→"
        if (noteDirection == NoteDirectionRight){
            if(IB){
                CurrentStr = [NSString stringWithFormat:@"%@%@; %@ \n%@", UIFormatLabelIB,key, NoteStr,CurrentStr];
            }else{
                CurrentStr = [NSString stringWithFormat:@"%@%@; %@ \n%@", UIFormatLabel,key, NoteStr,CurrentStr];
            }
        }
        // NoteDirectionRight   "↑"
        if (noteDirection == NoteDirectionTop){
            if(IB){
                CurrentStr = [NSString stringWithFormat:@"%@\n%@%@;  \n%@", NoteStr,UIFormatLabelIB,key,CurrentStr];
            }else{
                CurrentStr = [NSString stringWithFormat:@"%@\n%@%@;  \n%@", NoteStr,UIFormatLabel,key,CurrentStr];
            }
        }
    }
    
    if (![ViewStr containsString:CurrentStr]) {
        ViewStr = [NSString stringWithFormat:@"\n%@\n%@", CurrentStr,ViewStr];
    }
    
    
    
    
    for (NSString *key in Dic.allKeys) {
        if ([Dic[key] isKindOfClass:[NSDictionary class]]) {
            [self TranslateToViewCode:[self Json:Dic[key]]
                                HasIB:IB
                             NoteType:noteType
                        NoteDirection:noteDirection];
        }
        if ([Dic[key] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *ArrDic in Dic[key]) {
                [self TranslateToViewCode:[self Json:ArrDic]
                                    HasIB:IB
                                 NoteType:noteType
                            NoteDirection:noteDirection];
            }
        }
        
        
    }
    return [[NSMutableAttributedString new] YS_ColorStr:ViewStr Font:14 CustomNameArr:@[]];;
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
