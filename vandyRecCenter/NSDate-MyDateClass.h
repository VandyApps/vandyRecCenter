//contains general extension to the NSDate class

#import <Foundation/Foundation.h>

@interface NSDate(MyDateClass)

//make this negative to subtract time
+ (NSDate*) dateByAddingTimeCurrentTime: (NSTimeInterval) addedTime;

+ (NSComparisonResult) compareTime: (NSString*) time1 withTime: (NSString*) time2;

+ (NSDate*) dateWithYear: (NSUInteger) year month: (NSUInteger) month andDay: (NSUInteger) day;

- (NSDate*) dateBySettingTimeToTime: (NSString*) time; //accepts string in format: 12:00am or 12:00 AM

- (NSUInteger) day;
- (NSUInteger) month;
- (NSUInteger) year;



@end
