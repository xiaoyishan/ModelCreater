//
//  JsonFormatToModel.h
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface JsonFormatToModel : NSObject{
    NSString *ModelStr;
    NSString *ViewStr;
}


-(NSString*)TranslateToModelCode:(NSString*)json RootClassName:(NSString*)className;// ->model

-(NSString*)TranslateToViewCode:(NSString*)json;// ->view

@end
