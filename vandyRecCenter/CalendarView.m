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
    
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {

        self.calendarScroll = [[UIScrollView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT) / 2.0, 0, DEFAULT_CAL_SCROLL_WIDTH_PORTRAIT, self.frame.size.height)];
        
    } else {
        self.calendarScroll = [[UIScrollView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE) / 2.0, 0, DEFAULT_CAL_SCROLL_WIDTH_LANDSCAPE, self.frame.size.height)];
    }
    self.calendarScroll.backgroundColor = [UIColor blackColor];
    
    NSDate *date = [NSDate dateWithYear: 2013 month: 4 andDay: 1];
    while ([date month] != 5) {
        DayButton* button = [[DayButton alloc] initWithDate: date andPadding: 0];
        date = [date dateByAddingTimeInterval: 24 * 60 * 60];
        [self.calendarScroll addSubview: button];
    }
    self.calendarScroll.contentSize = CGSizeMake((31 * (80+0)) + 0, self.calendarScroll.frame.size.height);
    [self addSubview: self.calendarScroll];
}

- (void) addButtons {
    UIButton *leftButton = [[UIButton alloc] initWithFrame: CGRectMake(BUTTON_PADDING, (self.frame.size.height - 6) / 2.0, MINUS_BUTTON_WIDTH, MINUS_BUTTON_HEIGHT)];
    [leftButton setBackgroundImage: [UIImage imageNamed: @"45-minus.png"] forState: UIControlStateNormal];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame: CGRectMake(self.frame.size.width - BUTTON_PADDING - PLUS_BUTTON_DIMENSIONS, (self.frame.size.height - PLUS_BUTTON_DIMENSIONS) / 2.0, PLUS_BUTTON_DIMENSIONS, PLUS_BUTTON_DIMENSIONS)];
    [rightButton setBackgroundImage:[UIImage imageNamed: @"50-plus.png"] forState: UIControlStateNormal];
    
    [self addSubview: leftButton];
    [self addSubview: rightButton];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self setUpScrollView];
    [self addButtons];
    
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
