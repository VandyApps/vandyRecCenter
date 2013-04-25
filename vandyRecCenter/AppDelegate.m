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
    
    BubbleTabBarController* customTBController = [[BubbleTabBarController alloc] init];
    
    
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle:[NSBundle mainBundle]];
    homeViewController *homeController = [mainStoryboard instantiateInitialViewController];
    hoursViewController *hoursController = [mainStoryboard instantiateViewControllerWithIdentifier:@"hours"];
    trafficViewController *trafficController = [mainStoryboard instantiateViewControllerWithIdentifier: @"traffic"];
    UIViewController* classController = [mainStoryboard instantiateViewControllerWithIdentifier:@"classes"];
    UIViewController* intramuralsController = [mainStoryboard instantiateViewControllerWithIdentifier: @"intramurals"];
    UIViewController* programsController = [mainStoryboard instantiateViewControllerWithIdentifier:@"programs"];
    UIViewController* mapController = [mainStoryboard instantiateViewControllerWithIdentifier:@"map"];
    
    UIImage* image1 = [UIImage imageNamed: @"53-house.png"];
    UIImage* image2 = [UIImage imageNamed: @"11-clock.png"];
    UIImage* image3 = [UIImage imageNamed: @"112-group.png"];
    UIImage* image4 = [UIImage imageNamed: @"89-dumbells.png"];
    UIImage* image5 = [UIImage imageNamed: @"63-runner.png"];
    UIImage* image6 = [UIImage imageNamed: @"83-calendar.png"];
    UIImage* image7 = [UIImage imageNamed: @"103-map.png"];
    
    //must set this property before adding view controllers to the array in the tab bar
    homeController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle:@"Home" image: image1];
    hoursController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle:@"Clock" image: image2];
    trafficController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle: @"Traffic" image: image3];
    classController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle: @"Classes" image: image4];
    intramuralsController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle: @"I.M." image:image5];
    programsController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle: @"Programs" image: image6];
    mapController.ng_tabBarItem = [BubbleTabBarItem itemWithTitle: @"Map" image: image7];
    
    
    customTBController.viewControllers = [[NSArray alloc] initWithObjects: homeController, hoursController, trafficController, classController, intramuralsController, programsController, mapController, nil];
  
    customTBController.selectedViewController = homeController;
    //customTBController.tabBar.position = NGTabBarPositionBottom;
    
    
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
