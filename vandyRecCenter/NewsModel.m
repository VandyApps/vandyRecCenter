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
    
    self = [super init];
    if (self) {
        
                
    }
    return self;
}

- (void) loadData:(void (^)(NSError*))completion {
    VandyRecClient* webClient = [[VandyRecClient alloc] init];
    
    [webClient JSONFromNewsTab:^(NSError *error, NSArray *jsonData) {
        if (error) {
            completion(error);
        } else {
            
            //maje sure the data is in the correct order
            jsonData = [jsonData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSUInteger priority1 = [[obj1 objectForKey: @"priorityNumber"] intValue];
                NSUInteger priority2 = [[obj2 objectForKey: @"priorityNumber"] intValue];
                if (priority1 > priority2) {
                    return NSOrderedDescending;
                } else if (priority1 < priority2) {
                    return NSOrderedAscending;
                } else {
                    return NSOrderedSame;
                }
            }];
            
            
            for (NSDictionary* event in jsonData) {
                
                self.news = [self.news arrayByAddingObject: [event objectForKey: @"description" ]];
            }
            
            completion(nil);
        }
    }];

}
@end
