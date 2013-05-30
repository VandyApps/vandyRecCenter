//
//  GFFavorites.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeString.h"

@interface GFFavorites : NSObject

@property (nonatomic, strong) NSArray* favorites;

- (void) add: (NSDictionary*) GFClass;
- (void) removeGFClassWithID: (NSString*) ID;
- (NSDictionary*) GFClassWithID: (NSString*) ID;
//sorts the elements in the list of favorites
//the GFClasses are sorted so that those with earlier
//starting dates come first
//if two elements have the same starting date
//then they are sorted based on the times the classes start
- (void) sort;

//determines if the dictionary already exists in the
//list of favorites
- (BOOL) isFavorite: (NSDictionary*) GFClass;
@end
