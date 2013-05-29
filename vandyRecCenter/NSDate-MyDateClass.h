//contains general extension to the NSDate class

#import <Foundation/Foundation.h>

@interface NSDate(MyDateClass)

//make this negative to subtract time
+ (NSDate*) dateByAddingTimeCurrentTime: (NSTimeInterval) addedTime;

+ (NSDate*) dateWithYear: (NSUInteger) year month: (NSUInteger) month andDay: (NSUInteger) day;

- (NSDate*) dateBySettingTimeToTime: (NSString*) time; //accepts string in format: 12:00am or 12:00 AM

//getters for the day, month, and year
- (NSUInteger) day;
//this is 0-based, so January is 0, December is 11
- (NSUInteger) month;
- (NSUInteger) year;
- (NSUInteger) weekDay;

- (NSUInteger) dayForAdjustedTimeZone: (NSTimeZone*) timeZone;
- (NSUInteger) monthForAdjustedTimeZone: (NSTimeZone*) timeZone;
- (NSUInteger) yearForAdjustedTimeZone: (NSTimeZone*) timeZone;
- (NSUInteger) weekDayForAdjustedTimeZone: (NSTimeZone*) timeZone;


@end
