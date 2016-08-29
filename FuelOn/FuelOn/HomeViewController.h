//
//  HomeViewController.h
//  FabFurnish
//
//  Created by Pankaj Yadav on 07/05/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate>
{
    NSArray *products;
}

//@property (strong, nonatomic) IBOutlet UIView *menuContainerView;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraintMenuView_leading;

//@property (weak, nonatomic) IBOutlet UIView *tabBarContainer;


- (IBAction)menuButtonAction:(id)sender;

//- (IBAction)tabBarItemDidSelect:(UIButton*)selectedButton;

//-(void)pushToParticulerClass:(NSString *)classtype withurl:(NSString *)url header:(NSString *)header;

@end
