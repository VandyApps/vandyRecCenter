//
//  GraphModel.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphPoint.h"
@interface GraphModel : NSObject

//an array of points organized in increasing x values
@property (nonatomic, strong, readonly) NSArray* graphPoints;

//throws an error if the array contains an object that is not a graph point
- (id) initWithPoints: (NSArray*) arrayOfGraphPoints;
- (id) init;

//adds a point to the graph
//adds nothing if the point already exists or if a point with the same X value
//as the point being added exists
- (void) addPoint: (GraphPoint*) point;
//removes a point with the same x value and y value as the CGPoint
//does nothing if there exists no point that matches the CGPoint
- (void) removePointEquivalentToCGPoint: (CGPoint) point;
@end
