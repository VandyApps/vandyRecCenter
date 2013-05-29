//
//  GFViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GFModel.h"
#import "CalendarView.h"
#import "CalendarViewDelegate.h"

#define HEIGHT_OF_GFTABS 29
#define WIDTH_OF_MONTH_LABEL 250
#define HEIGHT_OF_MONTH_LABEL 20
#define HEIGHT_OF_SECTION_HEADER 30

@interface GFViewController : UIViewController <CalendarViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl* GFTabs;
@property (nonatomic, weak) IBOutlet CalendarView* calendarView;
@property (nonatomic, strong)  UITableView *GFTableView;
@property (nonatomic, strong) GFModel *model;
@property (nonatomic, strong) UILabel* monthLabel;

- (void) hideCalendarView;
- (void) showCalendarView;
- (void) displayDate: (NSDate*) date;
@end
