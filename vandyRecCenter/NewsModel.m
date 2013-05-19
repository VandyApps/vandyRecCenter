//
//  NewsModel.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/19/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "NewsModel.h"


@implementation NewsModel

@synthesize news = _news;

#pragma - getter

- (NSArray*) news {
    if (_news == nil) {
        _news = [[NSArray alloc] init];
    }
    return _news;
}

#pragma - initializer
- (id) init {
    NSLog(@"Initializer was called");
    self = [super init];
    if (self) {
        
        VandyRecClient* webClient = [[VandyRecClient alloc] init];
        
        [webClient JSONFromNewsTab:^(NSError *error, NSArray *jsonData) {
            if (error) {
                NSLog(@"There was an error");
            } else {
                for (NSDictionary* event in jsonData) {
                    self.news = [self.news arrayByAddingObject: [event objectForKey: @"description" ]];
                }
            }
        }];
        
    }
    return self;
}
@end
