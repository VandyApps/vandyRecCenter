//
//  NSDate-MyDateClass.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "NSDate-MyDateClass.h"

@implementation NSDate(MyDateClass)

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
            return @"Tueday";
        case 3:
            return @"Wednesday";
        case 4:
            return @"Thursday";
        case 5:
            return @"Friday";
        default: //when the value is 6
            return @"Saturday";
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
