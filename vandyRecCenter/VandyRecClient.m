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
    NSURLRequest *newsRequest = [self requestWithMethod: @"GET" path: @"news" parameters:nil];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest: newsRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
       
        block(nil, JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        block(error, JSON);
    }];
    
    [operation start];
}

- (void) JSONFromGFTab: (void (^)(NSError *, NSArray *)) block {
    NSURLRequest *GFRequest = [self requestWithMethod: @"GET" path: @"GF" parameters: nil];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest: GFRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        
        block(nil, JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
       
        block(error, JSON);
    }];
    
    [operation start];
}

- (void) JSONFromGFTab: (void (^)(NSError *, NSArray *)) block forType: (NSString*) type month:(NSUInteger) monthIndex andYear: (NSUInteger) year {
    
    if ([type isEqualToString: @"GFClass"]) {
        
        NSDictionary *params = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: type, [NSNumber numberWithInt: monthIndex], [NSNumber numberWithInt: year], nil] forKeys: @[@"type", @"month", @"year"]];
        NSURLRequest *GFRequest = [self requestWithMethod: @"GET" path: @"GF" parameters: params];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest: GFRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            block(nil, JSON);
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            
            block(error, JSON);
        }];
        
        [operation start];
        
    } else if ([type isEqualToString: @"GFSpecialDate"]) {
       
        NSURLRequest *GFRequest = [self requestWithMethod: @"GET" path: @"GF" parameters:[[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: type, nil] forKeys:@[@"type"]]];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:GFRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            block(nil, JSON);
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            block(error,JSON);
        }];
        
        [operation start];
    } else {
        NSLog(@"Request did not send the correct type.  Need to present this in an error object");
        block(nil, nil);
    }
}
@end
