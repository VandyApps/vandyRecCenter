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
#define SIZE_OF_ITEM_VERTICAL 90
#define SIZE_OF_ITEM_HORIZONTAL 78
#define DEFAULT_CORNER_RADIUS_FOR_VERTICAL 45
#define DEFAULT_CORNER_RADIUS_FOR_HORIZONTAL 39

@interface BubbleTabBarItem : NGTabBarItem

//radius of the item
@property (nonatomic, assign) CGFloat radius;
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
