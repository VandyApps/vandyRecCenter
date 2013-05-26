//
//  VandyRecClient.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/19/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface VandyRecClient : AFHTTPClient

#define BASE_URL @"http://vandyrec.herokuapp.com/JSON/"

//initializes with a predefined base url
//default initializer
- (id) init;

//needs callback block to manage data that has been retrieved from the page
//can return an error if either the page could not be reached or something
//else has happenned
- (void) JSONFromNewsTab: (void (^)(NSError* error, NSArray* jsonData)) block;

- (void) JSONFromGFTab: (void (^)(NSError* error, NSArray* jsonData)) block;
- (void) JSONFromGFTab:(void (^)(NSError *error, NSArray *jsonData))block forMonth: (NSUInteger) monthIndex andYear: (NSUInteger) year;

@end
