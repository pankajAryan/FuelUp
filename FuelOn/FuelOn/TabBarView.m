//
//  TabBarView.m
//  FuelOn
//
//  Created by Pankaj Yadav on 28/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import "TabBarView.h"
#import "Reachability.h"
#import "UIViewController+Utility.h"

@interface TabBarView()

@property (weak, nonatomic) IBOutlet UIView *containerViewItem1;
@property (weak, nonatomic) IBOutlet UIImageView *item1;
@property (weak, nonatomic) IBOutlet UILabel *item1Label;

@property (weak, nonatomic) IBOutlet UIView *containerViewItem2;
@property (weak, nonatomic) IBOutlet UIImageView *item2;
@property (weak, nonatomic) IBOutlet UILabel *item2Label;

@property (weak, nonatomic) IBOutlet UIView *containerViewItem3;
@property (weak, nonatomic) IBOutlet UIImageView *item3;
@property (weak, nonatomic) IBOutlet UILabel *item3Label;

@property (weak, nonatomic) IBOutlet UIView *containerViewItem4;
@property (weak, nonatomic) IBOutlet UIImageView *item4;
@property (weak, nonatomic) IBOutlet UILabel *item4Label;


@end


@implementation TabBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setTabItemsLayoutWithProducts:(NSArray*)products {
    
    _productTabItems = [products copy];
    
  //  for (NSDictionary *fuel in _productTabItems)
        
    for (int i = 0; i < _productTabItems.count; i++) {
        
        NSDictionary *fuel = [_productTabItems objectAtIndex:i];
        
        switch (i)
        {
            case 0:
                _item1Label.text = [fuel objectForKey:@"productName"];
                _item1.image = [UIImage imageNamed:[self getImageForTabItem:_item1Label.text isSelected:YES]];
                
                break;
                
            case 1:
                _item2Label.text = [fuel objectForKey:@"productName"];
                _item2.image = [UIImage imageNamed:[self getImageForTabItem:_item1Label.text isSelected:NO]];

                break;
                
            case 2:
                _item3Label.text = [fuel objectForKey:@"productName"];
                _item3.image = [UIImage imageNamed:[self getImageForTabItem:_item1Label.text isSelected:NO]];

                break;
                
            case 3:
                _item4Label.text = [fuel objectForKey:@"productName"];
                _item4.image = [UIImage imageNamed:[self getImageForTabItem:_item1Label.text isSelected:NO]];

                break;
                
            default:
                break;
        }
    }
}

- (NSString*)getImageForTabItem:(NSString*)fuelName isSelected:(BOOL)selected {
    
    if ([fuelName compare:@"Regular 91" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        if (selected)
            return @"footer_icon1_on";
        else
            return @"footer_icon1";
    }
    else if ([fuelName compare:@"Regular 95" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        if (selected)
            return @"footer_icon2_on";
        else
            return @"footer_icon2";
    }
    if ([fuelName compare:@"Regular 98" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        if (selected)
            return @"footer_icon3_on";
        else
            return @"footer_icon3";
    }
    else {// ([fuelName compare:@"Diesel" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        if (selected)
            return @"footer_icon4_on";
        else
            return @"footer_icon4";
    }
}

- (IBAction)tabBarItemDidSelect:(UIButton*)selectedButton {
    
    if ([UIViewController isNetworkAvailable])
    {
        switch (selectedButton.tag) {
                
            case 0:
                _item1.image = [UIImage imageNamed:[self getImageForTabItem:_item1Label.text isSelected:YES]];
                _item2.image = [UIImage imageNamed:[self getImageForTabItem:_item2Label.text isSelected:NO]];
                _item3.image = [UIImage imageNamed:[self getImageForTabItem:_item3Label.text isSelected:NO]];
                _item4.image = [UIImage imageNamed:[self getImageForTabItem:_item4Label.text isSelected:NO]];
                
                _containerViewItem1.backgroundColor = [UIColor colorWithRed:253/255.0 green:161/255.0 blue:2/255.0 alpha:1.0];
                _containerViewItem2.backgroundColor = [UIColor clearColor];
                _containerViewItem3.backgroundColor = [UIColor clearColor];
                _containerViewItem4.backgroundColor = [UIColor clearColor];
                
                _item1Label.textColor = [UIColor whiteColor];
                _item2Label.textColor = [UIColor blackColor];
                _item3Label.textColor = [UIColor blackColor];
                _item4Label.textColor = [UIColor blackColor];
                
                break;
                
            case 1:
                _item1.image = [UIImage imageNamed:[self getImageForTabItem:_item1Label.text isSelected:NO]];
                _item2.image = [UIImage imageNamed:[self getImageForTabItem:_item2Label.text isSelected:YES]];
                _item3.image = [UIImage imageNamed:[self getImageForTabItem:_item3Label.text isSelected:NO]];
                _item4.image = [UIImage imageNamed:[self getImageForTabItem:_item4Label.text isSelected:NO]];
                
                _containerViewItem1.backgroundColor = [UIColor clearColor];
                _containerViewItem2.backgroundColor = [UIColor colorWithRed:253/255.0 green:161/255.0 blue:2/255.0 alpha:1.0];
                _containerViewItem3.backgroundColor = [UIColor clearColor];
                _containerViewItem4.backgroundColor = [UIColor clearColor];
                
                _item1Label.textColor = [UIColor blackColor];
                _item2Label.textColor = [UIColor whiteColor];
                _item3Label.textColor = [UIColor blackColor];
                _item4Label.textColor = [UIColor blackColor];
                
                break;
                
            case 2:
                _item1.image = [UIImage imageNamed:[self getImageForTabItem:_item1Label.text isSelected:NO]];
                _item2.image = [UIImage imageNamed:[self getImageForTabItem:_item2Label.text isSelected:NO]];
                _item3.image = [UIImage imageNamed:[self getImageForTabItem:_item3Label.text isSelected:YES]];
                _item4.image = [UIImage imageNamed:[self getImageForTabItem:_item4Label.text isSelected:NO]];
                
                _containerViewItem1.backgroundColor = [UIColor clearColor];
                _containerViewItem2.backgroundColor = [UIColor clearColor];
                _containerViewItem3.backgroundColor = [UIColor colorWithRed:253/255.0 green:161/255.0 blue:2/255.0 alpha:1.0];
                _containerViewItem4.backgroundColor = [UIColor clearColor];
                
                _item1Label.textColor = [UIColor blackColor];
                _item2Label.textColor = [UIColor blackColor];
                _item3Label.textColor = [UIColor whiteColor];
                _item4Label.textColor = [UIColor blackColor];
                
                break;
                
            case 3:
                _item1.image = [UIImage imageNamed:[self getImageForTabItem:_item1Label.text isSelected:NO]];
                _item2.image = [UIImage imageNamed:[self getImageForTabItem:_item2Label.text isSelected:NO]];
                _item3.image = [UIImage imageNamed:[self getImageForTabItem:_item3Label.text isSelected:NO]];
                _item4.image = [UIImage imageNamed:[self getImageForTabItem:_item4Label.text isSelected:YES]];
                
                _containerViewItem1.backgroundColor = [UIColor clearColor];
                _containerViewItem2.backgroundColor = [UIColor clearColor];
                _containerViewItem3.backgroundColor = [UIColor clearColor];
                _containerViewItem4.backgroundColor = [UIColor colorWithRed:253/255.0 green:161/255.0 blue:2/255.0 alpha:1.0];
                
                _item1Label.textColor = [UIColor blackColor];
                _item2Label.textColor = [UIColor blackColor];
                _item3Label.textColor = [UIColor blackColor];
                _item4Label.textColor = [UIColor whiteColor];
                
                break;
                
            default:
                break;
        }
        
        self.tabBarItemSelectionCallback(selectedButton.tag);
    }
    else {
        [UIViewController showAlert:@"No internet available!"];
    }
}


@end
