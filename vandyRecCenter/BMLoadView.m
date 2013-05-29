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
@property (nonatomic, weak) UIView* parent;
@property (nonatomic, strong) UILabel* titleView;
@end


@implementation BMLoadView

@synthesize loadSpiral = _loadSpiral;
@synthesize parent = _parent;
@synthesize titleView = _titleView;

#pragma mark - Initializers
- (id) initWithParent: (UIView*) parent {
    
    self = [super initWithFrame: CGRectMake((parent.frame.size.width - 150) / 2.0, (parent.frame.size.height - 150) / 2.0, 150, 150)];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = .7;
        self.layer.cornerRadius = 10;
        self.parent = parent;
        [self setUpSubViews];
        self.hidden = YES;
    }
    return self;
}

#pragma mark - setup
- (void) setUpSubViews {
    self.titleView = [[UILabel alloc] initWithFrame: CGRectMake((self.frame.size.width - BM_TITLE_WIDTH) / 2.0, BM_TITLE_Y, BM_TITLE_WIDTH, BM_TITLE_HEIGHT)];
    self.titleView.backgroundColor = [UIColor clearColor];
    self.titleView.font = [UIFont fontWithName: @"TrebuchetMS-Bold" size: 25];
    self.titleView.textAlignment = NSTextAlignmentCenter;
    self.titleView.textColor = [UIColor whiteColor];
    self.titleView.text = @"Loading";
    
    self.loadSpiral = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadSpiral.center = CGPointMake(self.frame.size.width/ 2.0, BM_INDICATOR_Y_CENTER);
    
    [self addSubview: self.titleView];
    [self addSubview: self.loadSpiral];
}

#pragma mark - Public
- (void) show {
    if (self.hidden) {
        self.hidden = NO;
        [self.parent addSubview: self];
    }
}

- (void) hide {
    if (!self.hidden) {
        self.hidden = YES;
        [self removeFromSuperview];
    }
}

- (void) toggle {
    if (self.hidden) {
        [self show];
    } else {
        [self hide];
    }
}

- (void) start {
    [self.loadSpiral startAnimating];
}

- (void) stop {
    [self.loadSpiral stopAnimating];
}


@end
