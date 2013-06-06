//
//  GFViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GFCollection.h"
#import "CalendarView.h"
#import "BMLoadView.h"
#import "CalendarViewDelegate.h"
#import "ContainerButton.h"

#define CELL_VIEW_HEIGHT_STANDARD 85
#define CELL_VIEW_HEIGHT_FAVORITES 100
#define HEIGHT_OF_GFTABS 29
#define WIDTH_OF_MONTH_LABEL 250
#define HEIGHT_OF_MONTH_LABEL 20
#define HEIGHT_OF_SECTION_HEADER 30

#define GFCELL_MAINLABEL_HEIGHT 30
#define GFCELL_NAME_WIDTH 250
#define GFCELL_PADDING 5
#define GFCELL_SUBLABEL_HEIGHT 15
#define GFCELL_SUBLABEL_WIDTH 130
#define GFCELL_SUBLABEL_WIDTH_EXTENDED 180
#define GFCELL_BUTTON_WIDTH 80
#define GFCELL_BUTTON_HEIGHT 30


@interface GFViewController : UIViewController <CalendarViewDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl* GFTabs;
@property (nonatomic, weak) IBOutlet CalendarView* calendarView;
@property (nonatomic, strong)  UITableView *GFTableView;
@property (nonatomic, strong) UILabel* monthLabel;

@property (nonatomic, strong) GFCollection* collection;

- (void) hideCalendarView;
- (void) showCalendarView;
- (void) displayDate: (NSDate*) date;
@end
