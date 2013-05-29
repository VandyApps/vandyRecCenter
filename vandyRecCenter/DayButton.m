//
//  DayButton.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/27/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "DayButton.h"

@implementation DayButton

@synthesize dayWidth = _dayWidth;
@synthesize dayHeight = _dayHeight;
@synthesize dayPadding = _dayPadding;

@synthesize date = _date;
@synthesize day = _day;
@synthesize month = _month;
@synthesize year = _year;
@synthesize weekDay = _weekDay;

@synthesize dayView = _dayView;
@synthesize weekDayLabel = _weekDayLabel;
@synthesize dayLabel = _dayLabel;
@synthesize yearLabel = _yearLabel;
@synthesize fraction = _fraction;


#pragma mark - Getters and Setters

- (void) setFraction:(CGFloat)fraction {
    _fraction = fraction;
    [self addView];
}

- (CGFloat) fraction {
    if (_fraction == 0) {
        _fraction = DAY_DIMENSIONS_FRACTION;
    }
    return _fraction;
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

- (id) initWithDate: (NSDate*) date andPadding: (CGFloat) buttonPadding {
    
    NSUInteger dayIndex = [date day] - 1;
    self = [self initWithFrame: CGRectMake(buttonPadding + ((buttonPadding+DEFAULT_CONTROL_WIDTH)*dayIndex), 0, DEFAULT_CONTROL_WIDTH, DEFAULT_CONTROL_HEIGHT)];
    if (self) {
        self.date = date;
        self.day = [date day];
        self.month = [date month];
        self.year = [date year];
        self.weekDay = [date weekDay];
        [self sendActionsForControlEvents: UIControlEventTouchUpInside];
       
    }
    return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    
    [self addView];
    
}

- (void) addView {
    
    if (self.dayView != nil) {
        [self.dayView removeFromSuperview];
    }
    
   
    CGFloat dayWidth = DEFAULT_CONTROL_WIDTH * self.fraction;
    CGFloat dayHeight = DEFAULT_CONTROL_HEIGHT * self.fraction;
        
    self.dayView = [[UIView alloc] initWithFrame: CGRectMake((self.frame.size.width - dayWidth) / 2.0, (self.frame.size.height - dayHeight) / 2.0, dayWidth, dayHeight)];
    self.dayView.backgroundColor = (self.selected) ? [UIColor whiteColor] : [UIColor colorWithRed: 220/255.0 green: 220/255.0 blue: 220/255.0 alpha: 1];
    self.dayView.layer.borderColor = [[UIColor vanderbiltGold] CGColor];
    self.dayView.layer.borderWidth = DAY_VIEW_BORDER_WIDTH * self.fraction;
    self.dayView.layer.cornerRadius = DAY_VIEW_CORNER_RADIUS;
    self.dayView.userInteractionEnabled = NO;
    
    self.weekDayLabel = [[UILabel alloc] initWithFrame: CGRectMake(SUBVIEW_PADDING, SUBVIEW_PADDING, self.dayView.frame.size.width - 2* SUBVIEW_PADDING, 20)];
    self.weekDayLabel .text = [DateHelper weekDayForIndex: [self.date weekDay]];
    self.weekDayLabel .font = [UIFont fontWithName: @"TrebuchetMS" size: WEEK_DAY_FONT_SIZE * self.fraction];
    self.weekDayLabel .textAlignment = NSTextAlignmentCenter;
    self.weekDayLabel .userInteractionEnabled = NO;
    self.weekDayLabel.backgroundColor = [UIColor clearColor];
    
    self.dayLabel = [[UILabel alloc] initWithFrame: CGRectMake( (self.dayView.frame.size.width - DAY_LABEL_WIDTH) / 2.0, (self.dayView.frame.size.height - DAY_LABEL_HEIGHT) / 2.0, DAY_LABEL_WIDTH, DAY_LABEL_HEIGHT)];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel.text = [NSString stringWithFormat: @"%i", self.day];
    self.dayLabel.font = [UIFont fontWithName: @"TrebuchetMS-Bold" size: DAY_FONT_SIZE * self.fraction];
    self.dayLabel.userInteractionEnabled = NO;
    self.dayLabel.backgroundColor = [UIColor clearColor];
       
    self.yearLabel = [[UILabel alloc] initWithFrame: CGRectMake( SUBVIEW_PADDING, self.dayView.frame.size.height - 20 - SUBVIEW_PADDING, self.dayView.frame.size.width - 2 * SUBVIEW_PADDING,  YEAR_LABEL_HEIGHT)];
    self.yearLabel.text = [NSString stringWithFormat: @"%i",self.year ];
    self.yearLabel.font = [UIFont fontWithName: @"TrebuchetMS" size: YEAR_LABEL_FONT_SIZE * self.fraction];
    self.yearLabel.textAlignment = NSTextAlignmentCenter;
    self.yearLabel.userInteractionEnabled = NO;
    self.yearLabel.backgroundColor = [UIColor clearColor];
    
    [self.dayView addSubview: self.weekDayLabel];
    [self.dayView addSubview: self.dayLabel];
    [self.dayView addSubview: self.yearLabel];
    
    [self addSubview: self.dayView];
    
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch: touch withEvent: event];
    [self setSelected: YES];
}
-(void) setSelected:(BOOL)selected {
    
    [super setSelected: selected];
    if (selected) {
        
        self.fraction = DAY_DIMENSIONS_SELECTED_FRACTION;
    } else {
        self.fraction = DAY_DIMENSIONS_FRACTION;
    }
    [self addView];
}



@end
