//
//  TabBarView.m
//  FuelOn
//
//  Created by Pankaj Yadav on 28/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import "TabBarView.h"


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
    
}

- (IBAction)tabBarItemDidSelect:(UIButton*)selectedButton {
        
    switch (selectedButton.tag) {
            
        case 0:
            _item1.image = [UIImage imageNamed:@"footer_icon1_on"];
            _item2.image = [UIImage imageNamed:@"footer_icon2"];
            _item3.image = [UIImage imageNamed:@"footer_icon3"];
            _item4.image = [UIImage imageNamed:@"footer_icon4"];
            
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
            _item1.image = [UIImage imageNamed:@"footer_icon1"];
            _item2.image = [UIImage imageNamed:@"footer_icon2_on"];
            _item3.image = [UIImage imageNamed:@"footer_icon3"];
            _item4.image = [UIImage imageNamed:@"footer_icon4"];
            
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
            _item1.image = [UIImage imageNamed:@"footer_icon1"];
            _item2.image = [UIImage imageNamed:@"footer_icon2"];
            _item3.image = [UIImage imageNamed:@"footer_icon3_on"];
            _item4.image = [UIImage imageNamed:@"footer_icon4"];
            
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
            _item1.image = [UIImage imageNamed:@"footer_icon1"];
            _item2.image = [UIImage imageNamed:@"footer_icon2"];
            _item3.image = [UIImage imageNamed:@"footer_icon3"];
            _item4.image = [UIImage imageNamed:@"footer_icon4_on"];
            
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


@end
