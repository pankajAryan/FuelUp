//
//  StoreDetailViewController.m
//  FuelOn
//
//  Created by Pankaj Yadav on 29/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "DataModels.h"
#import "UIViewController+Utility.h"

@interface StoreDetailViewController () {

    StoreDetailBaseClass *storeDetailBase;
}

@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showProgressHudWithMessage:@""];

    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSURLComponents *components = [[NSURLComponents alloc]init]; //
    components.scheme = @"http";
    components.host = @"128.199.129.241";
    components.port = [NSNumber numberWithInteger:8080];
    components.path = @"/FuelONServer/rest/service/getStoreDetail";

    NSURLQueryItem *item1 = [NSURLQueryItem queryItemWithName:@"storeId" value:@"1"];

    components.queryItems = @[item1];

    NSURL *url = components.URL;

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];

    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];

    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self removeHudAfterDelay:0.1];
        
        if (!error) {
            NSError *localError = nil;
            
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&localError];
            
            if (localError == nil) {
                NSLog(@"Response = %@",responseDict);
                storeDetailBase = [[StoreDetailBaseClass alloc] initWithDictionary:responseDict];
                
                if ([storeDetailBase.errorMessage isEqualToString:@"Success"]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                    });
                }
            }
        }
    }];

    [postDataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
