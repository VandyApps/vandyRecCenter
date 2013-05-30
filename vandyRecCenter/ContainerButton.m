//
//  ContainerButton.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "ContainerButton.h"

@implementation ContainerButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
        [self setTitleColor: [UIColor colorWithRed:47/255.0 green: 121/255.0 blue:35/255.0 alpha: 1] forState:UIControlStateSelected];
        self.backgroundColor = [UIColor colorWithRed: 137/255.0 green:171/255.0 blue:255/255.0 alpha:1];
    }
    return self;
}

- (void) setSelected:(BOOL)selected {
    [super setSelected: selected];
    if (selected) {
        self.backgroundColor = [UIColor colorWithRed:100/255.0 green: 1 blue: 75/255.0 alpha:1];
    } else {
        self.backgroundColor = [UIColor colorWithRed: 137/255.0 green:171/255.0 blue:255/255.0 alpha:1];
    }
    
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
