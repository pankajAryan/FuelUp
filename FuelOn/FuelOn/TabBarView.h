//
//  TabBarView.h
//  FuelOn
//
//  Created by Pankaj Yadav on 28/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarView : UIView

@property (nonatomic, strong) NSMutableArray *productTabItems;
@property (nonatomic, assign) NSInteger selectedTabIndex;

@property (copy) void (^tabBarItemSelectionCallback)(NSInteger selectedItemIndex);

- (void)setTabItemsLayoutWithProducts:(NSArray*)products defaultSelectedIndex:(NSInteger)index;

//- (void)setTabbarItemSelected:(NSInteger)itemIndex;

- (IBAction)tabBarItemDidSelect:(UIButton*)selectedButton;


@end
