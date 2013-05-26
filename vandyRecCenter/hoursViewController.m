 //
//  hoursViewController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/3/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "hoursViewController.h"

@interface hoursViewController()

@property (nonatomic, strong) NSDictionary* currentHoursToDisplay;
@property (nonatomic) NSInteger sectionOfSelectedCell;
@property (nonatomic) NSInteger rowOfSelectedCell;
@property (nonatomic) NSInteger sectionOfCurrentHours;
@property (nonatomic) NSInteger rowOfCurrentHours;
@property (nonatomic, strong, readonly) NSArray* subviewsInScrollView;
@property (nonatomic) NSUInteger indexOfScroll; //used to keep the scroll at discrete values

@end


@implementation hoursViewController

//private properties
@synthesize currentHoursToDisplay = _currentHoursToDisplay;
@synthesize rowOfCurrentHours = _rowOfCurrentHours;
@synthesize sectionOfCurrentHours = _sectionOfCurrentHours;
@synthesize rowOfSelectedCell = _rowOfSelectedCell;
@synthesize sectionOfSelectedCell = _sectionOfSelectedCell;
@synthesize subviewsInScrollView = _subviewsInScrollView;
@synthesize indexOfScroll = _indexOfScroll;

//public properties
@synthesize hours = _hours;

//UI properties
@synthesize tableView = _tableView;
@synthesize remainingTime = _remainingTime;
@synthesize scrollHours = _scrollHours;
@synthesize pageControl = _pageControl;
@synthesize leftScroll = _leftScroll;
@synthesize rightScroll = _rightScroll;

#pragma mark - Getters and Setters



- (HoursModel*) hours {
    if (!_hours) {
        NSString *path = [[NSBundle mainBundle] pathForResource: @"hours" ofType:@"plist"];
        _hours = [[HoursModel alloc] initWithPathToPList: path];
    }
    return _hours;
}


- (void) viewWasAddedToScrollView: (UIView*) addedView {
    if (!_subviewsInScrollView) {
        _subviewsInScrollView = [[NSArray alloc] initWithObjects:addedView, nil];
    } else {
        _subviewsInScrollView = [_subviewsInScrollView arrayByAddingObject: addedView];
    }
    
}


- (void) incrementIndexOfScroll {
    NSUInteger numberOfPages = self.scrollHours.contentSize.width / self.scrollHours.frame.size.width;
    _indexOfScroll = (_indexOfScroll + 1) % numberOfPages;
}

- (void) decrementIndexOfScroll {
    
    
    NSUInteger numberOfPages = self.scrollHours.contentSize.width / self.scrollHours.frame.size.width;
    if (_indexOfScroll == 0) {
        _indexOfScroll = numberOfPages - 1;
    } else {
        _indexOfScroll--;
    }
}


//only sets the value if it is a valid index
- (void) setIndexOfScroll:(NSUInteger)indexOfScroll {
    
    
    NSUInteger numberOfPages = self.scrollHours.contentSize.width / self.scrollHours.frame.size.width;
    if (indexOfScroll < numberOfPages) {
        _indexOfScroll = indexOfScroll;
    }
}


#pragma mark - Lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    //setting the delegates
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.scrollHours.delegate = self;
    self.scrollHours.scrollHoursDelegate = self;
    self.pageControl.hidesForSinglePage = YES;
    [self setCurrentHours];
    [self selectCurrentHours];
    [self selectCurrentDayOfTheWeek];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    //set the remaining time label
    //make the selected cell the current hours
    
    [self refreshRemainingTime];
}

- (void) viewDidLayoutSubviews {
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        self.pageControl.hidden = NO;
    } else {
        self.pageControl.hidden = YES;
    }
    
    [self setUpScrollViewWithHoursTitle: self.title];
    [self resetScroll];
}

#pragma mark - EventHandler

- (IBAction)current:(UIBarButtonItem *)sender {
    [self selectCurrentHours];
    [self selectCurrentDayOfTheWeek];
}

//paging left and right are dynamically created events
- (IBAction)scrollLeft {
    
    [self decrementIndexOfScroll];
    self.pageControl.currentPage = self.indexOfScroll;
    
    NSLog(@"%f", self.scrollHours.frame.size.width);
    NSInteger newOffset = self.indexOfScroll * self.scrollHours.frame.size.width;
    
    [self.scrollHours setContentOffset: CGPointMake((CGFloat) newOffset, 0) animated: YES];
    
}

- (IBAction)scrollRight {

    
    [self incrementIndexOfScroll];
    self.pageControl.currentPage = self.indexOfScroll;
    
    //set up the frame and content size of the scroll view
    
    NSInteger newOffset = self.indexOfScroll * self.scrollHours.frame.size.width;
    
    [self.scrollHours setContentOffset: CGPointMake((CGFloat) newOffset, 0) animated: YES];
    
}


#pragma mark - Private

- (NSString*) displayTimeInterval: (NSTimeInterval) timeInterval untilClosing: (BOOL) isClosing {
    
    //interval in seconds
    NSInteger hours = timeInterval / 3600;
    NSInteger minutes = ((NSInteger) timeInterval/ 60  + 1)% 60; //add 1 minute for rounding up purposes
    if (isClosing) {
        return [NSString stringWithFormat: @"Closing in %ih %im", hours, minutes];
    } else {
        return [NSString stringWithFormat: @"Opening in %ih %im", hours, minutes];
    }
    
}



- (NSString*) getDateStringWithStartDate: (NSDate*) startDate andEndDate: (NSDate*) endDate {
    
    NSDateFormatter *formatDate = [[NSDateFormatter alloc] init];
    formatDate.dateStyle = NSDateFormatterMediumStyle;
    NSString* semiFormattedStartDate = [formatDate stringFromDate: startDate];
    NSString *semiFormattedEndDate = [formatDate stringFromDate: endDate];
    
    NSString *formattedStartDate = [semiFormattedStartDate substringWithRange: NSMakeRange(0, [semiFormattedEndDate length] - 6)];
    NSString *formattedEndDate = [semiFormattedEndDate substringWithRange: NSMakeRange(0, [semiFormattedEndDate length] - 6)];
    
    if ([formattedStartDate isEqualToString: formattedEndDate]) {
        return @"All year round";
    }
    
    return [formattedStartDate stringByAppendingFormat: @" - %@", formattedEndDate];
}



#pragma mark - CurrentTime

//this method does not do anything involving views or UI elements
//it is used to prep the setup of the table view
- (void) setCurrentHours {
    NSDictionary* currentTime = [self.hours hoursForCurrentTime];
    
    //the method hoursForCurrentTime should always return hours that are
    //considered facility hours
    assert([[currentTime objectForKey: @"facilityHours"] boolValue]);
    
    if ([[currentTime objectForKey: @"closed"] boolValue]) {
        self.sectionOfCurrentHours = 2;
        NSArray* closedHours = [self.hours closedHours];
        BOOL foundCurrentHours = NO;
        for (size_t i = 0; i < [closedHours count] && !foundCurrentHours; ++i) {
            
            if ([[[closedHours objectAtIndex: i] objectForKey: @"title"] isEqualToString: [currentTime objectForKey:@"title"]]) {
                
                self.rowOfCurrentHours = i;
                foundCurrentHours = YES;
            }
        }
        
    } else if ([[currentTime objectForKey: @"mainHours"] boolValue]) {
        self.sectionOfCurrentHours = 0;
        
        NSArray* mainHours = [self.hours mainHours];
        BOOL foundCurrentHours = NO;
        for (size_t i = 0; i < [mainHours count] && !foundCurrentHours; ++i) {
            
            if ([[[mainHours objectAtIndex: i] objectForKey: @"title"] isEqualToString: [currentTime objectForKey:@"title"]]) {
                
                self.rowOfCurrentHours = i;
                foundCurrentHours = YES;
            }
        }
        
    } else {//current time is within 'other hours'
        self.sectionOfCurrentHours = 1;
        
        NSArray* otherHours = [self.hours otherHours];
        BOOL foundCurrentHours = NO;
        for (size_t i = 0; i < [otherHours count] && !foundCurrentHours; ++i) {
            
            if ([[[otherHours objectAtIndex: i] objectForKey: @"title"] isEqualToString: [currentTime objectForKey:@"title"]]) {
                
                self.rowOfCurrentHours = i;
                foundCurrentHours = YES;
            }
        }
        
    }
    
}

- (void) selectCurrentHours {
    self.rowOfSelectedCell = self.rowOfCurrentHours;
    self.sectionOfSelectedCell = self.sectionOfCurrentHours;
     //reload data so that the correct colors of table cells display
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow: self.rowOfCurrentHours inSection:self.sectionOfCurrentHours] animated: YES scrollPosition: UITableViewScrollPositionMiddle];
    
    //process of selecting
    NSString* title = [[self.hours hoursForCurrentTime] objectForKey: @"title"];
    self.title = title;
    [self setUpScrollViewWithHoursTitle: title];
}

//should not call this method when the current hours are not displayed
- (void) selectCurrentDayOfTheWeek {
    assert(self.sectionOfCurrentHours == self.sectionOfSelectedCell && self.rowOfCurrentHours == self.rowOfSelectedCell);
    NSUInteger indexForCurrentDayOfWeek = [NSDate currentDayOfTheWeekAsIntWithTimeZone: [NSTimeZone localTimeZone]];
    NSArray* hours = [[self.hours hoursForCurrentTime] objectForKey: @"hours"];
    NSArray *uniqueDaysOfWeek = [self.scrollHours arrayOfUniqueIndices: hours];
    
    BOOL foundIndexToScroll = NO;
    for (size_t i = 0; i < [uniqueDaysOfWeek count] && !foundIndexToScroll; ++i) {
        if ([[uniqueDaysOfWeek objectAtIndex: i] intValue] == indexForCurrentDayOfWeek) { //found index
            self.indexOfScroll = i;
            foundIndexToScroll = YES;
        } else if ([[uniqueDaysOfWeek objectAtIndex: i] intValue] > indexForCurrentDayOfWeek) { //passed the index
            self.indexOfScroll = i-1;
            foundIndexToScroll = YES;
        }
    }
    
    [self.scrollHours setContentOffset:CGPointMake(self.indexOfScroll*self.scrollHours.frame.size.width, 0) animated:YES];
    self.pageControl.currentPage = self.indexOfScroll;
    
}

- (void) refreshRemainingTime {
    NSString *displayTime;
    if ([self.hours isOpen]) {
        displayTime = [self displayTimeInterval: [self.hours timeUntilClosed] untilClosing: YES];
    } else if ([self.hours willOpenLaterToday]) {
        displayTime = [self displayTimeInterval: [self.hours timeUntilOpen] untilClosing: NO];
    } else {
        displayTime = @"Closed for the day";
    }
    self.remainingTime.text = displayTime;
}


#pragma mark - TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"hoursCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    }
   
    //setting up the cell specifics
    if (indexPath.section == 0) {
    
        
         NSString* title = [[[self.hours mainHours] objectAtIndex:indexPath.row] objectForKey: @"title"];
        
        NSDate* startDate = [[[self.hours mainHours] objectAtIndex:indexPath.row] objectForKey: @"beginningDate"];
        NSDate *endDate = [[[self.hours mainHours] objectAtIndex:indexPath.row] objectForKey: @"endDate"];
        
        [ (UILabel*) [cell viewWithTag: 2] setText: title];
        
        [(UILabel *) [cell viewWithTag: 3] setText: [self getDateStringWithStartDate: startDate andEndDate:endDate] ];
    } else if (indexPath.section == 1) {
        
        NSString* title = [[[self.hours otherHours] objectAtIndex:indexPath.row] objectForKey: @"title"];
        
        NSDate *startDate = [[[self.hours otherHours] objectAtIndex:indexPath.row] objectForKey: @"beginningDate"];
        NSDate *endDate = [[[self.hours otherHours] objectAtIndex:indexPath.row] objectForKey: @"endDate"];
        
        
        [ (UILabel*) [cell viewWithTag: 2] setText: title];
         [(UILabel *) [cell viewWithTag: 3] setText: [self getDateStringWithStartDate: startDate andEndDate:endDate] ];
        
    } else  {//last section
    
        NSString* title = [[[self.hours closedHours] objectAtIndex:indexPath.row] objectForKey: @"title"];
        NSDate *startDate = [[[self.hours closedHours] objectAtIndex:indexPath.row] objectForKey: @"beginningDate"];
        NSDate *endDate = [[[self.hours closedHours] objectAtIndex:indexPath.row] objectForKey: @"endDate"];
        
        
        [(UILabel*) [cell viewWithTag: 2] setText: title];
        [(UILabel *) [cell viewWithTag: 3] setText: [self getDateStringWithStartDate: startDate andEndDate:endDate] ];
    }
    
    if (indexPath.section == self.sectionOfSelectedCell && indexPath.row == self.rowOfSelectedCell) {
        
        [(UIImageView*) [cell viewWithTag: 1] setImage: [UIImage imageNamed: IMAGE_CELL_SELECTED]];
    } else {
        [(UIImageView*) [cell viewWithTag: 1] setImage: [UIImage imageNamed:IMAGE_CELL_NORMAL]];
    }
    
    if (indexPath.section == self.sectionOfCurrentHours && indexPath.row == self.rowOfCurrentHours) {
        [(UILabel*) [cell viewWithTag: 4] setText: @"Current"];
    } else {
        [(UILabel*) [cell viewWithTag: 4] setText: @""];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DEFAULT_HEIGHT_FOR_CELL;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
    
        return [[self.hours mainHours] count];
    } else if (section == 1) {
    
        return [[self.hours otherHours] count];
    } else {
        return [[self.hours closedHours] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Main Hours";
    } else if (section == 1) {
        return @"Other Hours";
    } else {
    
        return @"Closed";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    
    UIImageView *imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: IMAGE_SECTION_HEAD]];
    UILabel* title = [[UILabel alloc] initWithFrame: CGRectMake(10, 2, 320, 20)];
    title.backgroundColor = [UIColor clearColor];
    if (section == 0) {
    
        title.text = @"Main Hours";
    } else if (section == 1) {
    
        title.text = @"Other Hours";
    } else  {//section is 2
        
        title.text = @"Closed";
    }
    [imageView addSubview: title];
     return imageView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title;
    if (indexPath.section == 0) {
    
        title = [[[self.hours mainHours] objectAtIndex: indexPath.row] objectForKey: @"title"];
    } else if (indexPath.section == 1) {
    
         title = [[[self.hours otherHours] objectAtIndex: indexPath.row] objectForKey: @"title"];
    } else {
    
        title = [[[self.hours closedHours] objectAtIndex: indexPath.row] objectForKey: @"title"];
    }
    //set the title in the navigation bar
    self.title = title;
    //get the array for the hours
    //change color of gradient here
    self.sectionOfSelectedCell = indexPath.section;
    self.rowOfSelectedCell = indexPath.row;
    [tableView reloadData];
    [self setUpScrollViewWithHoursTitle: title];
    
    //move the scroll view offset
    [self.scrollHours setContentOffset: CGPointMake(0, 0) animated:YES];
    self.indexOfScroll = 0; //reset the page back to the start
    self.pageControl.currentPage = self.indexOfScroll;
}



#pragma mark - ScrollView

- (void) setUpScrollViewWithHoursTitle: (NSString*) title {
    NSUInteger pageCount = [self.scrollHours setUpScrollViewWithHours: [self.hours hoursWithTitle: title]];
    if (pageCount == 1) {
        self.leftScroll.hidden = YES;
        self.rightScroll.hidden = YES;
    } else {
        self.leftScroll.hidden = NO;
        self.rightScroll.hidden = NO;
    }
    self.pageControl.numberOfPages = pageCount;
}

#pragma mark - ScrollDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollHours) {
        //make sure that the correct scroll view is called, not table view
        
        self.indexOfScroll = scrollView.contentOffset.x / self.scrollHours.frame.size.width;
        self.pageControl.currentPage = self.indexOfScroll;
    }
}

#pragma mark ScrollHoursDelegate

- (NSDictionary*) hoursForFrameChange:(CGRect)newFrame {
    return [self.hours hoursWithTitle: self.title];
}

//resets the scroll to the the intended value
//use this when orientation is changed
- (void) resetScroll {
    [self.scrollHours setContentOffset: CGPointMake(self.indexOfScroll * self.scrollHours.frame.size.width, 0) animated: YES];
}
@end
