//
//  LoginViewController.h
//  FuelOn
//
//  Created by Pankaj Yadav on 20/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPassword;


- (IBAction)loginButtonDidTap:(id)sender;

@end
