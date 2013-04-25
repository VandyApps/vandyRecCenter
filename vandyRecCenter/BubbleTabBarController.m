//
//  CustomTabBarController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/23/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "BubbleTabBarController.h"

@interface BubbleTabBarController ()


@end

@implementation BubbleTabBarController

@synthesize tabBar = _tabBar;

- (BubbleTabBar*) tabBar {
    if (!_tabBar) {
        _tabBar = [[BubbleTabBar alloc] init];
    }
    return _tabBar;
}
#pragma - Getters and Setters

- (void) setViewControllers:(NSArray *)viewControllers {
    [super setViewControllers: viewControllers];
    [self setUpTabBarItems];
}

#pragma - LifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

 


- (id)initWithDelegate:(id<NGTabBarControllerDelegate>)delegate {
    //need to keep this from getting called somehow
    return nil;
}

- (id) init {
    self = [super initWithDelegate: self];
    if (self) {
        self.animation = NGTabBarControllerAnimationMoveAndScale;
        self.animationDuration = .4;
        
        [self setupForInterfaceOrientation: [UIApplication sharedApplication].statusBarOrientation];
        [self setUpTabBar];
        [self setUpTabBarItems];
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
}



- (void) setUpTabBar {
    
    self.tabBar.layoutStrategy = NGTabBarLayoutStrategyStrungTogether;
    self.tabBar.tintColor = [UIColor colorWithRed: 169.f/255.f green: 149.f/255.f blue:90.f/255.f alpha: 1.f];
    
    self.tabBar.showsItemHighlight = NO;
    if (NGTabBarIsVertical(self.tabBarPosition)) {
        self.tabBar.itemPadding = ITEM_PADDING_VERTICAL;
    } else {
        self.tabBar.itemPadding = ITEM_PADDING_HORIZONTAL;
    }
}

- (void) setUpTabBarItems {
    if (NGTabBarIsVertical(self.tabBarPosition)) {
        for (BubbleTabBarItem *item in self.tabBar.items) {
            item.layer.cornerRadius = DEFAULT_CORNER_RADIUS_FOR_VERTICAL;
        }
    } else {
        for (BubbleTabBarItem *item in self.tabBar.items) {
            item.layer.cornerRadius = DEFAULT_CORNER_RADIUS_FOR_HORIZONTAL;
        }
    }
    
}


#pragma - Orientation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self setupForInterfaceOrientation:toInterfaceOrientation];
}

- (void)setupForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation; {
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        
        self.tabBarPosition = NGTabBarPositionBottom;
        
    } else {
        
        self.tabBarPosition = NGTabBarPositionLeft;
    }
}


#pragma - Delegate

//this method is automatically called when there is a change in orientation
- (CGSize) tabBarController:(NGTabBarController *)tabBarController sizeOfItemForViewController:(UIViewController *)viewController atIndex:(NSUInteger)index position:(NGTabBarPosition)position {
    
    if (NGTabBarIsVertical(position)) {
    
        
        [self setUpTabBar];
        [self setUpTabBarItems];
        return CGSizeMake(SIZE_OF_ITEM_VERTICAL, SIZE_OF_ITEM_VERTICAL);
    } else {
        
        [self setUpTabBar];
        [self setUpTabBarItems];
        return CGSizeMake(SIZE_OF_ITEM_HORIZONTAL, SIZE_OF_ITEM_HORIZONTAL);
    }
    
}

@end
