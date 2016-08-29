//
//  ViewController.h
//  FuelOn
//
//  Created by Pankaj Yadav on 20/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController {
    
    NSArray *products;
    
    NSInteger selectedIndex;
}


@property (weak, nonatomic) IBOutlet UITextField *txtFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldMobile;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldFavProduct;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPassword;


- (IBAction)showFavProductPicker:(id)sender;
- (IBAction)registerButtonDidTap:(id)sender;
- (IBAction)loginButtonDidTap:(id)sender;

@end

