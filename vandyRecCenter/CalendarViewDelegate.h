//
//  CalendarViewDelegate.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/27/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CalendarViewDelegate <NSObject>

@optional
- (void) calendarChangeToYear: (NSUInteger) year month: (NSUInteger) month;

//should implement one of the following, depending on whichever
//form of the current date you want
//DON'T USE BOTH
- (void) didSelectDateForYear: (NSUInteger) year month: (NSUInteger) month day: (NSUInteger) day;
- (void) didSelectDate: (NSDate*) selectedDate;
@end
