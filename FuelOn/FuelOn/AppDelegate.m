//
//  AppDelegate.m
//  FuelOn
//
//  Created by Pankaj Yadav on 20/08/16.
//  Copyright © 2016 Mobiquel. All rights reserved.
//

#import "AppDelegate.h"
#import "UIViewController+Utility.h"
#import "FFConstant.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"AIzaSyCkJL2jsgwEz-UCScBXcdutqfdyPoqMa4g"];
    
    NSString *userId = [UIViewController retrieveDataFromUserDefault:@"userId"];
    
    if (userId && userId.length) {
        
        self.rootNavController = (UINavigationController*)self.window.rootViewController; // it'll return UINavigationController which is set as Initial view controller in storyboard.
        
        HomeViewController *rootVC = [HomeViewController instantiateViewControllerWithIdentifier:@"HomeViewController" fromStoryboard:@"Main"];
        self.rootNavController.viewControllers = @[rootVC];
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

- (void)logout {
    
    [UIViewController saveDatatoUserDefault:@"" forKey:@"userId"];
    
    UINavigationController *rootVC = [UINavigationController instantiateViewControllerWithIdentifier:@"rootNavController" fromStoryboard:@"Main"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.window.rootViewController = rootVC;
        [self.window makeKeyAndVisible];
    });
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
