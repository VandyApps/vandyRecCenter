//
//  CalendarView.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/27/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarViewDelegate.h"

#define DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT 250
#define DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE 300
@interface CalendarView : UIView

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

- (void) incrementMonth;
- (void) decrementMonth;

- (void) selectYear: (NSUInteger) year month: (NSUInteger) month;
- (void) selectCurrentCalendar;
@end
