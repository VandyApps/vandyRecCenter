//
//  BubbleTabBarItem.h
//  Pods
//
//  Created by Brendan McNamara on 4/25/13.
//
//


#import "NGTabBarItem.h"
#import <QuartzCore/QuartzCore.h>

#define BACKGROUND_COLOR_DEFAULT    [UIColor blackColor]
#define SELECTED_BACKGROUND_COLOR_DEFAULT   [UIColor blueColor]
#define SIZE_OF_ITEM_VERTICAL_DEFAULT 90
#define SIZE_OF_ITEM_HORIZONTAL_DEFAULT 78


@interface BubbleTabBarItem : NGTabBarItem


//setting this property determines the values of the radius 
@property (nonatomic, assign) CGFloat heightOfItemForHorizontalTabBar;
@property (nonatomic, assign) CGFloat heightOfItemForVerticalTabBar;
@property (nonatomic, readonly) CGFloat radiusWithHorizontalTabBar;
@property (nonatomic, readonly) CGFloat radiusWithVerticalTabBar;

@property (nonatomic, strong) UIColor* backgroundColorForItem;
@property (nonatomic, strong) UIColor* selectedBackgroundColorForItem;

//other properties from super class
/*
 UIColor *titleColor
 UIColor *selectedTitleColor
 BOOL selected
 */

+ (BubbleTabBarItem *)itemWithTitle:(NSString *)title image:(UIImage *)image;

@end
