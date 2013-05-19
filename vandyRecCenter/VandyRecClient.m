//
//  VandyRecClient.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/19/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "VandyRecClient.h"

@implementation VandyRecClient

- (id) init {
    self = [super initWithBaseURL: [NSURL URLWithString: BASE_URL]];
    return self;
}

- (void) JSONFromNewsTab:(void (^)(NSError *, NSArray *))block {
    NSLog(@"JSON method was called");
    NSURLRequest *newsRequest = [self requestWithMethod: @"GET" path: @"news" parameters:nil];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest: newsRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Success");
        block(nil, JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failure");
        block(error, JSON);
    }];
    
    [operation start];
}
@end
