


#import "NSDate-MyDateClass.h"

@implementation NSDate(MyDateClass)

+ (NSDate*) dateByAddingTimeCurrentTime:(NSTimeInterval)addedTime {
    NSDate* currentDate = [[NSDate alloc] init];
    return [currentDate dateByAddingTimeInterval: addedTime];
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
//represents midnight as 24 hours instead of 0 hours
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
    totalMinutes += (!isPM && timeInHours == 12) ? (12*60): 0;
    totalMinutes += (isPM && timeInHours != 12) ? (12*60) : 0;
    return totalMinutes;
}
@end
