//
//  BubbleTabBarItem.h
//  Pods
//
//  Created by Brendan McNamara on 4/25/13.
//
//


#import "NGTabBarItem.h"
#import <QuartzCore/QuartzCore.h>

#define SIZE_OF_ITEM_VERTICAL 100
#define SIZE_OF_ITEM_HORIZONTAL 70
#define DEFAULT_CORNER_RADIUS_FOR_VERTICAL 50
#define DEFAULT_CORNER_RADIUS_FOR_HORIZONTAL 35
@interface BubbleTabBarItem : NGTabBarItem

//radius of the item
@property (nonatomic, assign) CGFloat radius;


+ (BubbleTabBarItem *)itemWithTitle:(NSString *)title image:(UIImage *)image;

@end
