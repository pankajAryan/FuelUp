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
#import "PinAnnotationView.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SearchViewController.h"

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
    
    self.manager = [CLLocationManager updateManagerWithAccuracy:100.0 locationAge:15.0 authorizationDesciption:CLLocationUpdateAuthorizationDescriptionWhenInUse];
}

- (void)viewWillAppear:(BOOL)animated {
    
    BOOL isSetupRequired =  (lat == nil || fuelStationBase == nil) ? YES : NO;

    if (isSetupRequired) {
        
        if ([CLLocationManager isLocationUpdatesAvailable]) {
            
            [self.manager startUpdatingLocationWithUpdateBlock:^(CLLocationManager *manager, CLLocation *location, NSError *error, BOOL *stopUpdating) {
                
                *stopUpdating = YES;
                
                if (location)
                {
                    lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
                    lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self setupMapView];
                    });
                    
                    [self fetchProducts];
                }
                else
                    [self showAlert:@"Could not determine your location. Please check location settings."];
            }];
        }
        else {
            [self showAlert:@"Please enable location services from settings."];
        }
    }
}

- (void)setupMapView {
    // Map Setup
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[lat floatValue]
                                                            longitude:[lon floatValue]
                                                                 zoom:14];
    
    // _mapView = [GMSMapView mapWithFrame:_mapView.bounds camera:camera]; Use if mapView is not created in xib
    _mapView.camera = camera;
    _mapView.delegate = self;
    _mapView.myLocationEnabled = YES;
    _mapView.indoorEnabled = YES;
    _mapView.accessibilityElementsHidden = NO;
    _mapView.settings.scrollGestures = YES;
    _mapView.settings.zoomGestures = YES;
    _mapView.settings.compassButton = YES;
    _mapView.settings.myLocationButton = NO;
    
    _mapView.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark- TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
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
            
        case 6:
        {
            menuTitle.text = @"Logout";
            menuIcon.image = [UIImage imageNamed:@"logout"];
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
    
    if (indexPath.row == 6) { // Logout
        [App_Delegate logout];
    }
    else {
        [self.view layoutIfNeeded];
        
        [UIView animateWithDuration:0.5 animations:^{
            // Hide Manu
            _layoutConstraintMenuView_leading.constant = -ScreenHeight;
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark - Action Methods

- (IBAction)menuButtonAction:(id)sender {
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (_menuButton.tag) {
            // Hide Manu
            _layoutConstraintMenuView_leading.constant = -ScreenHeight;
            _menuButton.tag = 0;
        }
        else {
            // Show Manu
            _layoutConstraintMenuView_leading.constant = 0;
            _menuButton.tag = 1;
        }
        
        [self.view layoutIfNeeded];
    }];

}

#pragma mark- API Requests

- (void)fetchProducts {
    
    if ([UIViewController isNetworkAvailable])
    {
        [self showProgressHudWithMessage:@""];

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
                        
//                        NSMutableArray *fetchedProducts = [[responseDict objectForKey:@"responseObject"] mutableCopy];
                        products = [responseDict objectForKey:@"responseObject"];
                        
                        NSString *favProductId = [UIViewController retrieveDataFromUserDefault:@"favProductId"];
                        NSInteger defaultSelectionIndex = 0;
                        if (favProductId && favProductId.length) {
                            
                            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"productId CONTAINS[cd]%@", favProductId];
                            NSArray *filteredArray = [products filteredArrayUsingPredicate:predicate];
                            defaultSelectionIndex = [products indexOfObject:[filteredArray objectAtIndex:0]];
//                            [fetchedProducts removeObjectAtIndex:index];
//                            [fetchedProducts insertObject:[filteredArray objectAtIndex:0] atIndex:0];
                        }
                        
//                        products = [fetchedProducts copy];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self fetchFuelStationsForSelectedType:defaultSelectionIndex showLoading:NO];

                            [self.tabBar setTabItemsLayoutWithProducts:products defaultSelectedIndex:defaultSelectionIndex];
                            
                            self.tabBar.tabBarItemSelectionCallback = ^(NSInteger selectedItemIndex){
                                
                                [self fetchFuelStationsForSelectedType:selectedItemIndex showLoading:YES];
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
    else {
        [self showAlert:@"No internet available!"];
    }
}

- (void)fetchFuelStationsForSelectedType:(NSInteger)index showLoading:(BOOL)isHudRequired {
    
    if ([CLLocationManager isLocationUpdatesAvailable]) {
        
        [self.manager startUpdatingLocationWithUpdateBlock:^(CLLocationManager *manager, CLLocation *location, NSError *error, BOOL *stopUpdating) {
            
            *stopUpdating = YES;
            
            if (location) // -36.908655 // 174.9392557
            {
                lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
                lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
                
                NSDictionary *productDict = [products objectAtIndex:index];
                NSString *productId = [productDict objectForKey:@"productId"];
            
                if ([UIViewController isNetworkAvailable])
                {
                    if (isHudRequired)
                        [self showProgressHudWithMessage:@""];

                    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
                    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
                    // http://128.199.129.241:8080/FuelOnServer/rest/service
                    NSURLComponents *components = [[NSURLComponents alloc]init]; //
                    components.scheme = @"http";
                    components.host = @"128.199.129.241";
                    components.port = [NSNumber numberWithInteger:8080];
                    components.path = @"/FuelONServer/rest/service/getStoresForProductNearBy";
                    
                    NSURLQueryItem *item1 = [NSURLQueryItem queryItemWithName:@"productId" value:productId];
                    NSURLQueryItem *item2 = [NSURLQueryItem queryItemWithName:@"lat" value:lat];
                    NSURLQueryItem *item3 = [NSURLQueryItem queryItemWithName:@"lon" value:lon];
                    
                    components.queryItems = @[item1,item2,item3];
                    
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
                                BOOL isResetRequired =  (lat == nil || fuelStationBase == nil) ? YES : NO;

                                fuelStationBase = [[HomeMapStoreModelBaseClass alloc] initWithDictionary:responseDict];
                                
                                if ([fuelStationBase.errorMessage isEqualToString:@"Success"]) {
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        [_mapView clear];
                                        
                                        if (isResetRequired)
                                            [self loadMapView];
                                        else
                                            [self drawFuelStationsAtMap];
                                    });
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
            else
                [self showAlert:@"Could not determine your location. Please check location settings."];
        }];
    }
    else {
        [self showAlert:@"Please enable location services from settings."];
    }
}

#pragma mark-

- (void)loadMapView
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[lat floatValue]
                                                                longitude:[lon floatValue]
                                                                     zoom:14];
    
    _mapView.camera = camera;
    
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
        
        PinAnnotationView *pin = [[PinAnnotationView alloc]initWithFrame:CGRectMake(0, 0, 62, 70)];
        pin.imageView.image = [self getImageForBrand:fuelStationPin.brand  premiumflag:fuelStationPin.isPremium];

        if (fuelStationPin.productList.count)
        {
            HomeMapStoreModelProductList *product = [fuelStationPin.productList objectAtIndex:0];
            pin.label_price.text = [NSString stringWithFormat:@"$%@",product.cost];
        }
        
        marker.iconView = pin;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.userData = fuelStationPin;
        marker.map = _mapView;
    }
}


- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    
    if ([UIViewController isNetworkAvailable])
    {
        StoreDetailViewController *controller = [StoreDetailViewController instantiateViewControllerWithIdentifier:@"StoreDetailViewController" fromStoryboard:@"Main"];
        
        HomeMapStoreModelResponseObject *fuelStationPin = marker.userData;
        controller.storeId = fuelStationPin.responseObjectIdentifier;
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    else {
        [self showAlert:@"No internet available!"];
    }

    return YES;
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    [_searchBar resignFirstResponder];
    // Use for dismissing menu (If in open state)
    
    if (_menuButton.tag) {
        // Hide Manu
        [self menuButtonAction:_menuButton];
    }
}

- (IBAction)gpsButtonDidTap:(id)sender {
    
    // Reset location and pins data.
    lat = nil; lon = nil; fuelStationBase = nil;
    
    [self fetchFuelStationsForSelectedType:_tabBar.selectedTabIndex showLoading:YES];
}

- (IBAction)cheapestFuelButtonDidTap:(id)sender {
    [self showAlert:@"Feature coming soon!"];
}

#pragma mark- Search related methods
/*
- (IBAction)searchButtonAction:(id)sender {
    SearchViewController *controller = [SearchViewController instantiateViewControllerWithIdentifier:@"SearchViewController" fromStoryboard:@"Main"];
    [self presentViewController:controller animated:YES completion:nil];
 
    [_searchBar becomeFirstResponder];
}
*/

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_searchBar setShowsCancelButton:YES];
        _searchBar.alpha = 1.0;
    });
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _searchBar.showsCancelButton = NO;
        _searchBar.alpha = 0.7;
    });
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_searchBar resignFirstResponder];
    });
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_searchBar resignFirstResponder];
    });
}


@end
