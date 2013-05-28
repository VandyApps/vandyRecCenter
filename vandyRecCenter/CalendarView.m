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
    
    [self setUpScrollView];
    [self addButtons];
    
}



#pragma mark - View Setup

- (void) setUpScrollView {
    if (self.calendarScroll != nil) {
        [self.calendarScroll removeFromSuperview];
    }
    
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {

        self.calendarScroll = [[UIScrollView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT) / 2.0, 0, DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT, self.frame.size.height)];
        
    } else {
        self.calendarScroll = [[UIScrollView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE) / 2.0, 0, DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE, self.frame.size.height)];
    }
    self.calendarScroll.backgroundColor = [UIColor blackColor];
    [self addSubview: self.calendarScroll];
    [self addCalendar];
    
}

- (void) addCalendar {
    self.dayButtons = [[NSArray alloc] init];
    NSDate *date = [NSDate dateWithYear: self.year month: self.month andDay: 1];
    while ([date month] != 5) {
        DayButton* button = [[DayButton alloc] initWithDate: date andPadding: 0];
        //add day
        
        [button addTarget: self action: @selector(clicked:) forControlEvents: UIControlEventTouchUpInside];
        date = [date dateByAddingTimeInterval: 24 * 60 * 60];
        self.dayButtons = [self.dayButtons arrayByAddingObject: button];
        [self.calendarScroll addSubview: button];
    }
    self.calendarScroll.contentSize = CGSizeMake(([self daysForMonth: self.month year: self.year] * (DEFAULT_CONTROL_WIDTH+ DAY_PADDING)) + BUTTON_PADDING, self.calendarScroll.frame.size.height);
    
}

- (void) addButtons {
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame: CGRectMake(BUTTON_PADDING, (self.frame.size.height - 6) / 2.0, MINUS_BUTTON_WIDTH, MINUS_BUTTON_HEIGHT)];
    [leftButton setBackgroundImage: [UIImage imageNamed: @"45-minus.png"] forState: UIControlStateNormal];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame: CGRectMake(self.frame.size.width - BUTTON_PADDING - PLUS_BUTTON_DIMENSIONS, (self.frame.size.height - PLUS_BUTTON_DIMENSIONS) / 2.0, PLUS_BUTTON_DIMENSIONS, PLUS_BUTTON_DIMENSIONS)];
    [rightButton setBackgroundImage:[UIImage imageNamed: @"50-plus.png"] forState: UIControlStateNormal];
    
    [self addSubview: leftButton];
    [self addSubview: rightButton];
}

#pragma mark - Events

- (void) clicked: (DayButton*) sender {
    NSLog(@"%@", sender.date);
}
 
#pragma mark - Helpers 

- (NSUInteger) daysForMonth: (NSUInteger) month year: (NSUInteger) year {
    switch (month) {
        case 0:
        case 2:
        case 4:
        case 7:
        case 9:
        case 11:
            return 31;
        case 3:
        case 5:
        case 6:
        case 8:
        case 10:
            return 30;
        default:
            if (year % 4 == 0) {
                return 29;
            } else {
                return 28;
            }
    }
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
