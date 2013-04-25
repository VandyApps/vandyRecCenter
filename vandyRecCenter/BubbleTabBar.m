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
    
    return self;
}

- (id) init {
    self = [self initWithFrame: CGRectZero];
    if (self) {
        self.layer.borderWidth = 2;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.frame = CGRectMake(self.frame.origin.x - 5, self.frame.origin.y + 5, self.frame.size.width + 10, self.frame.size.height);
    }
    return self;
}



@end
