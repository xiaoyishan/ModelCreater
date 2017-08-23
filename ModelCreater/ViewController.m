//
//  ViewController.m
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //clear fontColor
    [_InputTextView removeAttachments];
    _InputTextView.accessibilityValue = _InputTextView.accessibilityValue;
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)ToModel:(id)sender {

    NSString *json = [_InputTextView accessibilityValue];

    NSMutableAttributedString *str = [[JsonFormatToModel new] TranslateToModelCode:json
                                                                     RootClassName:_RootNameField.stringValue
                                                                          showNull:_NullCheckBtn.state
                                                                          NoteType:_NoteTypeMenu.indexOfSelectedItem
                                                                     NoteDirection:_NoteDirectionMenu.indexOfSelectedItem];
    _OutPutFeild.attributedStringValue = str;
    _OutputTextView.accessibilityTitle = _OutPutFeild.stringValue;
    
    [self JsonToDic:json];
}
- (IBAction)ToView:(id)sender {
    [_InputTextView removeAttachments];
    NSString *json = [_InputTextView accessibilityValue];
    _OutPutFeild.attributedStringValue = [[JsonFormatToModel new] TranslateToViewCode:json
                                                                                HasIB:_IBCheckBtn.state
                                                                             NoteType:_NoteTypeMenu.indexOfSelectedItem
                                                                        NoteDirection:_NoteDirectionMenu.indexOfSelectedItem];
    
    _OutputTextView.accessibilityTitle = _OutPutFeild.stringValue;
    
    [self JsonToDic:json];
}


- (IBAction)IBcheckauto:(id)sender {
    [self ToView:nil];
}
- (IBAction)Nullcheckauto:(id)sender {
    [self ToModel:nil];
}

- (IBAction)NoteTypeMenuauto:(id)sender {
    if ([_OutPutFeild.stringValue containsString:@"UI"]) {
        [self ToView:nil];
    }else{
        [self ToModel:nil];
    }
}
- (IBAction)NoteDirectionMenuauto:(id)sender {
    [self NoteTypeMenuauto:nil];
}
- (IBAction)CodeModeauto:(id)sender {
    if (_CodemodeCheckBtn.indexOfSelectedItem==0) {
        [_OutputTextView setHidden:YES];
        [_OutPutFeild setHidden:NO];
    }else{
        [_OutputTextView setHidden:NO];
        [_OutPutFeild setHidden:YES];
    }
}




- (IBAction)JsonFormatCheck:(id)sender {
    [_InputTextView removeAttachments];

    NSString *json = [NSString stringWithFormat:@"%@",[_InputTextView accessibilityValue]];
    _InputTextView.accessibilityValue = json;

}



//json -> dic
- (NSDictionary*)JsonToDic:(NSString*)json{

    //remove rich text format
    [_InputTextView removeAttachments];
    _InputTextView.accessibilityValue = json;

    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json serialize failed：%@",err);
        [self WarringForHold];
        return nil;
    }
    return dic;
}



- (void) WarringForHold{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"tranlate failed"];
    [alert setInformativeText:@"Please check json format is OK?"];
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert beginSheetModalForWindow:self.view.window completionHandler:nil];
}


@end






