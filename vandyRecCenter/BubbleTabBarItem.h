//
//  BubbleTabBarItem.h
//  Pods
//
//  Created by Brendan McNamara on 4/25/13.
//
//


#import "NGTabBarItem.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_RADIUS 10
@interface BubbleTabBarItem : NGTabBarItem

//radius of the item
@property (nonatomic, assign) CGFloat radius;

+ (BubbleTabBarItem *)itemWithTitle:(NSString *)title image:(UIImage *)image;

@end
