//
//  PinAnnotationView.h
//  FuelOn
//
//  Created by B0081006 on 8/30/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinAnnotationView : UIView
@property (strong, nonatomic) IBOutlet UIView *view_pin;
@property (weak, nonatomic) IBOutlet UILabel *label_price;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
