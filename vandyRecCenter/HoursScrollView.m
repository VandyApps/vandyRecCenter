//
//  HoursScrollView.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "HoursScrollView.h"

@implementation HoursScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        NSLog(@"initialization has taken place");
    }
    return self;
}
- (void) layoutSubviews {
    
    [super layoutSubviews];
    NSLog(@"layout subviews is called for the scroll view");
}

@end
