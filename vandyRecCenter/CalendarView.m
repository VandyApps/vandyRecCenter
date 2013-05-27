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

#pragma mark - Getters

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
    NSLog(@"Setting up scroll view");
    
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        NSLog(@"In portrait height of self is %g", self.frame.size.height);
        self.calendarScroll = [[UIScrollView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT) / 2.0, 0, DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT, self.frame.size.height)];
        
    } else {
        NSLog(@"In landscape");
        self.calendarScroll = [[UIScrollView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE) / 2.0, 0, DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE, self.frame.size.height)];
    }
    self.calendarScroll.backgroundColor = [UIColor blackColor];
    [self addSubview: self.calendarScroll];
    for (size_t i = 0; i < 10; ++i) {
        [self addCalendarElementAtIndex: i withDay: 0 andWeekDay: 0];
    }
}

- (void) addCalendarElementAtIndex: (NSUInteger) index withDay: (NSUInteger) day andWeekDay: (NSUInteger) weekDay {
    CGFloat calWidth = 60;
    CGFloat calHeight = 80;
    CGFloat calPadding = 10;
    UIView* calDay = [[UIView alloc] initWithFrame: CGRectMake(calPadding + (calWidth + calPadding) * index, (self.calendarScroll.frame.size.height - calHeight) / 2.0, calWidth, calHeight)];
    calDay.backgroundColor = [UIColor whiteColor];
    [self.calendarScroll addSubview: calDay];
    self.calendarScroll.contentSize = CGSizeMake(calPadding + (calWidth + calPadding) * (index + 1), self.calendarScroll.frame.size.height);
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
