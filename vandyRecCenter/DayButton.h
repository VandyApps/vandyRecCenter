//
//  DayButton.h
//  
//
//  Created by Brendan McNamara on 5/27/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "UIColor-BMColors.h"
#import "NSDate-MyDateClass.h"
#import "NSDate-WeekDateClass.h"

@interface DayButton : UIControl

#define DEFAULT_CONTROL_HEIGHT 100
#define DEFAULT_CONTROL_WIDTH 75

#define DAY_DIMENSIONS_FRACTION .75
#define DAY_DIMENSIONS_SELECTED_FRACTION .95
#define DEFAULT_DAY_PADDING 10

#define DAY_VIEW_BORDER_WIDTH 4
#define DAY_VIEW_CORNER_RADIUS 5

#define SUBVIEW_PADDING 5

#define WEEK_DAY_LABEL_HEIGHT 20

#define DAY_LABEL_WIDTH 50
#define DAY_LABEL_HEIGHT 30

#define YEAR_LABEL_HEIGHT 20

#define YEAR_LABEL_FONT_SIZE 12
#define WEEK_DAY_FONT_SIZE 12
#define DAY_FONT_SIZE 40

@property (nonatomic) CGFloat dayWidth;
@property (nonatomic) CGFloat dayHeight;
@property (nonatomic) CGFloat dayPadding;

@property (nonatomic, strong) NSDate* date;
@property (nonatomic) NSUInteger day;
@property (nonatomic) NSUInteger month;
@property (nonatomic) NSUInteger year;
@property (nonatomic) NSUInteger weekDay;


@property (nonatomic, strong) UIView* dayView;
@property (nonatomic, strong) UILabel* weekDayLabel;
@property (nonatomic, strong) UILabel* dayLabel;
@property (nonatomic, strong) UILabel* yearLabel;

@property (nonatomic) CGFloat fraction;

- (id) initWithDate: (NSDate*) date andPadding: (CGFloat) padding;
@end
