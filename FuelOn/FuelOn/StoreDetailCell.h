//
//  StoreDetailCell.h
//  FuelOn
//
//  Created by Pankaj Yadav on 30/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_titleValue;
@property (weak, nonatomic) IBOutlet UILabel *label_validity;
@property (weak, nonatomic) IBOutlet UILabel *label_price;
@end
