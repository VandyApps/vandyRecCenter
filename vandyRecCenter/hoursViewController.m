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
@synthesize titleDisplay = _titleDisplay;
@synthesize scrollHours = _scrollHours;
@synthesize pageControl = _pageControl;
@synthesize navigationBar = _navigationBar;

#pragma - Getters and Setters


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
- (void) removeAllSubviewsInScrollView {
    if (_subviewsInScrollView && [_subviewsInScrollView count] != 0)
    {
        NSEnumerator *viewEnum = [_subviewsInScrollView objectEnumerator];
        UIView *nextView;
        while (nextView = [viewEnum nextObject]) {
            [nextView removeFromSuperview];
        }
        _subviewsInScrollView = [[NSArray alloc] init];
    }
}

- (void) incrementIndexOfScroll {
    NSUInteger numberOfPages = self.scrollHours.contentSize.width / WIDTH_OF_PAGE;
    _indexOfScroll = (_indexOfScroll + 1) % numberOfPages;
}

- (void) decrementIndexOfScroll {
    NSUInteger numberOfPages = self.scrollHours.contentSize.width / WIDTH_OF_PAGE;
    if (_indexOfScroll == 0) {
        _indexOfScroll = numberOfPages - 1;
    } else {
        _indexOfScroll--;
    }
}


//only sets the value if it is a valid index
- (void) setIndexOfScroll:(NSUInteger)indexOfScroll {
    NSUInteger numberOfPages = self.scrollHours.contentSize.width / WIDTH_OF_PAGE;
    if (indexOfScroll < numberOfPages) {
        _indexOfScroll = indexOfScroll;
    }
}

#pragma - Lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    //setting the delegates
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.scrollHours.delegate = self;
    [self setCurrentHours];
    [self selectCurrentHours];
    [self selectCurrentDayOfTheWeek];
    self.pageControl.hidesForSinglePage = YES;
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    [self refreshRemainingTime];
    //set the remaining time label
    //make the selected cell the current hours
    
    
}

///////////
//events///
//////////

- (IBAction)current:(UIBarButtonItem *)sender {
    [self selectCurrentHours];
    [self selectCurrentDayOfTheWeek];
}

//paging left and right are dynamically created events
- (IBAction)scrollOnePageLeft {
    
    [self decrementIndexOfScroll];
    self.pageControl.currentPage = self.indexOfScroll;
    
    NSInteger newOffset = self.indexOfScroll * WIDTH_OF_PAGE;
    [self.scrollHours setContentOffset: CGPointMake((CGFloat) newOffset, 0) animated: YES];
    
}

- (IBAction)scrollOnePageRight {

    
    [self incrementIndexOfScroll];
    self.pageControl.currentPage = self.indexOfScroll;
    NSInteger newOffset = self.indexOfScroll * WIDTH_OF_PAGE;
    
    [self.scrollHours setContentOffset: CGPointMake((CGFloat) newOffset, 0) animated: YES];
    
}
////////////////////
//private methods//
///////////////////

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

//this returns an array of all the indices that are totally unique in sequence
//MORE DETAILED COMMENTS HERE
- (NSArray*) arrayOfUniqueIndices: (NSArray*) hours {
    NSArray* arrayOfIndices = [[NSArray alloc] init];
    for (size_t i =0; i < [hours count]; ++i) {
        if (i == 0) {
            arrayOfIndices = [arrayOfIndices arrayByAddingObject: [NSNumber numberWithInt: 0]];
            
        } else {
        
            if (![[hours objectAtIndex: i] isEqualToString: [hours objectAtIndex: i - 1]]) {
                arrayOfIndices = [arrayOfIndices arrayByAddingObject: [NSNumber numberWithInt: i]];
            } 
        }
        
    }
    return arrayOfIndices;
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


- (NSArray*) titlesForArrayOfUniqueIndices: (NSArray*) arrayOfUniqueIndices {
    NSArray* titles = [[NSArray alloc] init];
    for (size_t i = 0; i < [arrayOfUniqueIndices count]; ++i) {
        if (i+1 < [arrayOfUniqueIndices count]) { //then this is not the last index
            if ([[arrayOfUniqueIndices objectAtIndex:i] intValue] != [[arrayOfUniqueIndices objectAtIndex:i+1] intValue] - 1) { //there is a range
               
                NSInteger startIndex = [[arrayOfUniqueIndices objectAtIndex: i] intValue];
                NSInteger endIndex = [[arrayOfUniqueIndices objectAtIndex: i + 1] intValue] - 1;
                titles = [titles arrayByAddingObject: [NSString stringWithFormat: @"%@ - %@", [NSDate dayOfTheWeekAbreviationForIndex: startIndex], [NSDate dayOfTheWeekAbreviationForIndex:endIndex]]];
                
                
            } else { //there is no range, just a single day
                titles = [titles arrayByAddingObject: [NSDate dayOfTheWeekForIndex:[[arrayOfUniqueIndices objectAtIndex: i] intValue]]];
            }
        } else {
            titles = [titles arrayByAddingObject: [NSDate dayOfTheWeekForIndex: [[arrayOfUniqueIndices objectAtIndex:i] intValue]]];
        }
    }
    return titles;
}


/////////////////////////////
//methods for current time//
////////////////////////////

- (void) setCurrentHours {
    NSDictionary* currentTime = [self.hours hoursForCurrentTime];
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
    [self.tableView reloadData]; //reload data so that the correct gradients display
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow: self.rowOfCurrentHours inSection:self.sectionOfCurrentHours] animated: YES scrollPosition: UITableViewScrollPositionMiddle];
    //process of selecting
    NSString* title = [[self.hours hoursForCurrentTime] objectForKey: @"title"];
    self.title = title;
    NSLog(@"%@", self.navigationBar.topItem.title);
    [self setUpScrollViewWithHoursTitle: title];
}

//should not call this method when the current hours are not displayed
- (void) selectCurrentDayOfTheWeek {
    assert(self.sectionOfCurrentHours == self.sectionOfSelectedCell && self.rowOfCurrentHours == self.rowOfSelectedCell);
    NSUInteger indexForCurrentDayOfWeek = [NSDate currentDayOfTheWeekAsIntWithTimeZone: [NSTimeZone localTimeZone]];
    NSArray* hours = [[self.hours hoursForCurrentTime] objectForKey: @"hours"];
    NSArray *uniqueDaysOfWeek = [self arrayOfUniqueIndices: hours];
    
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
    [self.scrollHours setContentOffset:CGPointMake(self.indexOfScroll*WIDTH_OF_PAGE, 0) animated:YES];
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


////////////////////
//table view stuff//
////////////////////

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
        
        [(UIImageView*) [cell viewWithTag: 1] setImage: [UIImage imageNamed: @"black-goldGradient.png"]];
    } else {
        [(UIImageView*) [cell viewWithTag: 1] setImage: [UIImage imageNamed: @"blackGradient.png"]];
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

    
    UIImageView *imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"brownGradient.png"]];
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



/////////////////////
//scroll view stuff//
/////////////////////
 
- (void) setUpScrollViewWithHoursTitle: (NSString*) title {
    
    //clear any existing subviews in the scroll view before adding new stuff
    [self removeAllSubviewsInScrollView];
    
    NSDictionary* selectedHours = [self.hours hoursWithTitle: title];
    NSArray* hours = [selectedHours objectForKey: @"hours"];
    //self.scrollHours.frame = CGRectMake(X_COOR_OF_PAGE, Y_COOR_OF_PAGE, WIDTH_OF_PAGE, HEIGHT_OF_PAGE);
    
    if (hours) {
        self.scrollHours.bounces = YES;
        NSArray* indicesOfUniqueHours = [self arrayOfUniqueIndices: hours];
        NSArray *scrollTitles = [self titlesForArrayOfUniqueIndices: indicesOfUniqueHours];
        NSInteger numberOfPages = [scrollTitles count];
        
        //set up the frame and content size of the scroll view
        
        self.scrollHours.contentSize = CGSizeMake(WIDTH_OF_PAGE * numberOfPages, HEIGHT_OF_PAGE);
        
        //set up the page controls for the scroll view
        self.pageControl.numberOfPages = numberOfPages;
        
        //add the subviews to the scroll view
        for (size_t i = 0; i < [scrollTitles count]; ++i) {
        
            
            UILabel* titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(X_COOR_OF_TITLE_LABEL + i*WIDTH_OF_PAGE, Y_COOR_OF_TITLE_LABEL , WIDTH_OF_TITLE_LABEL, HEIGHT_OF_TITLE_LABEL)];
            
            titleLabel.text = [scrollTitles objectAtIndex: i];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.scrollHours addSubview: titleLabel];
            [self viewWasAddedToScrollView: titleLabel]; //need to keep track of added views to remove later
            
            UILabel* hoursLabel = [[UILabel alloc] initWithFrame: CGRectMake(X_COOR_OF_HOURS_LABEL + i* WIDTH_OF_PAGE, Y_COOR_OF_HOURS_LABEL, WIDTH_OF_HOURS_LABEL, HEIGHT_OF_HOURS_LABEL)];
            
            hoursLabel.text = [hours objectAtIndex: [[indicesOfUniqueHours objectAtIndex: i] intValue]];
            hoursLabel.textColor = [UIColor whiteColor];
            hoursLabel.backgroundColor = [UIColor clearColor];
            hoursLabel.textAlignment = NSTextAlignmentCenter;
            [self.scrollHours addSubview: hoursLabel];
            [self viewWasAddedToScrollView: hoursLabel]; //need to keep track of added views to remove later
        }
    } else { //could not find hours
        
        self.scrollHours.contentSize = self.scrollHours.frame.size;
        self.scrollHours.bounces = NO;
        UILabel *errorLabel = [[UILabel alloc] initWithFrame: CGRectMake(X_COOR_OF_TITLE_LABEL, Y_COOR_OF_TITLE_LABEL, WIDTH_OF_TITLE_LABEL, HEIGHT_OF_TITLE_LABEL)];
        errorLabel.textColor = [UIColor whiteColor];
        errorLabel.backgroundColor = [UIColor clearColor];
        errorLabel.textAlignment = NSTextAlignmentCenter;
        if ([[selectedHours objectForKey: @"closed"] boolValue]) { //currently closed
            errorLabel.text = @"CLOSED";
        } else { //hours not added to the plist
            errorLabel.text = @"Hours Not Available";
        }
        
        [self.scrollHours addSubview: errorLabel];
        [self viewWasAddedToScrollView: errorLabel];
        self.pageControl.numberOfPages = 1;
    }
    

}

/////////////////////////
//scroll view delegate//
////////////////////////

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollHours) { //make sure that the correct scroll view is called, not table view
        self.indexOfScroll = scrollView.contentOffset.x / WIDTH_OF_PAGE;
        self.pageControl.currentPage = self.indexOfScroll;
    }
}




@end
