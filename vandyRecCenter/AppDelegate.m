//
//  AppDelegate.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 3/23/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setTintColor: [UIColor blackColor]];
    
    /*
    UIViewController *v1 = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *v2 = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    //UIViewController *v3 = [[UIViewController alloc] init];
    //UIViewController *v4 = [[UIViewController alloc] init];
    //UIViewController *v5 = [[UIViewController alloc] init];
    //UIViewController *v6 = [[UIViewController alloc] init];
    NGTabBarController *customTBController = [[NGTabBarController alloc] initWithDelegate:self];
    customTBController.viewControllers = [[NSArray alloc] initWithObjects: v1, v2, nil];
    v1.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"Home" image: [UIImage imageNamed: @"house.png"]];
    v2.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"Images" image:[UIImage imageNamed: @"group.png"]];
    //v3.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"Live" image:image3];
    //v4.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"Contact" image:image4];
    //v5.ng_tabBarItem = [NGTabBarItem itemWithTitle:@"Settings" image:image5];
    customTBController.tabBar.position = NGTabBarPositionLeft;
    
    customTBController.animation = NGTabBarControllerAnimationMoveAndScale;
    //customTBController.layoutStrategy = $isPhone() ? NGTabBarLayoutStrategyEvenlyDistributed : NGTabBarLayoutStrategyCentered;
    //customTBController.itemPadding = 10.f;
    //customTBController.showsItemHighlight = NO;
    //customTBController.tintColor = [UIColor redColor];
    //customTBController.viewControllers = viewController;
    self.window.rootViewController = customTBController;
    */
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//delegate methods for NGTabBarController
- (CGSize) tabBarController:(NGTabBarController *)tabBarController sizeOfItemForViewController:(UIViewController *)viewController atIndex:(NSUInteger)index position:(NGTabBarPosition)position {
    return CGSizeMake(320, 480);
}

@end
