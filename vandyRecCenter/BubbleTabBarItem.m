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
    
    item.titleColor = [UIColor whiteColor];
    item.image = image;
    //item.layer.cornerRadius = 25;
    item.layer.borderWidth = 3;
    item.layer.borderColor = [[UIColor whiteColor] CGColor];
    item.layer.backgroundColor = [[UIColor blackColor] CGColor];
    return item;
}

#pragma - Control State Handling

- (void) setSelected:(BOOL)selected {
    [super setSelected: selected];
    if (selected) {
    
        self.layer.backgroundColor = [[UIColor blueColor] CGColor];
    } else {
        self.layer.backgroundColor = [[UIColor blackColor] CGColor];
    }
}
@end
