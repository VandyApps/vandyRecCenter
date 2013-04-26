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
@synthesize paddingForHorizontalBar = _paddingForHorizontalBar;
@synthesize paddingForVerticalBar = _paddingForVerticalBar;

#pragma - Getters

- (BubbleTabBar*) tabBar {
    if (!_tabBar) {
        _tabBar = [[BubbleTabBar alloc] init];
    }
    return _tabBar;
}

- (CGFloat) paddingForVerticalBar {
    if (_paddingForVerticalBar == 0) {
        _paddingForVerticalBar = ITEM_PADDING_VERTICAL;
    }
    return _paddingForVerticalBar;
}

- (CGFloat) paddingForHorizontalBar {
    if (_paddingForHorizontalBar == 0) {
        _paddingForHorizontalBar = ITEM_PADDING_HORIZONTAL;
    }
    return _paddingForHorizontalBar;
}

#pragma - Setters

- (void) setViewControllers:(NSArray *)viewControllers {
    [super setViewControllers: viewControllers];
    [self setUpTabBarItems];
}

#pragma - Initializers
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
        self.animation = NGTabBarControllerAnimationFade;
        self.animationDuration = .2;
        
        [self setupForInterfaceOrientation: [UIApplication sharedApplication].statusBarOrientation];
        [self setUpTabBar];
        [self setUpTabBarItems];
        
    }
    return self;
}

#pragma - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
}

#pragma - TabBarSetUp

- (void) setUpTabBar {
    
    self.tabBar.layoutStrategy = NGTabBarLayoutStrategyStrungTogether;
    self.tabBar.tintColor = [UIColor colorWithRed: 169.f/255.f green: 149.f/255.f blue:90.f/255.f alpha: 1.f];
    
    self.tabBar.showsItemHighlight = NO;
    if (NGTabBarIsVertical(self.tabBarPosition)) {
        self.tabBar.itemPadding = self.paddingForVerticalBar;
    } else {
        self.tabBar.itemPadding = self.paddingForHorizontalBar;
    }
}

- (void) setUpTabBarItems {
    if (NGTabBarIsVertical(self.tabBarPosition)) {
        for (BubbleTabBarItem *item in self.tabBar.items) {
            item.layer.cornerRadius = item.radiusWithVerticalTabBar;
        }
    } else {
        for (BubbleTabBarItem *item in self.tabBar.items) {
            item.layer.cornerRadius = item.radiusWithHorizontalTabBar;
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
        CGFloat dimension = [(BubbleTabBarItem*) [self.tabBar.items objectAtIndex: index] heightOfItemForVerticalTabBar];
        
        [self setUpTabBar];
        [self setUpTabBarItems];
        
        return CGSizeMake(dimension, dimension);
    } else {
        CGFloat dimension = [(BubbleTabBarItem*) [self.tabBar.items objectAtIndex: index] heightOfItemForHorizontalTabBar];
        [self setUpTabBar];
        [self setUpTabBarItems];
                return CGSizeMake(dimension, dimension);
    }
    
}

@end
