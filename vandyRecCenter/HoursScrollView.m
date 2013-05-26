//
//  HoursScrollView.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "HoursScrollView.h"

@interface HoursScrollView()

@property (nonatomic, assign) CGRect currentFrame;
@property (nonatomic, strong) NSArray* subviews;
@end
@implementation HoursScrollView

#pragma mark - Getters
- (NSArray*) subviews {
    if (_subviews == nil) {
        _subviews = [[NSArray alloc] init];
    }
    return  _subviews;
}

#pragma mark - managing subviews
- (void) addSubview:(UIView *)view {
    [super addSubview: view];
    self.subviews = [self.subviews arrayByAddingObject: view];
}

- (void) removeAllSubviews {
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
}
#pragma mark - Initializers

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
        self.currentFrame = self.frame;
    }
    return self;
}

#pragma mark - Lifecycle

- (void) layoutSubviews {
    
    [super layoutSubviews];
    if (self.frame.size.height != self.currentFrame.size.height || self.frame.size.width != self.currentFrame.size.width || self.frame.origin.x != self.currentFrame.origin.x || self.frame.origin.y != self.currentFrame.origin.y) {
        
        self.currentFrame = self.frame;
    }
}


#pragma mark - Publics

- (void) setUpScrollViewWithHours:(NSDictionary *)hours {
    //set up the scroll view here
}
@end
