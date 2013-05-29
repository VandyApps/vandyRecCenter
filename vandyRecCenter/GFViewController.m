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


- (IBAction) toggle:(id)sender {
    if (self.calendarView.hidden) {
        [self showCalendarView];
    } else {
        [self hideCalendarView];
    }
}

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
    
    
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.GFTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, self.calendarView.frame.size.height + HEIGHT_OF_GFTABS, self.view.frame.size.width, self.view.frame.size.height - self.calendarView.frame.size.height - HEIGHT_OF_GFTABS) style:UITableViewStylePlain];
    [self.view addSubview: self.GFTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Calendar Delegate

- (void) calendarChangeToYear:(NSUInteger)year month:(NSUInteger)month {
    NSLog(@"Calendar changed");
}
- (void) didSelectDateForYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    NSLog(@"Selected date");
}



@end
