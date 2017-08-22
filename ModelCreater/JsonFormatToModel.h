//
//  JsonFormatToModel.h
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableAttributedString+CodeFormat.h"


typedef NS_ENUM(NSUInteger, NoteType) {
    NoteTypeDefault ,       // "//"
    NoteTypeDocument,       // "/**/"
};
typedef NS_ENUM(NSUInteger, NoteDirection) {
    NoteDirectionRight,     // "→"
    NoteDirectionTop ,      // "↑"
};
typedef NS_ENUM(NSUInteger, NoteLanguage) {
    NoteLanguageDefault ,       // 简体中文
    NoteLanguageZHhant,         // 繁體中文
    NoteLanguageJapanese,       // 日本語
    NoteLanguageHindi,          // 印度語
    NoteLanguageFrench,         // 法語
    NoteLanguageRussian,        // 俄語
    NoteLanguageKorean,         // 韩語
};


@interface JsonFormatToModel : NSObject{
    NSString *ModelStr;
    NSString *ViewStr;
    NSMutableArray *AllModelName;
    
}

// ->model
-(NSMutableAttributedString*)TranslateToModelCode:(NSString*)json
                                    RootClassName:(NSString*)className
                                         showNull:(BOOL)hasNull
                                         NoteType:(NoteType)noteType
                                    NoteDirection:(NoteDirection)noteDirection;
// ->view
-(NSMutableAttributedString*)TranslateToViewCode:(NSString*)json
                                           HasIB:(BOOL)IB
                                        NoteType:(NoteType)noteType
                                   NoteDirection:(NoteDirection)noteDirection;

@end
