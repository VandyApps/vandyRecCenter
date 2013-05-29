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

@interface GFViewController : UIViewController <CalendarViewDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl* GFTabs;
@property (nonatomic, weak) IBOutlet CalendarView* calendarView;
@property (nonatomic, weak) IBOutlet UITableView *GFTableView;
@property (nonatomic, weak) IBOutlet UIView *monthView;
@property (nonatomic, strong) GFModel *model;
@end
