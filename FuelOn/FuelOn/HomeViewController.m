//
//  HomeViewController.m
//  FabFurnish
//
//  Created by Pankaj Yadav on 07/05/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewController+RESideMenu.h"
#import "AppDelegate.h"
#import "FFConstant.h"
#import "UIViewController+Utility.h"
#import "TabBarView.h"
#import "DataModels.h"
#import "CLLocationManager+blocks.h"
#import "StoreDetailViewController.h"

@interface HomeViewController() {
    
    HomeMapStoreModelBaseClass *fuelStationBase;

    NSString *lat;
    NSString *lon;
}

@property (nonatomic, strong) CLLocationManager *manager;

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@property (weak, nonatomic) IBOutlet TabBarView *tabBar;

@end


@implementation HomeViewController


#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _layoutConstraintMenuView_leading.constant = -ScreenHeight;

    [self.view layoutIfNeeded];
    
    [self fetchProducts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark- TableView Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"menuCell";
    
    UITableViewCell *leftMenuCell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (leftMenuCell == nil) {
        leftMenuCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIImageView *menuIcon = (UIImageView*)[leftMenuCell viewWithTag:120];
    UILabel *menuTitle = (UILabel*)[leftMenuCell viewWithTag:121];
    
    switch (indexPath.row)
    {
        case 0:
        {
            menuTitle.text = @"My Profile";
            menuIcon.image = [UIImage imageNamed:@"my_account"];
        }
            break;
            
        case 1:
        {
            menuTitle.text = @"My Favourites";
            menuIcon.image = [UIImage imageNamed:@"top_fav"];
        }
            break;
            
        case 2:
        {
            menuTitle.text = @"Credit Cards/Payments";
            menuIcon.image = [UIImage imageNamed:@"credit_card"];
        }
            break;
        case 3:
        {
            menuTitle.text = @"Invite Friends";
            menuIcon.image = [UIImage imageNamed:@"invite_frnd"];
        }
            break;
        case 4:
        {
            menuTitle.text = @"Contact Us";
            menuIcon.image = [UIImage imageNamed:@"contact"];
        }
            break;
            
        case 5:
        {
            menuTitle.text = @"Help";
            menuIcon.image = [UIImage imageNamed:@"help"];
        }
            break;
            
        default:
        {
            
        }
            break;
    }
    
    return leftMenuCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        // Hide Manu
        _layoutConstraintMenuView_leading.constant = -ScreenHeight;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Action Methods

- (IBAction)menuButtonAction:(id)sender {
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        UIButton *menuButton = sender;
        
        if (menuButton.tag) {
            // Hide Manu
            _layoutConstraintMenuView_leading.constant = -ScreenHeight;
            menuButton.tag = 0;
        }
        else {
            // Show Manu
            _layoutConstraintMenuView_leading.constant = 0;
            menuButton.tag = 1;
        }
        
        [self.view layoutIfNeeded];
    }];

}

//- (IBAction)tabBarItemDidSelect:(UIButton*)selectedButton {
//
//
//}

#pragma mark- API Requests

- (void)fetchProducts {
    
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
                                                       timeoutInterval:10.0];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            NSError *localError = nil;
            
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&localError];
            
            if (localError == nil) {
                
                NSLog(@"Response = %@",responseDict);
                
                if ([[responseDict objectForKey:@"errorMessage"] isEqualToString:@"Success"]) {
                    
                    NSMutableArray *fetchedProducts = [[responseDict objectForKey:@"responseObject"] mutableCopy];
                    
                    NSString *favProductId = [UIViewController retrieveDataFromUserDefault:@"favProductId"];
                    
                    if (favProductId && favProductId.length) {
                        
                        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"productId CONTAINS[cd]%@", favProductId];
                        NSArray *filteredArray = [fetchedProducts filteredArrayUsingPredicate:predicate];
                        
                        NSInteger index = [fetchedProducts indexOfObject:[filteredArray objectAtIndex:0]];
                        
                        [fetchedProducts removeObjectAtIndex:index];
                        [fetchedProducts insertObject:[filteredArray objectAtIndex:0] atIndex:0];
                    }
                    
                    products = [fetchedProducts copy];
                   
                    dispatch_async(dispatch_get_main_queue(), ^{

                        //[self showProgressHudWithMessage:@""];
                        [self fetchFuelStationsForSelectedType:0];
                        
                        [self.tabBar setTabItemsLayoutWithProducts:products];
                        
                        self.tabBar.tabBarItemSelectionCallback = ^(NSInteger selectedItemIndex){
                            
                            [self fetchFuelStationsForSelectedType:selectedItemIndex];
                        };
                    
                        [self.view addSubview:_tabBar];
                        [self.view sendSubviewToBack:_tabBar];
                        //_tabBar.frame = CGRectMake(0, 0, _tabBarContainer.frame.size.width, 60);
                        
                        NSLayoutConstraint *leadingContraints = [NSLayoutConstraint constraintWithItem:_tabBar attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1 constant:-8];
                        
                        NSLayoutConstraint *trailingContraints = [NSLayoutConstraint constraintWithItem:_tabBar attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1 constant:8];
                        
                        //pin 100 points from the top of the super
                        NSLayoutConstraint *bottomContraints = [NSLayoutConstraint constraintWithItem:_tabBar attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottomMargin multiplier:1 constant:-8];
                        
                        NSLayoutConstraint *heightContraints = [NSLayoutConstraint constraintWithItem:_tabBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:60];
                        //when using autolayout we an a view, MUST ALWAYS SET setTranslatesAutoresizingMaskIntoConstraints
                        //to false.
                        [_tabBar setTranslatesAutoresizingMaskIntoConstraints:NO];
                        
                        //IOS 8
                        //activate the constrains.
                        //we pass an array of all the contraints
                        [NSLayoutConstraint activateConstraints:@[leadingContraints,trailingContraints,bottomContraints,heightContraints]];
                        
                    });
                }
            }
        }
    }];
    
    [postDataTask resume];
}

- (void)fetchFuelStationsForSelectedType:(NSInteger)index {
    
    self.manager = [CLLocationManager updateManagerWithAccuracy:100.0 locationAge:15.0 authorizationDesciption:CLLocationUpdateAuthorizationDescriptionWhenInUse];
    
    if ([CLLocationManager isLocationUpdatesAvailable]) {
        
        [self.manager startUpdatingLocationWithUpdateBlock:^(CLLocationManager *manager, CLLocation *location, NSError *error, BOOL *stopUpdating) {
            
            *stopUpdating = YES;
            
            if (location)
            {
                lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
                lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
                
                NSDictionary *productDict = [products objectAtIndex:index];
                NSString *productId = [productDict objectForKey:@"productId"];
                
                NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
                
                NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
                // http://128.199.129.241:8080/FuelOnServer/rest/service
                NSURLComponents *components = [[NSURLComponents alloc]init]; //
                components.scheme = @"http";
                components.host = @"128.199.129.241";
                components.port = [NSNumber numberWithInteger:8080];
                components.path = @"/FuelONServer/rest/service/getStoresForProductNearBy";
                
                NSURLQueryItem *item1 = [NSURLQueryItem queryItemWithName:@"productId" value:productId];
                NSURLQueryItem *item2 = [NSURLQueryItem queryItemWithName:@"lat" value:lat]; // @"28.7072344"
                NSURLQueryItem *item3 = [NSURLQueryItem queryItemWithName:@"lon" value:lon]; // @"77.2104811"
                
                components.queryItems = @[item1,item2,item3];
                
                NSURL *url = components.URL;
                
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                   timeoutInterval:10.0];
                
                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [request setHTTPMethod:@"POST"];
                
                NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    //[self removeHudAfterDelay:0.1];
                    
                    if (!error) {
                        NSError *localError = nil;
                        
                        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&localError];
                        
                        if (localError == nil) {
                            
                            NSLog(@"Response = %@",responseDict);
                            fuelStationBase = [[HomeMapStoreModelBaseClass alloc] initWithDictionary:responseDict];
                            
                            if ([fuelStationBase.errorMessage isEqualToString:@"Success"]) {
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    [_mapView clear];
                                    
                                    [self loadMapView];
                                });
                            }
                        }
                    }
                }];
                
                [postDataTask resume];

            }
        }];
    }
    else {
        //[self callApitoGetShowroom];
    }
}

#pragma mark-

- (void)loadMapView
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[lat floatValue]
                                                                longitude:[lon floatValue]
                                                                     zoom:13];
    
   // _mapView = [GMSMapView mapWithFrame:_mapView.bounds camera:camera];
    _mapView.camera = camera;
    _mapView.delegate = self;
    _mapView.myLocationEnabled = YES;
    _mapView.indoorEnabled = YES;
    _mapView.accessibilityElementsHidden = NO;
    _mapView.settings.scrollGestures = YES;
    _mapView.settings.zoomGestures = YES;
    _mapView.settings.compassButton = YES;
    _mapView.settings.myLocationButton = NO;
    //    [googleMaps setMinZoom:5 maxZoom:11];
    
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(28.7072344, 77.2104811);
//    // this will set the camera on goggle maps such that specified bounds are centered on screen at the greatest possible zoom level
//    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:coordinate coordinate:coordinate];
//    [_mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:60]];
    
    [self drawFuelStationsAtMap];
}

- (void)drawFuelStationsAtMap {
    
    for (HomeMapStoreModelResponseObject *fuelStationPin in fuelStationBase.responseObject) {
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([fuelStationPin.lat doubleValue], [fuelStationPin.lon doubleValue]);
        marker.title = fuelStationPin.name;
        marker.snippet = fuelStationPin.address;
        marker.icon = [UIImage imageNamed:@"map_pin"];
        //        marker.iconView = nil;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.userData = fuelStationPin;
        marker.map = _mapView;
    }
}


- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    
    StoreDetailViewController *controller = [StoreDetailViewController instantiateViewControllerWithIdentifier:@"StoreDetailViewController" fromStoryboard:@"Main"];
    
    HomeMapStoreModelResponseObject *fuelStationPin = marker.userData;
    controller.storeId = fuelStationPin.responseObjectIdentifier;
    
    [self.navigationController pushViewController:controller animated:YES];

    return YES;
}


@end
