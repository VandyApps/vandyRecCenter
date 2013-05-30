//
//  GFFavorites.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFFavorites.h"

@implementation GFFavorites

@synthesize favorites = _favorites;

- (void) add:(NSDictionary *)GFClass {
    
}

- (void) removeGFClassWithID:(NSString *)ID {
    
}

- (void) sort {
    self.favorites = [self.favorites sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* startDate1 = [obj1 objectForKey: @"startDate"];
        NSString* startDate2 = [obj2 objectForKey: @"startDate"];
        NSArray* dateArray1 = [startDate1 componentsSeparatedByString: @"/"];
        NSArray* dateArray2 = [startDate2 componentsSeparatedByString: @"/"];
        if ([[dateArray1 objectAtIndex: 2] intValue] < [[dateArray2 objectAtIndex: 2] intValue]) {
            return NSOrderedAscending;
        } else if ([[dateArray1 objectAtIndex: 2] intValue] > [[dateArray2 objectAtIndex: 2] intValue]) {
            return NSOrderedDescending;
        } else {
            //same year
            NSString* time1 = [obj1 objectForKey: @"timeRange"];
            NSString* startTime1 = [[time1 componentsSeparatedByString: @" - "] objectAtIndex:0];
            
            NSString* time2 = [obj2 objectForKey: @"timeRange"];
            NSString* startTime2 = [[time2 componentsSeparatedByString: @" - "] objectAtIndex:0];
            TimeString* timeString1 = [[TimeString alloc] initWithString:  startTime1];
            TimeString* timeString2 = [[TimeString alloc] initWithString: startTime2];
            return [TimeString compareTimeString1: timeString1 timeString2: timeString2];
        }
    }];
}

- (BOOL) isFavorite:(NSDictionary *)GFClass {
    for (NSDictionary* favClass in self.favorites) {
        if ([[GFClass objectForKey: @"_id"] isEqualToString: [favClass objectForKey: @"_id"]]) {
            return YES;
        }
    }
    return NO;
}
@end
