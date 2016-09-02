//
//  HomeViewController.h
//  FabFurnish
//
//  Created by Pankaj Yadav on 07/05/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate, UISearchBarDelegate>
{
    NSArray *products;
}

//@property (strong, nonatomic) IBOutlet UIView *menuContainerView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraintMenuView_leading;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


- (IBAction)menuButtonAction:(id)sender;

//- (IBAction)searchButtonAction:(id)sender;

- (IBAction)gpsButtonDidTap:(id)sender;

- (IBAction)cheapestFuelButtonDidTap:(id)sender;

@end
