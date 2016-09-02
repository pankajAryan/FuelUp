//
//  SearchViewController.h
//  FuelOn
//
//  Created by Pankaj Yadav on 01/09/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
