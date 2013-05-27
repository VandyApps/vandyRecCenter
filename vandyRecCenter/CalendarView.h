//
//  CalendarView.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/27/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarViewDelegate.h"

@interface CalendarView : UIView

@property (nonatomic, weak) id<CalendarViewDelegate> calendarDelegate;

@property (nonatomic, strong) UIScrollView *calendarScroll;
@property (nonatomic, strong) UIButton *decrementButton;
@property (nonatomic, strong) UIButton *incrementButton;

@property (nonatomic) NSUInteger month;
@property (nonatomic) NSUInteger year;
@property (nonatomic, strong) NSDate* selectedDate;

- (void) incrementMonth;
- (void) decrementMonth;

- (void) selectYear: (NSUInteger) year month: (NSUInteger) month;
@end
