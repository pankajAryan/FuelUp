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
#import "StoreDetailCell.h"
#import "FFConstant.h"
#import "PinAnnotationView.h"

@interface StoreDetailViewController () {

    StoreDetailBaseClass *storeDetailBase;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTableViewHeight;

@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.table_storeDetail setRowHeight:UITableViewAutomaticDimension];
    
    if ([UIViewController isNetworkAvailable])
    {
        [self showProgressHudWithMessage:@"Fetching details..."];

        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
        
        NSURLComponents *components = [[NSURLComponents alloc]init]; //
        components.scheme = @"http";
        components.host = @"128.199.129.241";
        components.port = [NSNumber numberWithInteger:8080];
        components.path = @"/FuelONServer/rest/service/getStoreDetail";
        
        NSURLQueryItem *item1 = [NSURLQueryItem queryItemWithName:@"storeId" value:_storeId]; //
        
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
                            
                            [self loadMapView];
                            
                            _label_storeName.text = [NSString stringWithFormat:@"Store Name: %@",storeDetailBase.responseObject.name];
                            _label_headerAddress.text = storeDetailBase.responseObject.address;
                            
                            
                            for (int i = 0; i < storeDetailBase.responseObject.productList.count; i++) {
                                
                                HomeMapStoreModelProductList *product = [storeDetailBase.responseObject.productList objectAtIndex:i];
                                
                                switch (i)
                                {
                                    case 0:
                                        _label_regularTitle.text = product.product.productName;
                                        _label_regularValue.text = [NSString stringWithFormat:@"$ %@",product.cost];
                                        _label_regularTimestamp.text = product.lastUpdated;//[NSString stringWithFormat:@"Last updated by: %@",product.lastUpdated];
                                        
                                        break;
                                        
                                    case 1:
                                        _label_mediumTitle.text = product.product.productName;
                                        _label_mediumValue.text = [NSString stringWithFormat:@"$ %@",product.cost];
                                        _label_mediumTimestamp.text = product.lastUpdated;//[NSString stringWithFormat:@"Last updated by: %@",product.lastUpdated];

                                        break;
                                        
                                    case 2:
                                        _label_premiumTitle.text = product.product.productName;
                                        _label_premiumValue.text = [NSString stringWithFormat:@"$ %@",product.cost];
                                        _label_premiumTimestamp.text = product.lastUpdated;//[NSString stringWithFormat:@"Last updated by: %@",product.lastUpdated];

                                        break;
                                        
                                    case 3:
                                        _label_dieselTitle.text = product.product.productName;
                                        _label_dieselValue.text = [NSString stringWithFormat:@"$ %@",product.cost];
                                        _label_dieselTimestamp.text = product.lastUpdated;//[NSString stringWithFormat:@"Last updated by: %@",product.lastUpdated];

                                        break;
                                        
                                    default:
                                        break;
                                }
                            }
                            
                            _view_tableHeader.hidden = NO;

                            if (storeDetailBase.responseObject.offerList.count) {
                                
                                _table_storeDetail.hidden = NO;
                                
                                _constraintTableViewHeight.constant = ScreenHeight - 230; // 230 is Map view's height
                                [self.view layoutIfNeeded];
                                [_table_storeDetail reloadData];
                            }
                            else {
                                _labelNoOffers.hidden = NO;
                            }
                            
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

- (IBAction)action_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)action_favourites:(id)sender {
    
    [self showAlert:@"Added to favourites"];
}


- (IBAction)openDirectionsInExternalMap:(id)sender {
    
    if ([[UIApplication sharedApplication] canOpenURL:
         [NSURL URLWithString:@"comgooglemaps://"]])
    {
        NSString *urlString=[NSString stringWithFormat:@"comgooglemaps://?daddr=%@,%@&zoom=14&directionsmode=driving",storeDetailBase.responseObject.lat, storeDetailBase.responseObject.lon];
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:urlString]];
    }
    else
    {
        NSString *string = [NSString stringWithFormat:@"http://maps.apple.com/?ll=%@,%@",storeDetailBase.responseObject.lat, storeDetailBase.responseObject.lon];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    }
}


#pragma mark - UITableViewDelegates & UITableViewDatasources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return storeDetailBase.responseObject.offerList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"StoreDetailCellID";
    
    StoreDetailCell *offerCell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (offerCell == nil) {
        offerCell = [[StoreDetailCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    StoreDetailOfferList *offer = [storeDetailBase.responseObject.offerList objectAtIndex:indexPath.row];
    offerCell.label_price.text = [NSString stringWithFormat:@"%@ cents off",offer.discountOffer];
    offerCell.label_title.text = offer.offerName;
    offerCell.label_titleValue.text = offer.condition;
    offerCell.label_validity.text = [NSString stringWithFormat:@"Valid until %@",offer.endDate];;

    return offerCell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}


#pragma mark-

- (void)loadMapView
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[storeDetailBase.responseObject.lat floatValue]
                                                            longitude:[storeDetailBase.responseObject.lon floatValue]
                                                                 zoom:14];
    _mapView.camera = camera;
    _mapView.myLocationEnabled = YES;
    _mapView.indoorEnabled = YES;
    _mapView.accessibilityElementsHidden = NO;
    _mapView.settings.scrollGestures = NO;
    _mapView.settings.zoomGestures = YES;
    _mapView.settings.compassButton = NO;
    _mapView.settings.myLocationButton = NO;
    
    [self drawFuelStationAtMap];
}

- (void)drawFuelStationAtMap {
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([storeDetailBase.responseObject.lat doubleValue], [storeDetailBase.responseObject.lon doubleValue]);
    
    PinAnnotationView *pin = [[PinAnnotationView alloc]initWithFrame:CGRectMake(0, 0, 62, 70)];
    pin.imageView.image = [self getImageForBrand:storeDetailBase.responseObject.brand];
    
    if (storeDetailBase.responseObject.productList.count)
    {
        HomeMapStoreModelProductList *product = [storeDetailBase.responseObject.productList objectAtIndex:0];
        pin.label_price.text = [NSString stringWithFormat:@"$%@",product.cost];
    }
    
    marker.iconView = pin;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = _mapView;
}


@end
