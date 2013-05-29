//
//  CalendarView.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/27/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarViewDelegate.h"
#import "DayButton.h"

#define DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT 230
#define DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE 300

#define BUTTON_PADDING 15
#define DAY_PADDING 0
#define PLUS_BUTTON_DIMENSIONS 15
#define MINUS_BUTTON_WIDTH 15
#define MINUS_BUTTON_HEIGHT 6


@interface CalendarView : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) id<CalendarViewDelegate> calendarDelegate;

@property (nonatomic, strong) UIScrollView *calendarScroll;
@property (nonatomic, strong) UIButton *decrementButton;
@property (nonatomic, strong) UIButton *incrementButton;

@property (nonatomic) NSUInteger month;
@property (nonatomic) NSUInteger year;
@property (nonatomic, strong) NSDate* selectedDate;

//properties related to element locations and size
@property (nonatomic) CGFloat pagePaddingVertical;
@property (nonatomic) CGFloat pagePaddingHorizontal;

@property (nonatomic, strong) NSArray* dayButtons;

- (void) incrementMonth;
- (void) decrementMonth;

- (void) selectYear: (NSUInteger) year month: (NSUInteger) month;
- (void) selectCurrentCalendar;
@end
