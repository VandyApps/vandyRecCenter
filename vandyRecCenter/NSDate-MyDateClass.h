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

+ (NSString*) dayOfTheWeekForIndex: (NSInteger) index;
+ (NSUInteger) currentDayOfTheWeekAsInt;
+ (NSString*) currentDayOfTheWeekAsString;
+ (NSComparisonResult) compareTime: (NSString*) time1 withTime: (NSString*) time2;


- (NSUInteger) dayOfTheWeekAsInt;
- (NSString*) dayOfTheWeekAsString;




@end
