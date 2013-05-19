//
//  VandyRecClient.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/19/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "AFHTTPClient.h"

@interface VandyRecClient : AFHTTPClient

#define BASE_URL @"http://vandyrec.herokuapp.com/JSON/"

//initializes with a predefined base url
//default initializer
- (id) init;

//needs callback block to manage data that has been retrieved from the page
//can return an error if either the page could not be reached or something
//else has happenned
- (void) getJSONFromNewsTab: (void (^)(NSError* error, NSData* jsonData)) block;
@end
