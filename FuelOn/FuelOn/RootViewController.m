//
//  DEMOViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "FFLeftMenuViewController.h"
#import "UIViewController+Utility.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib
{
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor orangeColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = YES;
    
    self.contentViewController = [UIViewController instantiateViewControllerWithIdentifier:@"contentViewController" fromStoryboard:@"Home"];
    
    FFLeftMenuViewController *leftMenuController = (FFLeftMenuViewController *)[FFLeftMenuViewController instantiateViewControllerWithIdentifier:@"FFLeftMenuViewController" fromStoryboard:@"LeftMenu"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:leftMenuController];
    [navigationController setNavigationBarHidden:YES];
    self.leftMenuViewController = navigationController;
    self.rightMenuViewController = nil;//[self.storyboard instantiateViewControllerWithIdentifier:@"rightMenuViewController"];
//    self.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.delegate = self;
}

//#pragma mark -
//#pragma mark RESideMenu Delegate
//
//- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
//{
//    DDLogDebug(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
//}
//
//- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
//{
//    DDLogDebug(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
//}
//
//- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
//{
//    DDLogDebug(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
//}
//
//- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
//{
//    DDLogDebug(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
//}

@end
