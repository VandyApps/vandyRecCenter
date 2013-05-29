//
//  DateHelper.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

+ (NSString*) monthNameForIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return @"January";
        case 1:
            return @"February";
        case 2:
            return @"March";
        case 3:
            return @"April";
        case 4:
            return @"May";
        case 5:
            return @"June";
        case 6:
            return @"July";
        case 7:
            return @"August";
        case 8:
            return @"September";
        case 9:
            return @"October";
        case 10:
            return @"November";
        case 11:
            return @"December";
            
        default:
            return nil;
    }
}

+ (NSString*) weekDayForIndex:(NSUInteger)index {
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

+ (NSString*) weekAbbreviationForIndex:(NSUInteger)index {
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

+ (NSUInteger) daysInMonth:(NSUInteger)month year: (NSUInteger) year {
    switch (month) {
        case 0:
        case 2:
        case 4:
        case 7:
        case 9:
        case 11:
            return 31;
        case 3:
        case 5:
        case 6:
        case 8:
        case 10:
            return 30;
        case 1:
            return (year % 4 ==0) ? 29 : 28;
            
        default:
            return nil;
    }
}

@end
