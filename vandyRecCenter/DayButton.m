//
//  DayButton.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/27/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "DayButton.h"

@implementation DayButton

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
    self = [self initWithFrame: CGRectMake(buttonPadding + ((buttonPadding+DEFAULT_WIDTH)*dayIndex), 0, DEFAULT_WIDTH, DEFAULT_HEIGHT)];
    if (self) {
        
    }
    return self;
}

- (void) layoutSubviews {
    self.backgroundColor = [UIColor clearColor];
    [self addView];
}

- (void) addView {
    UIView* view = [[UIView alloc] initWithFrame: CGRectMake((self.frame.size.width - DEFAULT_DAY_WIDTH) / 2.0, (self.frame.size.height - DEFAULT_DAY_HEIGHT) / 2.0, DEFAULT_DAY_WIDTH, DEFAULT_DAY_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [[UIColor vanderbiltGold] CGColor];
    view.layer.borderWidth = BORDER_WIDTH;
    view.layer.cornerRadius = CORNER_RADIUS;
    
    UILabel *weekDay = [[UILabel alloc] initWithFrame: CGRectMake(SUBVIEW_PADDING, SUBVIEW_PADDING, view.frame.size.width - 2* SUBVIEW_PADDING, 20)];
    weekDay.text = @"Monday";
    weekDay.font = [UIFont fontWithName: @"TrebuchetMS" size: 12];
    weekDay.textAlignment = NSTextAlignmentCenter;
    

    UILabel *dayLabel = [[UILabel alloc] initWithFrame: CGRectMake( (view.frame.size.width - DAY_LABEL_WIDTH) / 2.0, (view.frame.size.height - DAY_LABEL_HEIGHT) / 2.0, DAY_LABEL_WIDTH, DAY_LABEL_HEIGHT)];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.text = @"12";
    dayLabel.font = [UIFont fontWithName: @"TrebuchetMS-Bold" size: 30];
   
    
       
    UILabel *yearLabel = [[UILabel alloc] initWithFrame: CGRectMake( SUBVIEW_PADDING, view.frame.size.height - 20 - SUBVIEW_PADDING, view.frame.size.width - 2 * SUBVIEW_PADDING,  YEAR_LABEL_HEIGHT)];
    yearLabel.text = @"2013";
    yearLabel.font = [UIFont fontWithName: @"TrebuchetMS" size: 10];
    yearLabel.textAlignment = NSTextAlignmentCenter;
   
    
    [view addSubview: weekDay];
    [view addSubview: dayLabel];
    [view addSubview: yearLabel];
    
    [self addSubview: view];
    
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
