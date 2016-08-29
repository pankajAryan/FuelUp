//
//  FFLeftMenuViewController.h
//  FabFurnish
//
//  Created by Amit Kumar on 08/05/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFLeftMenuViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;


@end
