//
//  GraphPoint.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphPoint : NSObject

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
//default constructor

- (id) initWithPoint: (CGPoint) point;
- (id) init; //creates the point (0,0)

- (BOOL) isEqualToPoint: (GraphPoint*) point;
- (BOOL) isEqualToCGPoint: (CGPoint) point;

- (CGFloat) distanceFromPoint: (GraphPoint*) point;
@end
