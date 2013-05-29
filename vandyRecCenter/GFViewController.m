//
//  GFViewController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFViewController.h"
#import "GFCollection.h"
@interface GFViewController ()

@end

@implementation GFViewController
@synthesize GFTabs = _GFTabs;
@synthesize model = _model;
@synthesize GFTableView = _GFTableView;
@synthesize monthLabel = _monthLabel;
@synthesize calendarView = _calendarView;



#pragma mark - getters




#pragma mark - initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.calendarView.calendarDelegate = self;
    [self.GFTabs addTarget: self action: @selector(tabChanged:) forControlEvents: UIControlEventValueChanged];
    
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.GFTableView != nil) {
        [self.GFTableView removeFromSuperview];
    }

    if (self.calendarView.hidden) {
        self.GFTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.calendarView.frame.origin.x, self.calendarView.frame.origin.y, self.view.frame.size.width, self.GFTableView.frame.size.height + self.calendarView.frame.size.height) style: UITableViewStylePlain];
        
        
    } else {
        
        self.GFTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, self.calendarView.frame.size.height + HEIGHT_OF_GFTABS, self.view.frame.size.width, self.view.frame.size.height - self.calendarView.frame.size.height - HEIGHT_OF_GFTABS) style:UITableViewStylePlain];

    }
    self.GFTableView.delegate = self;
    self.GFTableView.dataSource = self;
    
    [self.view addSubview: self.GFTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Events
- (void) tabChanged: (UISegmentedControl*) tabControl {
    if (tabControl.selectedSegmentIndex == 0) {
        [self showCalendarView];
    } else {
        [self hideCalendarView];
    }
}

#pragma mark - Public

- (void) hideCalendarView {
    if (!self.calendarView.hidden) {
        self.calendarView.hidden = YES;
        self.GFTableView.frame = CGRectMake(self.calendarView.frame.origin.x, self.calendarView.frame.origin.y, self.GFTableView.frame.size.width, self.GFTableView.frame.size.height + self.calendarView.frame.size.height);
    }
}

- (void) showCalendarView {
    if (self.calendarView.hidden) {
        self.calendarView.hidden = NO;
        
        self.GFTableView.frame = CGRectMake(0, self.calendarView.frame.size.height + HEIGHT_OF_GFTABS, self.GFTableView.frame.size.width, self.GFTableView.frame.size.height - self.calendarView.frame.size.height);
    }
}

- (void) displayDate: (NSDate*) date {
    self.monthLabel.text = [NSString stringWithFormat: @"%@. %@ %i, %i", [DateHelper weekDayAbbreviationForIndex:[date weekDay]], [DateHelper monthNameForIndex: [date month]], [date day], [date year]];
}

#pragma mark - Calendar Delegate

- (void) calendarChangeToYear:(NSUInteger)year month:(NSUInteger)month {
    NSDate *date = [NSDate dateWithYear: year month: month andDay: 1];
    [self displayDate: date];
}
- (void) didSelectDateForYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    NSDate *date = [NSDate dateWithYear: year month: month andDay: day];
    [self displayDate: date];
}

#pragma mark - Table View DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"test"];
    cell.textLabel.text = @"Here is a cell";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView* view = [[UIImageView alloc] init];
    view.image = [UIImage imageNamed: @"goldTint.png"];
    self.monthLabel = [[UILabel alloc] initWithFrame: CGRectMake((self.view.frame.size.height - 250) / 2.0, (30 - 20) / 2.0,  250, 20)];
    
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    self.monthLabel.font = [UIFont fontWithName: @"TrebuchetMS-Bold" size: 18];
    self.monthLabel.backgroundColor = [UIColor clearColor];
    
    [view addSubview: self.monthLabel];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

#pragma mark - Helpers (to be moved)
@end
