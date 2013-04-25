//
//  BubbleTabBarItem.m
//  Pods
//
//  Created by Brendan McNamara on 4/25/13.
//
//

#import "BubbleTabBarItem.h"

@implementation BubbleTabBarItem

@synthesize radius = _radius;

#pragma - getters and setters

- (CGFloat) radius {
    if (_radius == 0) {
        _radius = DEFAULT_RADIUS;
    }
    return DEFAULT_RADIUS;
}

#pragma - initializers

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (BubbleTabBarItem *)itemWithTitle:(NSString *)title image:(UIImage *)image {
    BubbleTabBarItem *item = [[BubbleTabBarItem alloc] initWithFrame:CGRectZero];
    
    item.title = title;
    
    item.titleColor = [UIColor blackColor];
    item.image = image;
    item.layer.cornerRadius = 25;
    item.layer.borderWidth = 3;
    item.layer.borderColor = [[UIColor clearColor] CGColor];
    item.layer.backgroundColor = [[UIColor greenColor] CGColor];
    return item;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

}
 */


@end
