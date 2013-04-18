//
//  GraphPoint.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphPoint : NSObject

@property (nonatomic) NSUInteger X;
@property (nonatomic) NSUInteger Y;

- (id) initWithXValue: (NSUInteger) X andYValue: (NSUInteger) Y;
- (id) init;
@end
