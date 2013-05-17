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
    [[UINavigationBar appearance] setTintColor: [UIColor vanderbiltGold]];
    
    BubbleTabBarController* customTBController = [[BubbleTabBarController alloc] init];
    
    
    //set up the views in the tab bar
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle:[NSBundle mainBundle]];
    TabBarNavigationController *homeNavigationController = [mainStoryboard instantiateInitialViewController];
    TabBarNavigationController *hoursNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier:@"hours"];
    TabBarNavigationController *trafficNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier: @"traffic"];
    TabBarNavigationController* groupFitnessNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier:@"classes"];
    TabBarNavigationController* intramuralsNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier: @"intramurals"];
    TabBarNavigationController* programsNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier:@"programs"];
    TabBarNavigationController* mapNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier:@"map"];
    
    //must set this property before adding view controllers to the array in the tab bar
    homeNavigationController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle:@"Home" image: [UIImage imageNamed: @"53-house.png"]];
    hoursNavigationController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle:@"Hours" image: [UIImage imageNamed: @"11-clock.png"]];
    trafficNavigationController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle: @"Traffic" image: [UIImage imageNamed: @"112-group.png"]];
    groupFitnessNavigationController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle: @"Classes" image: [UIImage imageNamed: @"89-dumbells.png"]];
    intramuralsNavigationController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle: @"I.M." image:[UIImage imageNamed: @"63-runner.png"]];
    programsNavigationController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle: @"Programs" image: [UIImage imageNamed: @"83-calendar.png"]];
    mapNavigationController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle: @"Map" image: [UIImage imageNamed: @"103-map.png"]];
    
    
    customTBController.viewControllers = [[NSArray alloc] initWithObjects: homeNavigationController, hoursNavigationController, trafficNavigationController, groupFitnessNavigationController, intramuralsNavigationController, programsNavigationController, mapNavigationController, nil];
  
    customTBController.selectedViewController = homeNavigationController;
    
    
    self.window.rootViewController = customTBController;
    
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


@end
