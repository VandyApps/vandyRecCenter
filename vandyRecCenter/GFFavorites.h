//
//  GFFavorites.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFFavorites : NSObject

@property (nonatomic, strong) NSArray* favorites;

- (void) add: (NSDictionary*) GFClass;
- (void) removeGFClassWithID: (NSString*) ID;

//sorts the elements in the list of favorites
- (void) sort;

//determines if the dictionary already exists in the
//list of favorites
- (BOOL) isFavorite: (NSDictionary*) GFClass;
@end
