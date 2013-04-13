//contains extension to the NSDate class that allow for methods having to do with the days of the week


#import <Foundation/Foundation.h>

@interface NSDate(WeekDateClass)

- (NSUInteger) dayOfTheWeekAsInt;
- (NSString*) dayOfTheWeekAsString;

+ (NSString*) dayOfTheWeekAbreviationForIndex: (NSUInteger) index;
+ (NSString*) dayOfTheWeekForIndex: (NSInteger) index;
+ (NSUInteger) currentDayOfTheWeekAsInt;
+ (NSString*) currentDayOfTheWeekAsString;

@end
