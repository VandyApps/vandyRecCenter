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
    self.favorites = [self.favorites arrayByAddingObject: GFClass];
    [self sort];
}

- (void) removeGFClassWithID:(NSString *)ID {
    for (NSUInteger i = 0; i < self.favorites.count; ++i) {
        if ([[[self.favorites objectAtIndex: i] objectForKey: @"_id"] isEqualToString: ID]) {
            if (i == 0) {
                self.favorites = [self.favorites subarrayWithRange: NSMakeRange(1, self.favorites.count - 1)];
            } else if (i == self.favorites.count - 1) {
                self.favorites = [self.favorites subarrayWithRange: NSMakeRange(0, self.favorites.count - 1)];
            } else {
                NSArray* partial1 = [self.favorites subarrayWithRange: NSMakeRange(0, i)];
                NSArray* partial2 = [self.favorites subarrayWithRange: NSMakeRange(i+1, self.favorites.count - i - 1)];
                self.favorites = partial1;
                self.favorites = [self.favorites arrayByAddingObjectsFromArray: partial2];
            }
        }
    }
}

- (NSDictionary*) GFClassWithID: (NSString*) ID {
    for (NSDictionary* GFClass in self.favorites) {
        if ([[GFClass objectForKey: @"_id"] isEqualToString: ID]) {
            return GFClass;
        }
    }
    return nil;
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
