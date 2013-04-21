//
//  NSDate-WeekDateClass.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/13/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "NSDate-WeekDateClass.h"

@implementation NSDate(WeekDateClass)


- (NSUInteger) dayOfTheWeekAsInt {
    
    //January, 1970 was a Thursday, so add 4
    //represent Sunday as 0 and Saturday as 6
    
    NSUInteger secondsSince1970 = (NSUInteger) [self timeIntervalSince1970];
    NSUInteger daysSince1970 = secondsSince1970/ (60 * 60 * 24);
    NSUInteger dayOfWeek =  (4 + daysSince1970) % 7;
    
    return dayOfWeek;
}

- (NSUInteger) dayOfTheWeekAsIntWithinTimeZone:(NSTimeZone *)timeZone {
    NSDate *adjustedDate = [[NSDate alloc] initWithTimeIntervalSinceNow: [timeZone secondsFromGMT]];
    return [adjustedDate dayOfTheWeekAsInt];
}

- (NSString*) dayOfTheWeekAsString {
    
    return [NSDate dayOfTheWeekForIndex: [self dayOfTheWeekAsInt]];
}

- (NSString*) dayOfTheWeekAsStringWithinTimeZone:(NSTimeZone *)timeZone {
    NSUInteger indexOfDayOfWeek = [self dayOfTheWeekAsIntWithinTimeZone: timeZone];
    return [NSDate dayOfTheWeekForIndex: indexOfDayOfWeek];
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
+ (NSString*) dayOfTheWeekAbreviationForIndex: (NSUInteger) index {
    switch (index) {
        case 0:
            return @"Sun";
        case 1:
            return @"Mon";
        case 2:
            return @"Tues";
        case 3:
            return @"Wed";
        case 4:
            return @"Thurs";
        case 5:
            return @"Fri";
        case 6:
            return @"Sat";
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


@end
