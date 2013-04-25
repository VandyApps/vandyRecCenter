//
//  BubbleTabBar.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "BubbleTabBar.h"

@implementation BubbleTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //maybe add a border, on the top or right, depending on the orientation
        NSLog(@"In here");
        self.showsItemHighlight = NO;
    }
    return self;
}

- (id) init {
    self = [self initWithFrame: CGRectZero];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
