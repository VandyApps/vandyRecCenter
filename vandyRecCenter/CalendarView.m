//
//  CalendarView.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/27/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView

#pragma mark - Properties
@synthesize calendarDelegate = _calendarDelegate;
@synthesize calendarScroll = _calendarScroll;
@synthesize decrementButton = _decrementButton;
@synthesize incrementButton = _incrementButton;
@synthesize month = _month;
@synthesize year = _year;
@synthesize selectedDate = _selectedDate;
@synthesize dayWidth = _dayWidth;
@synthesize dayPadding = _dayPadding;
@synthesize dayHeight = _dayHeight;

#pragma mark - Getters

- (CGFloat) dayWidth {
    if (_dayWidth == 0) {
        _dayWidth = DEFAULT_DAY_WIDTH;
    }
    return _dayWidth;
}

- (CGFloat) dayHeight {
    if (_dayHeight == 0) {
        _dayHeight = DEFAULT_DAY_HEIGHT;
    }
    return _dayHeight;
}

- (CGFloat) dayPadding {
    if (_dayPadding == 0) {
        _dayPadding = DEFAULT_DAY_PADDING;
    }
    return _dayPadding;
}

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        
    }
    return self;
}

#pragma mark - View Setup

- (void) setUpScrollView {
    
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {

        self.calendarScroll = [[UIScrollView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT) / 2.0, 0, DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT, self.frame.size.height)];
        
    } else {
        self.calendarScroll = [[UIScrollView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE) / 2.0, 0, DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE, self.frame.size.height)];
    }
    self.calendarScroll.backgroundColor = [UIColor blackColor];
    [self addSubview: self.calendarScroll];
    for (size_t i = 0; i < 10; ++i) {
        [self addCalendarElementAtIndex: i withDay: 0 andWeekDay: 0];
    }
}

- (void) addCalendarElementAtIndex: (NSUInteger) index withDay: (NSUInteger) day andWeekDay: (NSUInteger) weekDay {
    
    UIView* calDay = [[UIView alloc] initWithFrame: CGRectMake(self.dayPadding + (self.dayWidth + self.dayPadding) * index, (self.calendarScroll.frame.size.height - self.dayHeight) / 2.0, self.dayWidth, self.dayHeight)];
    calDay.backgroundColor = [UIColor whiteColor];
    [self.calendarScroll addSubview: calDay];
    self.calendarScroll.contentSize = CGSizeMake(self.dayPadding + (self.dayWidth + self.dayPadding) * (index + 1), self.calendarScroll.frame.size.height);
}
    

- (void) layoutSubviews {
    NSLog(@"Laying out subviews");
    [self setUpScrollView];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
