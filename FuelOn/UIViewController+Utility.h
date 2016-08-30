//
//  UIViewController+Utility.h
//  FabFurnish
//
//  Created by Pankaj Yadav on 07/05/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFValidationResult.h"
//#import "FFConstant.h"

@interface UIViewController (Utility)

+ (instancetype)instantiateViewControllerWithIdentifier:(NSString*)storyBoardId fromStoryboard:(NSString*)storyboardName;

- (void)showProgressHudWithMessage:(NSString*)message;

- (void)removeHudAfterDelay:(NSTimeInterval)delay;

+(BOOL)isNetworkAvailable;

// UIAlertView Display Methods
+ (void)showAlert:(NSString *)message;
-(void) showAlert:(NSString *)message;
-(void) showCancelAlert:(NSString *)message;
- (void)showCancelAlertWithTitle:(NSString *)title message:(NSString *)message alertTag:(NSInteger)tag;

- (void)showDelegatedAlertwithTitle:(NSString*)Title message:(NSString*)message tag:(NSInteger)tag;

//-(void) showValidationError:(FFValidationResult*)validationError;

+(void)saveDatatoUserDefault:(id)data forKey:(NSString*)key;
+(id)retrieveDataFromUserDefault:(NSString*)key;

#pragma mark- Project specific

- (UIImage*)getImageForBrand:(NSString*)brand;

@end
