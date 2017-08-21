//
//  AppDelegate.h
//  ModelCreater
//
//  Created by Sundear on 2017/8/16.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>
@property (strong, nonatomic) NSWindow *RootWindow;
@property (nonatomic, strong) NSArray<DicYPutOutRollingListModel *> *DicYPutOutRollingList; //
@property (nonatomic, assign) NSInteger ProductType; //
@property (nonatomic, assign) NSInteger ButtonOutStatus; //
@property (nonatomic, assign) NSInteger SelectedState; //
@property (nonatomic, copy)   NSString *Specification; //
@property (nonatomic, assign) NSInteger PrevQuantity; //
@property (nonatomic, copy)   NSString *Unit; //
@property (nonatomic, copy)   NSString *PutOutDate; //unknow
@property (nonatomic, copy)   NSString *LastChanged; //
@property (nonatomic, assign) NSInteger Weight; //
@property (nonatomic, assign) NSInteger Quantity; //
@property (nonatomic, assign) NSInteger BadCount; //
@property (nonatomic, copy)   NSString *TotalAlreadyNumberPackagesArr; //unknow
@property (nonatomic, copy)   NSString *TotalAlreadyQuantityArr; //unknow
@property (nonatomic, copy)   NSString *TotalPlanQuantityArr; //unknow
@property (nonatomic, copy)   NSString *UnitNew; //unknow
@property (nonatomic, assign) NSInteger Width; //
@property (nonatomic, copy)   NSString *ProductNo; //
@property (nonatomic, assign) NSInteger PutOutID; //
@property (nonatomic, assign) NSInteger OrderLengthID; //
@property (nonatomic, assign) NSInteger AccountID; //
@property (nonatomic, copy)   NSString *TotalPlanNumberPackagesArr; //unknow
@property (nonatomic, assign) NSInteger Status; //
@property (nonatomic, copy)   NSString *ActualArr; //unknow
@property (nonatomic, assign) NSInteger ProductID; //
@property (nonatomic, copy)   NSString *QuantityUnit; //
@property (nonatomic, copy)   NSString *YPutOutRollingList; //unknow
@property (nonatomic, copy)   NSString *PlanArr; //unknow
@property (nonatomic, copy)   NSString *Color; //
@property (nonatomic, assign) NSInteger OutDetailCount; //
@property (nonatomic, copy)   NSString *WidthUnit; //unknow
@property (nonatomic, copy)   NSString *ColorNew; //unknow
@property (nonatomic, assign) NSInteger BadPackages; //
@property (nonatomic, copy)   NSString *InsertTime; //
@property (nonatomic, assign) NSInteger NumberPackages; //
@property (nonatomic, assign) NSInteger OutStatus; //
@property (nonatomic, copy)   NSString *ProductName; //
@property (nonatomic, assign) NSInteger PrevNumberPackages; //
@property (nonatomic, assign) NSInteger AlreadyChuStatus; //
@property (nonatomic, copy)   NSString *SupplierName; //unknow
@property (nonatomic, assign) NSInteger DetectionResult; //
@end

