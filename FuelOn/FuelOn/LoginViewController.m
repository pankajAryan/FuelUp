//
//  LoginViewController.m
//  FuelOn
//
//  Created by Pankaj Yadav on 20/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewController+Utility.h"
#import "UITextField+Validation.h"
#import "FFConstant.h"
#import "HomeViewController.h"
#import "FFLeftMenuViewController.h"
#import "RootViewController.h"


@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonDidTap:(id)sender {
    
    [_txtFieldEmail resignFirstResponder];
    [_txtFieldPassword resignFirstResponder];

    if (_txtFieldEmail.isEmptyField || _txtFieldPassword.isEmptyField) {
        [self showAlert:@"All input fields are mandatory!"];
    }
    else if (!_txtFieldEmail.isEmailValid) {
        [self showAlert:@"Invalid Email address!"];
    }
    else if (!_txtFieldPassword.isPasswordValid) {
        [self showAlert:@"Password must contain at least 6 characters!"];
    }
    else {
        // Login API
        
        if ([UIViewController isNetworkAvailable])
        {
            [self showProgressHudWithMessage:@"Logging-in"];
            
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
            
            NSURLComponents *components = [[NSURLComponents alloc]init];
            components.scheme = @"http";
            components.host = @"128.199.129.241";
            components.port = [NSNumber numberWithInteger:8080];
            components.path = @"/FuelONServer/rest/service/login";
            
            NSURLQueryItem *item1 = [NSURLQueryItem queryItemWithName:@"email" value:_txtFieldEmail.text];
            NSURLQueryItem *item2 = [NSURLQueryItem queryItemWithName:@"password" value:_txtFieldPassword.text];
            
            components.queryItems = @[item1,item2];
            
            NSURL *url = components.URL;
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                               timeoutInterval:30.0];
            
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setHTTPMethod:@"POST"];
            
            NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                [self removeProgressHudAfterDelay:0.1];
                
                if (!error) {
                    NSError *localError = nil;
                    
                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&localError];
                    
                    if (localError == nil) {
                        
                        NSLog(@"Response = %@",responseDict);
                        
                        if ([[responseDict objectForKey:@"errorCode"] integerValue] == 0) {
                            
                            [UIViewController saveDatatoUserDefault:[[responseDict objectForKey:@"responseObject"] objectForKey:@"favoriteProduct"] forKey:@"favProductId"];
                            
                            [UIViewController saveDatatoUserDefault:[[responseDict objectForKey:@"responseObject"] objectForKey:@"userId"] forKey:@"userId"];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                HomeViewController *homeController = (HomeViewController*)[HomeViewController instantiateViewControllerWithIdentifier:@"HomeViewController" fromStoryboard:@"Main"];
                                [self.navigationController pushViewController:homeController animated:YES];
                            });
                            
                            //[self showAlert:@"Login successful!"];
                            //[self addTabBarContollerWithData:[responseDict objectForKey:@"responseObject"]];
                        }
                        else {
                            [self showAlert:@"Invalid Credentials!"];
                        }
                    }
                }
            }];
            
            [postDataTask resume];
        }
        else {
            [self showAlert:@"No internet available!"];
        }
    }
}


/*-(void)addTabBarContollerWithData:(NSDictionary *)paramDict
{
    AppDelegate *appDelegate = App_Delegate;
    
    UITabBarController *tabBarController = (UITabBarController *)[UIViewController instantiateViewControllerWithIdentifier:@"TabBarController" fromStoryboard:@"Navigation"];
    tabBarController.delegate = (id)appDelegate;
    HomeViewController *homecontroller = nil;
    FFLeftMenuViewController *leftcontroller = nil;
    
    for (UIViewController *controller in tabBarController.viewControllers) {
        
        if ([controller isKindOfClass:[RootViewController class]]) {
            
            RootViewController *rootvc = (RootViewController *)controller;
            UINavigationController *navVC = (UINavigationController *)rootvc.contentViewController;
            UINavigationController *leftVC = (UINavigationController *)rootvc.leftMenuViewController;
            
            if ([navVC.viewControllers count]) {
                if ([[navVC.viewControllers objectAtIndex:0] isKindOfClass:[HomeViewController class]]) {
                    homecontroller = (HomeViewController *)[navVC.viewControllers objectAtIndex:0];
//                    homecontroller.teasersData = catalogue;
                }
            }
            
            if ([leftVC.viewControllers count]) {
                if ([[leftVC.viewControllers objectAtIndex:0] isKindOfClass:[FFLeftMenuViewController class]]) {
                    leftcontroller = (FFLeftMenuViewController *)[leftVC.viewControllers objectAtIndex:0];
                }
            }
            
            break;
        }
    }
    
    if ([[tabBarController.viewControllers objectAtIndex:1] isKindOfClass:[UINavigationController class]]) {
        
        UIViewController *WishlistViewController = [UIViewController instantiateViewControllerWithIdentifier:@"HomeViewController" fromStoryboard:@"Home"];
        
        [[tabBarController.viewControllers objectAtIndex:1] setViewControllers:@[WishlistViewController]];
    }
    
    if ([[tabBarController.viewControllers objectAtIndex:2] isKindOfClass:[UINavigationController class]]) {
        
        UIViewController *CartViewController = [UIViewController instantiateViewControllerWithIdentifier:@"HomeViewController" fromStoryboard:@"Home"];
        
        [[tabBarController.viewControllers objectAtIndex:2] setViewControllers:@[CartViewController]];
    }
    
    if ([[tabBarController.viewControllers objectAtIndex:3] isKindOfClass:[UINavigationController class]]) {
        
        UIViewController *MyAccountViewController = [UIViewController instantiateViewControllerWithIdentifier:@"HomeViewController" fromStoryboard:@"Home"];
        
        [[tabBarController.viewControllers objectAtIndex:3] setViewControllers:@[MyAccountViewController]];
    }
    
    if ([[tabBarController.viewControllers objectAtIndex:4] isKindOfClass:[UINavigationController class]]) {
        
        UITableViewController *MoreViewController = (UITableViewController*)[UITableViewController instantiateViewControllerWithIdentifier:@"HomeViewController" fromStoryboard:@"Home"];
        
        [[tabBarController.viewControllers objectAtIndex:4] setViewControllers:@[MoreViewController]];
    }
    
    [appDelegate.window setRootViewController:tabBarController];
    
    // Tab bar setup completed //
}
*/


@end
