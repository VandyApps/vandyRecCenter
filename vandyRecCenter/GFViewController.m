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

//find a better way to remove these
@property (nonatomic, strong) NSArray* cancelViews;

@end

@implementation GFViewController
@synthesize GFTabs = _GFTabs;
@synthesize collection = _collection;
@synthesize GFTableView = _GFTableView;
@synthesize monthLabel = _monthLabel;
@synthesize calendarView = _calendarView;
@synthesize cancelViews = _cancelViews;

#pragma mark - getter

- (NSArray*) cancelViews {
    if (_cancelViews == nil) {
        _cancelViews = [[NSArray alloc] init];
    }
    return _cancelViews;
}

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
    self.collection = [[GFCollection alloc] init];
    
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
    //set properties on the table view here
    self.GFTableView.delegate = self;
    self.GFTableView.dataSource = self;
    self.GFTableView.allowsSelection = NO;
    
    [self.view addSubview: self.GFTableView];

    BMLoadView* loadIndicator = [[BMLoadView alloc] initWithParent: self.view];
    [loadIndicator begin];
    [self.collection GFModelForCurrentMonth:^(NSError *error, GFModel *model) {
        [loadIndicator end];
        
    }];
        
    
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
    [self.GFTableView reloadData];
}

- (void) pushClassToFavorites: (ContainerButton*) sender {
    
    //toggle the selector
    if (sender.selected) {
        sender.selected = NO;
        
        [self.collection.favorites removeGFClassWithID: [sender.data objectForKey: @"_id"]];
    } else {
        sender.selected = YES;
        
        //add the class to favorites
        [self.collection.favorites add: sender.data];
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
    
    //load the month
    BMLoadView* loadIndicator = [[BMLoadView alloc] initWithParent: self.GFTableView];
    [loadIndicator begin];
    [self.collection GFModelForYear: year month: month block:^(NSError *error, GFModel *model) {
        if (error) {
            [self connectionError];
        } else {
            [self.GFTableView reloadData];
        }
        [loadIndicator end];
    }];
    
    for (UIView* view in self.cancelViews) {
        [view removeFromSuperview];
    }
}

- (void) didSelectDateForYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    NSDate *date = [NSDate dateWithYear: year month: month andDay: day];
    [self displayDate: date];
    //the data is reloaded based on the new variables for calendar view
    [self.GFTableView reloadData];
    for (UIView* view in self.cancelViews) {
        [view removeFromSuperview];
    }
}

#pragma mark - Table View DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* allClassesID = @"GFClasses";
    static NSString* favoriteClassesID = @"favoriteClasses";
    
    UITableViewCell* cell;
    
    
    if (self.GFTabs.selectedSegmentIndex != 2) {
        __block NSDictionary* GFClass;
        if (self.GFTabs.selectedSegmentIndex == 0) {
          
            [self.collection GFClassesForYear: self.calendarView.year month: self.calendarView.month day:self.calendarView.day block:^(NSError *error, NSArray *GFClasses) {
                
                if (error) {[self connectionError];}
                else {
                    GFClass = [GFClasses objectAtIndex: indexPath.row];
                }
                
            }];
        } else if (self.GFTabs.selectedSegmentIndex == 1) {
            [self.collection GFClassesForCurrentDay:^(NSError *error, NSArray *GFClasses) {
                if (error) {[self connectionError];}
                else {
                    GFClass = [GFClasses objectAtIndex: indexPath.row];
                }
            }];
        }
       
        cell = [tableView dequeueReusableCellWithIdentifier: allClassesID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:allClassesID];
        }
        
        UILabel* className = [[UILabel alloc] initWithFrame: CGRectMake( (self.GFTableView.frame.size.width - GFCELL_NAME_WIDTH) / 2.0, GFCELL_PADDING, GFCELL_NAME_WIDTH, GFCELL_MAINLABEL_HEIGHT)];
        className.text = [GFClass objectForKey: @"className"];
        className.font = [UIFont fontWithName: @"Helvetica-Bold" size: 18];
        className.textColor = [UIColor blueColor];
        className.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel* instructor = [[UILabel alloc] initWithFrame: CGRectMake(10, GFCELL_PADDING*2 + GFCELL_MAINLABEL_HEIGHT, GFCELL_SUBLABEL_WIDTH, GFCELL_SUBLABEL_HEIGHT)];
        instructor.text = [GFClass objectForKey: @"instructor"];
        instructor.font = [UIFont fontWithName: @"Helvetica-Bold" size: 12];
        
        
        UILabel* timeRange = [[UILabel alloc] initWithFrame: CGRectMake(10, GFCELL_PADDING*3 + GFCELL_SUBLABEL_HEIGHT + GFCELL_MAINLABEL_HEIGHT, GFCELL_SUBLABEL_WIDTH, GFCELL_SUBLABEL_HEIGHT)];
        timeRange.text = [GFClass objectForKey: @"timeRange"];
        timeRange.font = [UIFont fontWithName: @"Helvetica-Bold" size: 12];
       
        ContainerButton* addToFavorites = [[ContainerButton alloc] initWithFrame: CGRectMake(self.view.frame.size.width - 20 - 80, 40, 80, 30)];
        addToFavorites.data = GFClass;
        [addToFavorites setTitle: @"Add" forState: UIControlStateNormal];
        addToFavorites.titleLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size: 12];
        addToFavorites.layer.cornerRadius = 4;
        [addToFavorites setTitle: @"Favorite" forState: UIControlStateSelected];
        
        
        [addToFavorites addTarget:self action:@selector(pushClassToFavorites:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.collection.favorites isFavorite: GFClass]) {
            addToFavorites.selected = YES;
        }
        
        [cell addSubview: className];
        [cell addSubview: instructor];
        [cell addSubview: timeRange];
        [cell addSubview: addToFavorites];
        
        //check if the class is cancelled for today
        BOOL isCancelled = NO;
        NSArray* cancelledDates = [GFClass objectForKey: @"cancelledDates"];
        NSDate* date = [NSDate dateWithYear: self.calendarView.year month: self.calendarView.month andDay:self.calendarView.day];
        for (NSString* cancelledDate in cancelledDates) {
            if ([date compare: [NSDate dateWithDateString: cancelledDate]] == NSOrderedSame) {
                isCancelled = YES;
            }
        }
        
        if (isCancelled) {
            UILabel* cancelledLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, CELL_VIEW_HEIGHT_STANDARD)];
            cancelledLabel.text = @"Cancelled";
            cancelledLabel.textColor = [UIColor redColor];
            cancelledLabel.backgroundColor = [UIColor whiteColor];
            cancelledLabel.alpha = .65;
            cancelledLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size: 20];
            cancelledLabel.textAlignment = NSTextAlignmentCenter;
            cancelledLabel.userInteractionEnabled = YES;
            [cell addSubview: cancelledLabel];
            self.cancelViews = [self.cancelViews arrayByAddingObject: cancelledLabel];
        }
        
        
    } else {
        //render the favorite cell style
        cell = [tableView dequeueReusableCellWithIdentifier: favoriteClassesID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: favoriteClassesID];
        }
        
        NSDictionary* GFClass = [self.collection.favorites GFClassForIndex: indexPath.row];
        
        UILabel* className = [[UILabel alloc] initWithFrame: CGRectMake( (self.GFTableView.frame.size.width - GFCELL_NAME_WIDTH) / 2.0, GFCELL_PADDING, GFCELL_NAME_WIDTH, GFCELL_MAINLABEL_HEIGHT)];
        className.text = [GFClass objectForKey: @"className"];
        className.font = [UIFont fontWithName: @"Helvetica-Bold" size: 18];
        className.textColor = [UIColor blueColor];
        className.textAlignment = NSTextAlignmentCenter;
        
        UILabel* instructor = [[UILabel alloc] initWithFrame: CGRectMake(GFCELL_PADDING, GFCELL_PADDING * 2 + GFCELL_MAINLABEL_HEIGHT, GFCELL_SUBLABEL_WIDTH, GFCELL_SUBLABEL_HEIGHT)];
        instructor.text = [GFClass objectForKey: @"instructor"];
        instructor.font = [UIFont fontWithName: @"Helvetica-Bold" size: 12];
        instructor.layer.borderWidth = 2;
        instructor.layer.borderColor = [[UIColor blackColor] CGColor];
        
        UILabel* timeRange = [[UILabel alloc] initWithFrame: CGRectMake(GFCELL_PADDING, GFCELL_PADDING * 3 + GFCELL_MAINLABEL_HEIGHT + GFCELL_SUBLABEL_HEIGHT, GFCELL_SUBLABEL_WIDTH_EXTENDED, GFCELL_SUBLABEL_HEIGHT)];
        timeRange.text = [NSString stringWithFormat: @"%@ at %@", [DateHelper weekDayForIndex:[[GFClass objectForKey: @"dayOfWeek"] intValue]], [GFClass objectForKey: @"timeRange"]];
        timeRange.font = [UIFont fontWithName: @"Helvetica-Bold" size: 12];
        timeRange.layer.borderWidth = 2;
        timeRange.layer.borderColor = [[UIColor blackColor] CGColor];
        
        
        //get the current date for the time zone using
        //the date formatter method
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        formatter.timeZone = [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE];
        NSString* dateString = [formatter stringFromDate: [[NSDate alloc] init]];
        //add the 20 into the date for the year
        dateString = [[[dateString substringToIndex: dateString.length - 2] stringByAppendingString:@"20"] stringByAppendingString: [dateString substringFromIndex:dateString.length - 2]];
        NSDate *currentDate = [NSDate dateWithDateString: dateString];
        
        //check to see if the class being added to the favorites
        //list still exists in the schedule (the end date has not yet passed)
        //if (![[GFClass objectForKey: @"endDate"] isEqualToString: @"*"] && [currentDate compare: [NSDate dateWithDateString: [GFClass objectForKey: @"endDate"]]] == NSOrderedDescending) {
            UILabel* discontinue = [[UILabel alloc] initWithFrame: CGRectMake((self.GFTableView.frame.size.width - GFCELL_SUBLABEL_WIDTH_EXTENDED)/2.0, CELL_VIEW_HEIGHT_FAVORITES - GFCELL_SUBLABEL_HEIGHT - GFCELL_PADDING, GFCELL_SUBLABEL_WIDTH_EXTENDED, GFCELL_SUBLABEL_HEIGHT)];
            discontinue.textColor = [UIColor redColor];
            discontinue.text = @"This class is discontinued";
            discontinue.font = [UIFont fontWithName: @"Helvetica-Bold" size: 12];
            discontinue.textAlignment = NSTextAlignmentCenter;
            
            [cell addSubview: discontinue];
        //}
        
        //buttons
        UIButton* calendarButton = [[UIButton alloc] initWithFrame: CGRectMake((self.GFTableView.frame.size.width - 40 * 2 - GFCELL_PADDING*10) / 2.0, GFCELL_PADDING * 5 + GFCELL_SUBLABEL_HEIGHT* 2 + GFCELL_MAINLABEL_HEIGHT, 40, 40)];
        
        calendarButton.layer.backgroundColor = [[UIColor darkGrayColor] CGColor];
        calendarButton.layer.cornerRadius = 10;
        [calendarButton setBackgroundImage: [UIImage imageNamed: @"426-calendar.png"] forState:UIControlStateNormal];
        
        UIButton* removeButton = [[UIButton alloc] initWithFrame: CGRectMake((self.GFTableView.frame.size.width + GFCELL_PADDING * 10) / 2.0, GFCELL_PADDING * 5 + GFCELL_SUBLABEL_HEIGHT*2 + GFCELL_MAINLABEL_HEIGHT, 40, 40)];
        [removeButton setBackgroundImage: [UIImage imageNamed:@"432-no.png"] forState: UIControlStateNormal];
        removeButton.layer.backgroundColor = [[UIColor darkGrayColor] CGColor];
        removeButton.layer.cornerRadius = 10;
        
        
        
        [cell addSubview: className];
        [cell addSubview: timeRange];
        [cell addSubview: instructor];
        [cell addSubview: calendarButton];
        [cell addSubview: removeButton];
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    __block NSUInteger rowsInSection = 0;
    
    
    if (self.GFTabs.selectedSegmentIndex == 0) {
        [self.collection GFClassesForYear: self.calendarView.year month:self.calendarView.month day:self.calendarView.day  block:^(NSError *error, NSArray *GFClasses) {
            if (error) {
                [self connectionError];
            } else {
                rowsInSection = GFClasses.count;
            }

        }];
    } else if (self.GFTabs.selectedSegmentIndex == 1) {
        [self.collection GFClassesForCurrentDay:^(NSError *error, NSArray *GFClasses) {
            if (error) {
                [self connectionError];
            } else {
                rowsInSection = GFClasses.count;
            }
        }];
    } else {
        //the selected tab is 2
        rowsInSection = [self.collection.favorites count];
    }
    
    
    return rowsInSection;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Table View Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView* view = [[UIImageView alloc] init];
    view.image = [UIImage imageNamed: @"goldTint.png"];
    self.monthLabel = [[UILabel alloc] initWithFrame: CGRectMake((self.view.frame.size.width - WIDTH_OF_MONTH_LABEL) / 2.0, (HEIGHT_OF_SECTION_HEADER - HEIGHT_OF_MONTH_LABEL) / 2.0,  WIDTH_OF_MONTH_LABEL, HEIGHT_OF_MONTH_LABEL)];
    
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    self.monthLabel.font = [UIFont fontWithName: @"TrebuchetMS-Bold" size: 18];
    self.monthLabel.backgroundColor = [UIColor clearColor];
    
    if (self.GFTabs.selectedSegmentIndex == 0) {
        [self displayDate: [self.calendarView selectedDate]];
    } else if (self.GFTabs.selectedSegmentIndex == 1) {
        
        //get the current date for the time zone using
        //the date formatter method
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        formatter.timeZone = [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE];
        NSString* dateString = [formatter stringFromDate: [[NSDate alloc] init]];
        //add the 20 into the date for the year
        dateString = [[[dateString substringToIndex: dateString.length - 2] stringByAppendingString:@"20"] stringByAppendingString: [dateString substringFromIndex:dateString.length - 2]];
        [self displayDate: [NSDate dateWithDateString: dateString]];
        
    } else {
        self.monthLabel.text = @"Favorites";
    }
    [view addSubview: self.monthLabel];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEIGHT_OF_SECTION_HEADER;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.GFTabs.selectedSegmentIndex == 2) {
        return CELL_VIEW_HEIGHT_FAVORITES;
    } else {
       return CELL_VIEW_HEIGHT_STANDARD;
    }
    
}

#pragma mark - Helpers

- (void) connectionError {
    UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle: @"Error with Internet Collection" message: @"Could not connect to the internet" delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [errorAlert show];
}

@end
