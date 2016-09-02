//
//  ViewController.m
//  FuelOn
//
//  Created by Pankaj Yadav on 20/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIViewController+Utility.h"
#import "UITextField+Validation.h"
#import "ActionSheetStringPicker.h"

@interface RegisterViewController () <UITextFieldDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 //   [[self navigationController] setNavigationBarHidden:NO animated:YES];

    selectedIndex = -1; // by default invalid value to be set.
    
    if ([UIViewController isNetworkAvailable])
    {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
        // http://128.199.129.241:8080/FuelOnServer/rest/service
        NSURLComponents *components = [[NSURLComponents alloc]init]; //
        components.scheme = @"http";
        components.host = @"128.199.129.241";
        components.port = [NSNumber numberWithInteger:8080];
        components.path = @"/FuelONServer/rest/service/getProductList";
        
        NSURL *url = components.URL;
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:30.0];
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPMethod:@"POST"];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                NSError *localError = nil;
                
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&localError];
                
                if (localError == nil) {
                    
                    NSLog(@"Response = %@",responseDict);
                    
                    if ([[responseDict objectForKey:@"errorCode"] integerValue] == 0) {
                        
                        products = [responseDict objectForKey:@"responseObject"];
                        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{   // return NO to not change text
    
    if (textField == _txtFieldMobile) {
        NSString *mobile = [NSString stringWithFormat:@"%@%@",textField.text, string];
        if (mobile.length > 11) {
            return NO;
        }else{
            NSCharacterSet *blockedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
            return ([string rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)registerButtonDidTap:(id)sender {
    
    if (_txtFieldFirstName.isEmptyField || _txtFieldLastName.isEmptyField || _txtFieldMobile.isEmptyField || _txtFieldEmail.isEmptyField || _txtFieldFavProduct.isEmptyField || _txtFieldPassword.isEmptyField) {
        [self showAlert:@"All input fields are mandatory!"];
    }
    else if (!_txtFieldMobile.isMobileNumberValid) {
        [self showAlert:@"Mobile must contain 11 characters!"];
    }
    else if (!_txtFieldEmail.isEmailValid) {
        [self showAlert:@"Invalid Email address!"];
    }
    else if (!_txtFieldPassword.isPasswordValid) {
        [self showAlert:@"Password must contain at least 6 characters!"];
    }
    else {
        // Register API
//        name
//        mobile
//        email
//        favoriteProduct
//        password
        
        if ([UIViewController isNetworkAvailable])
        {
            [self showProgressHudWithMessage:@"Registering user"];
            
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
            
            NSURLComponents *components = [[NSURLComponents alloc]init];
            components.scheme = @"http";
            components.host = @"128.199.129.241";
            components.port = [NSNumber numberWithInteger:8080];
            components.path = @"/FuelONServer/rest/service/registerUser";
            
            NSURLQueryItem *item1 = [NSURLQueryItem queryItemWithName:@"name" value:[NSString stringWithFormat:@"%@ %@",_txtFieldFirstName.text,_txtFieldLastName.text]];
            NSURLQueryItem *item2 = [NSURLQueryItem queryItemWithName:@"mobile" value:_txtFieldMobile.text];
            NSURLQueryItem *item3 = [NSURLQueryItem queryItemWithName:@"email" value:_txtFieldEmail.text];
            NSURLQueryItem *item4 = [NSURLQueryItem queryItemWithName:@"favoriteProduct" value:[[products objectAtIndex:selectedIndex] valueForKey:@"productId"]];
            NSURLQueryItem *item5 = [NSURLQueryItem queryItemWithName:@"password" value:_txtFieldPassword.text];
            
            
            components.queryItems = @[item1,item2,item3,item4,item5];
            
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
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [self showAlert:@"Registration successful!"];
                                [self.navigationController popViewControllerAnimated:YES];
                            });
                        }
                        else {
                            [self showAlert:[responseDict objectForKey:@"errorMessage"]];
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

- (IBAction)loginButtonDidTap:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showFavProductPicker:(id)sender {
    
    [_txtFieldFirstName resignFirstResponder];
    [_txtFieldLastName resignFirstResponder];
    [_txtFieldMobile resignFirstResponder];
    [_txtFieldEmail resignFirstResponder];
    [_txtFieldFavProduct resignFirstResponder];
    [_txtFieldPassword resignFirstResponder];

    NSMutableArray *productTitles = [NSMutableArray new];
    
    for (int i =0; i < products.count; i++) {
        
        NSDictionary *dict = [products objectAtIndex:i];
        [productTitles addObject:[dict objectForKey:@"productName"]];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:nil rows:[productTitles copy] initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedValueIndex, id selectedValue) {
        
        selectedIndex = selectedValueIndex;
        
        _txtFieldFavProduct.text = selectedValue;
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    } origin:sender];
}

@end
