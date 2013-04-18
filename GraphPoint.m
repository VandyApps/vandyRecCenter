//
//  GraphPoint.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GraphPoint.h"

@implementation GraphPoint

- (id) initWithPoint:(CGPoint)point {
    self = [super init];
    if (self) {
        self.x = point.x;
        self.y = point.y;
    }
    return self;
}

- (id) init {
    self = [self initWithPoint: CGPointZero];
    return self;
}

- (BOOL) isEqualToCGPoint:(CGPoint)point {
    if (point.x == self.x && point.y == self.y) {
        return YES;
    }
    return NO;
}

- (BOOL) isEqualToPoint:(GraphPoint *)point {
    if (point.x == self.x && point.y == self.y) {
        return YES;
    }
    return NO;
}

- (CGFloat) distanceFromPoint:(GraphPoint *)point {
    double distance = sqrt( pow(point.x - self.x, 2) + pow(point.y - self.y, 2));
    return distance;
}
@end
