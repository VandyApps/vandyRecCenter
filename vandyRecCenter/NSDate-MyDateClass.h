//
//  NSDate-MyDateClass.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(MyDateClass)

//make this negative to subtract time
+ (NSDate*) dateByAddingTimeCurrentTime: (NSTimeInterval) addedTime;

+ (NSString*) weekDayAbreviationForIndex: (NSUInteger) index;
+ (NSString*) dayOfTheWeekForIndex: (NSInteger) index;
+ (NSUInteger) currentDayOfTheWeekAsInt;
+ (NSString*) currentDayOfTheWeekAsString;
+ (NSComparisonResult) compareTime: (NSString*) time1 withTime: (NSString*) time2;

- (NSDate*) dateBySettingTimeToTime: (NSString*) time; //accepts string in format: 12:00am or 12:00 AM
- (NSUInteger) dayOfTheWeekAsInt;
- (NSString*) dayOfTheWeekAsString;





@end
