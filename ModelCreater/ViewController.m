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
    
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)ToModel:(id)sender {
    NSString *json = [_InputTextView accessibilityValue];
    _OutputTextView.accessibilityValue = [[JsonFormatToModel new] TranslateToModelCode:json RootClassName:_RootNameField.stringValue];
    [self JsonToDic:json];
}
- (IBAction)ToView:(id)sender {
    NSString *json = [_InputTextView accessibilityValue];
    _OutputTextView.accessibilityValue = [[JsonFormatToModel new] TranslateToViewCode:json HasIB:_IBCheckBtn.state];
    [self JsonToDic:json];
}


- (IBAction)JsonFormatCheck:(id)sender {
    NSString *json = [NSString stringWithFormat:@"%@",[_InputTextView accessibilityValue]];
    _InputTextView.accessibilityValue = json;
}


//json -> dic
- (NSDictionary*)JsonToDic:(NSString*)json{

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

- (void) WarringForHold
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"tranlate failed"];
    [alert setInformativeText:@"Please check json formate is OK?"];
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert beginSheetModalForWindow:self.view.window completionHandler:nil];

}
@end
