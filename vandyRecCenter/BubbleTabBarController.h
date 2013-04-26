//
//  CustomTabBarController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/23/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "NGTabBarController.h"
#import "BubbleTabBar.h"
#import "BubbleTabBarItem.h"



//view controllers

@interface BubbleTabBarController : NGTabBarController <NGTabBarControllerDelegate>

@property (nonatomic, strong) BubbleTabBar *tabBar;
@property (nonatomic, assign) CGFloat paddingForHorizontalBar;
@property (nonatomic, assign) CGFloat paddingForVerticalBar;
@end
