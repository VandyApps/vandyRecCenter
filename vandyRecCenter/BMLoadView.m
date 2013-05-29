//
//  BMLoadView.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "BMLoadView.h"

@interface BMLoadView()

@property (nonatomic, strong) UIActivityIndicatorView* loadSpiral;

@end


@implementation BMLoadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (id) initWithParent: (UIView*) parent {
    
    self = [super initWithFrame: CGRectMake((parent.frame.size.width - 150) / 2.0, (parent.frame.size.height - 150) / 2.0, 150, 150)];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = .7;
        self.layer.cornerRadius = 10;
        [parent addSubview: self];
    }
    return self;
}



@end
