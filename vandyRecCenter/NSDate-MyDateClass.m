//
//  NSDate-MyDateClass.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "NSDate-MyDateClass.h"

@implementation NSDate(MyDateClass)

+ (NSDate*) dateByAddingTimeCurrentTime:(NSTimeInterval)addedTime {
    NSDate* currentDate = [[NSDate alloc] init];
    return [currentDate dateByAddingTimeInterval: addedTime];
}

- (NSUInteger) dayOfTheWeekAsInt {
    
    //January, 1970 was a Thursday, so add 4
    //represent Sunday as 0 and Saturday as 6
    NSUInteger secondsSince1970 = (NSUInteger) [self timeIntervalSince1970];
    NSUInteger daysSince1970 = secondsSince1970 / (60 * 60 * 24);
    NSUInteger dayOfWeek =  (4 + daysSince1970) % 7;
    return dayOfWeek;
}

- (NSString*) dayOfTheWeekAsString {
    
    return [NSDate dayOfTheWeekForIndex: [self dayOfTheWeekAsInt]];
}

- (NSDate*) dateBySettingTimeToTime:(NSString *)time {
    
    //get seconds
    NSUInteger currentTime = (int) [self timeIntervalSince1970];
    
    //remove any seconds that are carried over by the day
    NSUInteger newInterval = currentTime - (currentTime% (60*60*24));
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSince1970: newInterval];
    newDate = [newDate dateByAddingTimeInterval: [NSDate timeInMinutes: time] * 60];
    return newDate;
}

//index-based retrieval of the day of the week as a string
//0 is Sunday and 6 is Saturday, other days fall in between
//used to help simplify iterations through arrays and other
//index-based data structures that need days of week
+ (NSString*) dayOfTheWeekForIndex: (NSInteger) index {

    switch (index) {
        case 0:
            return @"Sunday";
        case 1:
            return @"Monday";
        case 2:
            return @"Tuesday";
        case 3:
            return @"Wednesday";
        case 4:
            return @"Thursday";
        case 5:
            return @"Friday";
        case 6: 
            return @"Saturday";
        default:
            return nil;
    }
}

+ (NSUInteger) currentDayOfTheWeekAsInt {
    NSDate* currentDate = [[NSDate alloc] init];
    return [currentDate dayOfTheWeekAsInt];
}
+ (NSString*) currentDayOfTheWeekAsString {
    return [NSDate dayOfTheWeekForIndex: [NSDate currentDayOfTheWeekAsInt]];
}

+ (NSComparisonResult) compareTime:(NSString *)time1 withTime:(NSString *)time2 {
    //convert to military time in minutes for ease of comparison
    NSUInteger time1InMinutes = [NSDate timeInMinutes: time1];
    NSUInteger time2InMinutes = [NSDate timeInMinutes: time2];
    
    if (time1InMinutes > time2InMinutes) {
        return NSOrderedDescending;
    } else if (time1InMinutes < time2InMinutes) {
        return NSOrderedAscending;
    } else {
        return NSOrderedSame;
    }
    
    
}

//private methods here
+ (NSUInteger) timeInMinutes: (NSString*) time { //time must be in format 12:00am
   
    NSUInteger timeInHours;
    NSUInteger timeInMinutes;
    BOOL isPM = NO;
    if ([[[time substringFromIndex: ([time length] - 2) ] lowercaseString] isEqualToString: @"pm"]) {
        isPM = YES;
    }
    for (size_t i = 0; i < [time length]; ++i) {
        if ([time characterAtIndex: i] == ':') {
            timeInHours = (NSUInteger) [[time substringWithRange: NSMakeRange(0, i)] intValue];
            timeInMinutes = (NSUInteger)[ [time substringWithRange:NSMakeRange(i+1, 2)] intValue];
        }
    }
   // NSLog(@"Time in hours is %u, time in minutes is %u, and isPM is %i", timeInHours, timeInMinutes, isPM);
    
    NSUInteger totalMinutes = 60 * timeInHours + timeInMinutes;
    totalMinutes += (isPM && timeInHours != 12) ? (12*60) : 0;
    return totalMinutes;
}
@end
