//
//  StoreDetailViewController.h
//  FuelOn
//
//  Created by Pankaj Yadav on 29/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface StoreDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *storeId;

@property (weak, nonatomic) IBOutlet UITableView *table_storeDetail;
@property (weak, nonatomic) IBOutlet UIView *view_tableHeader;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *label_storeName;
@property (weak, nonatomic) IBOutlet UILabel *label_headerAddress;
@property (weak, nonatomic) IBOutlet UIView *view_regular;
@property (weak, nonatomic) IBOutlet UIView *view_medium;
@property (weak, nonatomic) IBOutlet UIView *view_premium;
@property (weak, nonatomic) IBOutlet UIView *view_diesel;
@property (weak, nonatomic) IBOutlet UILabel *label_regularTitle;
@property (weak, nonatomic) IBOutlet UILabel *label_mediumTitle;
@property (weak, nonatomic) IBOutlet UILabel *label_premiumTitle;
@property (weak, nonatomic) IBOutlet UILabel *label_dieselTitle;
@property (weak, nonatomic) IBOutlet UILabel *label_regularValue;
@property (weak, nonatomic) IBOutlet UILabel *label_mediumValue;
@property (weak, nonatomic) IBOutlet UILabel *label_premiumValue;
@property (weak, nonatomic) IBOutlet UILabel *label_dieselValue;

@property (weak, nonatomic) IBOutlet UILabel *label_regularTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *label_mediumTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *label_premiumTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *label_dieselTimestamp;

@property (weak, nonatomic) IBOutlet UILabel *labelNoOffers;

- (IBAction)action_back:(id)sender;
- (IBAction)action_favourites:(id)sender;
- (IBAction)openDirectionsInExternalMap:(id)sender;

@end
