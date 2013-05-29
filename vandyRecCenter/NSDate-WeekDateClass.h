//contains extension to the NSDate class that allow for methods having to do with the days of the week


#import <Foundation/Foundation.h>


@interface NSDate(WeekDateClass)



- (NSString*) dayOfTheWeekAsString;
- (NSString*) dayOfTheWeekAsStringWithTimeZone: (NSTimeZone*) timeZone;

+ (NSString*) dayOfTheWeekAbreviationForIndex: (NSUInteger) index;
+ (NSString*) dayOfTheWeekForIndex: (NSInteger) index;



+ (NSString*) currentDayOfTheWeekAsString;
+ (NSString*) currentDayOfTheWeekAsStringWithTimeZone: (NSTimeZone*) timeZone;

@end
