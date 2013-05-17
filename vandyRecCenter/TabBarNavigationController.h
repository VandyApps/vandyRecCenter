//
//  TabBarNavigationController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/16/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarNavigationDelegate.h"

@interface TabBarNavigationController : UINavigationController

@property (nonatomic, weak) id<TabBarNavigationDelegate> tabBarDelegate;

@end
