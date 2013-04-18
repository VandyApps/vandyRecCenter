//
//  GraphModel.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GraphModel.h"

@implementation GraphModel

@synthesize graphPoints = _graphPoints;

- (id) initWithPoints:(NSArray *)arrayOfGraphPoints {
    self = [super init];
    if (self) {
        //use the bubble sort algorithm
        _graphPoints = arrayOfGraphPoints;
        [self sortPoints];
    }
    return self;
}

- (id) init {
    self = [self initWithPoints:nil];
    return self;
}

- (void) addPoint:(GraphPoint *)point {
    
    BOOL foundSlot = NO;
    
    if (self.graphPoints) {
        for (size_t i = 0; i < [self.graphPoints count] && !foundSlot; ++i) {
            
            GraphPoint* nextPoint = [self.graphPoints objectAtIndex: i];
            if (point.x > nextPoint.x) {
            
                //a slot ahead
                if (i == 0) { //insert at the beginning
                
                    NSArray* newSetOfPoints = [[NSArray alloc] initWithObjects: point, nil];
                    newSetOfPoints = [newSetOfPoints arrayByAddingObjectsFromArray:_graphPoints];
                    _graphPoints = newSetOfPoints;
                    
                } else {
                    NSArray* newSetOfPoints = [_graphPoints subarrayWithRange: NSMakeRange(0, i)];
                    newSetOfPoints = [newSetOfPoints arrayByAddingObject: point];
                    newSetOfPoints = [newSetOfPoints arrayByAddingObjectsFromArray:[_graphPoints subarrayWithRange:NSMakeRange(i+1, [_graphPoints count] - i)]];
                    _graphPoints = newSetOfPoints;
                    
                }
                foundSlot = YES;
            } else if (point.x == nextPoint.x) {
                NSLog(@"Found a point with the same x value");
                foundSlot = YES;
            }
        }
    } else { //create a new array
        _graphPoints = [[NSArray alloc] initWithObjects: point, nil];
    }
}


//more optomization to be done here
- (void) removePointEquivalentToCGPoint: (CGPoint) point {
    BOOL doneSearching = NO;
    for (size_t i = 0; i < [self.graphPoints count] && !doneSearching; ++i) {
        GraphPoint* nextPoint = [self.graphPoints objectAtIndex: i];
        if (nextPoint.x == point.x && nextPoint.y == point.y) { //found a match
        
            //remove the ith element from the array
            NSArray* newSetOfPoints = [self.graphPoints subarrayWithRange: NSMakeRange(0, i)];
            newSetOfPoints = [newSetOfPoints arrayByAddingObjectsFromArray: [self.graphPoints subarrayWithRange:NSMakeRange(i+1, [self.graphPoints count] - i - 1)]];
            _graphPoints = newSetOfPoints;
            doneSearching = YES;
        }
    }
}


//private methods


//sorting using bubble sort
//need to do something about an array with points that share an x value
- (void) sortPoints {
    _graphPoints = [self.graphPoints sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ( [ (GraphPoint*) obj1 x] > [ (GraphPoint*) obj2 x]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
            }];
}


@end
