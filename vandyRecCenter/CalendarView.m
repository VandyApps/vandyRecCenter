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
@synthesize dayButtons = _dayButtons;
#pragma mark - Getters

- (NSDate*) selectedDate {
    for (DayButton* button in self.dayButtons) {
        if (button.selected) {
            return button.date;
        }
    }
    return nil;
}

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.month = [[[NSDate alloc] init] month];
        self.year = [[[NSDate alloc] init] year];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self.month = [[[NSDate alloc] init] month];
        self.year = [[[NSDate alloc] init] year];
    }
    return self;
}

#pragma mark - Lifecycle


- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self setUpScrollViewWithSelectedDay: 1];
    [self addMonthButtons];
    
}

#pragma mark - Calandar setters
- (void) selectCurrentCalendar {
    [self.calendarScroll setContentOffset: CGPointZero animated: YES];
    NSDate * currentDate = [[NSDate alloc] init];
    self.year = [currentDate year];
    self.month = [currentDate month];
    [self setUpScrollViewWithSelectedDay: [currentDate day]];
    [self.calendarDelegate calendarChangeToYear: self.year month: self.month];
}

- (void) selectYear:(NSUInteger)year month:(NSUInteger)month {
    [self.calendarScroll setContentOffset: CGPointZero animated: YES];
    self.year = year;
    self.month = month;
    [self setUpScrollViewWithSelectedDay: 1];
    if ([self.calendarDelegate respondsToSelector: @selector(calendarChangeToYear:month:)]) {
        [self.calendarDelegate calendarChangeToYear:self.year month: self.month];
    }
   
}

#pragma mark - View Setup

- (void) setUpScrollViewWithSelectedDay: (NSUInteger) selectedDay {
    if (self.calendarScroll != nil) {
        [self.calendarScroll removeFromSuperview];
    }
    
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {

        self.calendarScroll = [[UIScrollView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT) / 2.0, 0, DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT, self.frame.size.height)];
        
        
    } else {
        self.calendarScroll = [[UIScrollView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE) / 2.0, 0, DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE, self.frame.size.height)];
    }
    self.calendarScroll.delegate = self;
    self.calendarScroll.showsHorizontalScrollIndicator = NO;
    
    self.calendarScroll.backgroundColor = [UIColor blackColor];
    [self addSubview: self.calendarScroll];
    [self addCalendarWithSelectedDay: selectedDay];
    
}

- (void) addCalendarWithSelectedDay: (NSUInteger) selectedDay {
    self.dayButtons = [[NSArray alloc] init];
    NSDate *date = [NSDate dateWithYear: self.year month: self.month andDay: 1];
    
    while ([date month] == self.month) {
        
        DayButton* button = [[DayButton alloc] initWithDate: date andPadding: 0];
        //add day
        
        //default is NO, do not need to explicitly
        //set a selected value of NO
        if (button.day == selectedDay) {
            button.selected = YES;
        }
        
        [button addTarget: self action: @selector(daySelected:) forControlEvents: UIControlEventTouchUpInside];
        
        self.dayButtons = [self.dayButtons arrayByAddingObject: button];
        [self.calendarScroll addSubview: button];
        date = [date dateByAddingTimeInterval: 24 * 60 * 60];
    }
    self.calendarScroll.contentSize = CGSizeMake(([DateHelper daysForMonth: self.month year: self.year] * (DEFAULT_CONTROL_WIDTH+ DAY_PADDING)) + BUTTON_PADDING, self.calendarScroll.frame.size.height);
    
}

- (void) addMonthButtons {
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame: CGRectMake(BUTTON_PADDING, (self.frame.size.height - 6) / 2.0, MINUS_BUTTON_WIDTH, MINUS_BUTTON_HEIGHT)];
    [leftButton setBackgroundImage: [UIImage imageNamed: @"45-minus.png"] forState: UIControlStateNormal];
    [leftButton addTarget: self action: @selector(decrementMonth) forControlEvents: UIControlEventTouchUpInside];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame: CGRectMake(self.frame.size.width - BUTTON_PADDING - PLUS_BUTTON_DIMENSIONS, (self.frame.size.height - PLUS_BUTTON_DIMENSIONS) / 2.0, PLUS_BUTTON_DIMENSIONS, PLUS_BUTTON_DIMENSIONS)];
    [rightButton setBackgroundImage:[UIImage imageNamed: @"50-plus.png"] forState: UIControlStateNormal];
    [rightButton addTarget: self action: @selector(incrementMonth) forControlEvents: UIControlEventTouchUpInside];
    
    [self addSubview: leftButton];
    [self addSubview: rightButton];
}

#pragma mark - Events

- (void) daySelected: (DayButton*) sender {
    for (DayButton* button in self.dayButtons) {
        if (button.day != sender.day) {
            button.selected = NO;
        }
    }
    
    if ([self.calendarDelegate respondsToSelector: @selector(didSelectDate:)]) {
        
        [self.calendarDelegate didSelectDate: sender.date];
    } else if ([self.calendarDelegate respondsToSelector: @selector(didSelectDateForYear:month:day:)]) {
        
        [self.calendarDelegate didSelectDateForYear: self.year month: self.month day: sender.day];
    }
    
}

- (void) incrementMonth {
    [self.calendarScroll setContentOffset: CGPointZero animated: YES];
    self.month += 1;
    if (self.month > 11) {
        self.month = 0;
        self.year += 1;
    }
    
    [self setUpScrollViewWithSelectedDay: 1];
    if ([self.calendarDelegate respondsToSelector: @selector(calendarChangeToYear:month:)]) {
        [self.calendarDelegate calendarChangeToYear: self.year month: self.month];
    }
   
    
}

- (void) decrementMonth {
    [self.calendarScroll setContentOffset: CGPointZero animated: YES];
    self.month -= 1;
    if (self.month < 0) {
        self.month = 11;
        self.year -= 1;
    }
    
    [self setUpScrollViewWithSelectedDay: 1];
    if ([self.calendarDelegate respondsToSelector: @selector(calendarChangeToYear:month:)]) {
        [self.calendarDelegate calendarChangeToYear: self.year month: self.month];
    }
    
}



@end
