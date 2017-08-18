//
//  JsonFormatToModel.h
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonFormatToModel : NSObject{
    NSString *ModelStr;
    BOOL IsEnd;//当前model是否结束
}

-(NSString*)TranslateToModelCode:(NSString*)json RootClassName:(NSString*)className;
@end
