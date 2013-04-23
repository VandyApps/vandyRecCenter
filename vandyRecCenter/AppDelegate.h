//
//  AppDelegate.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 3/23/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGTabBarController.h"
#import "NGTabBarControllerDelegate.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, NGTabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
