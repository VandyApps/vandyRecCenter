//
//  hoursViewController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/3/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "hoursViewController.h"

@interface hoursViewController()


//should this be a strong pointer?
@property (nonatomic, strong) NSDictionary* currentHoursToDisplay;
@property (nonatomic) NSInteger sectionOfSelectedCell;
@property (nonatomic) NSInteger rowOfSelectedCell;
@property (nonatomic) NSInteger sectionOfCurrentHours;
@property (nonatomic) NSInteger rowOfCurrentHours;
@property (nonatomic, strong, readonly) NSArray* subviewsInScrollView;
@end


@implementation hoursViewController

//private properties
@synthesize currentHoursToDisplay = _currentHoursToDisplay;
@synthesize rowOfCurrentHours = _rowOfCurrentHours;
@synthesize sectionOfCurrentHours = _sectionOfCurrentHours;
@synthesize rowOfSelectedCell = _rowOfSelectedCell;
@synthesize sectionOfSelectedCell = _sectionOfSelectedCell;
@synthesize subviewsInScrollView = _subviewsInScrollView;

//public properties
@synthesize hours = _hours;

//UI properties
@synthesize tableView = _tableView;
@synthesize remainingTime = _remainingTime;
@synthesize titleDisplay = _titleDisplay;
@synthesize scrollHours = _scrollHours;
@synthesize pageControl = _pageControl;


///////////////////////////////////
//custom getters and setters///////
/////////////////////////////////


- (hoursModel*) hours {
    if (!_hours) {
        NSString *path = [[NSBundle mainBundle] pathForResource: @"hours" ofType:@"plist"];
        _hours = [[hoursModel alloc] initWithPathToPList: path];
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

/////////////////////
//loading the view///
////////////////////

- (void) viewDidLoad {
    
    //setting the delegates
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.scrollHours.delegate = self;
    [self setCurrentHours];
}

- (void) viewDidAppear:(BOOL)animated {
  
    //set the remaining time label
    [self refreshRemainingTime];
    //make the selected cell the current hours
    [self selectCurrentHours];
    
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
    //call didSelectRowAtIndexPath?
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
                titles = [titles arrayByAddingObject: [NSString stringWithFormat: @"%@ - %@", [NSDate weekDayAbreviationForIndex: startIndex], [NSDate weekDayAbreviationForIndex:endIndex]]];
                
                
            } else { //there is no range, just a single day
                titles = [titles arrayByAddingObject: [NSDate dayOfTheWeekForIndex:[[arrayOfUniqueIndices objectAtIndex: i] intValue]]];
            }
        } else {
            titles = [titles arrayByAddingObject: [NSDate dayOfTheWeekForIndex: [[arrayOfUniqueIndices objectAtIndex:i] intValue]]];
        }
    }
    return titles;
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
        
        [(UIImageView*) [cell viewWithTag: 1] setImage: [UIImage imageNamed: @"brownGradient.png"]];
    } else {
        [(UIImageView*) [cell viewWithTag: 1] setImage: [UIImage imageNamed: @"blackGradient.png"]];
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

    
    UIImageView *imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"goldGradient.png"]];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title;
    if (indexPath.section == 0) {
    
        title = [[[self.hours mainHours] objectAtIndex: indexPath.row] objectForKey: @"title"];
    } else if (indexPath.section == 1) {
    
         title = [[[self.hours otherHours] objectAtIndex: indexPath.row] objectForKey: @"title"];
    } else {
    
        title = [[[self.hours closedHours] objectAtIndex: indexPath.row] objectForKey: @"title"];
    }
    //set the title in the view
    self.titleDisplay.text = title; 
    //get the array for the hours
    //change color of gradient here
    self.sectionOfSelectedCell = indexPath.section;
    self.rowOfSelectedCell = indexPath.row;
    [tableView reloadData];
    [self setUpScrollViewWithHoursTitle: title];
    
    //move the scroll view offset
    [self.scrollHours setContentOffset: CGPointMake(0, 0) animated:YES];
    self.pageControl.currentPage = 0;
}

/////////////////////
//scroll view stuff//
/////////////////////
 
- (void) setUpScrollViewWithHoursTitle: (NSString*) title {
    
    //clear any existing subviews in the scroll view before adding new stuff
    [self removeAllSubviewsInScrollView];
    
    NSDictionary* selectedHours = [self.hours hoursWithTitle: title];
    NSArray* hours = [selectedHours objectForKey: @"hours"];
    NSArray *scrollTitles = [self titlesForArrayOfUniqueIndices: [self arrayOfUniqueIndices: hours]];
    NSInteger numberOfPages = [scrollTitles count];
    
    //set up the frame and content size of the scroll view
    self.scrollHours.frame = CGRectMake(X_COOR_OF_PAGE, Y_COOR_OF_PAGE, WIDTH_OF_PAGE, HEIGHT_OF_PAGE);
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
        
        UILabel* hoursLabel = [[UILabel alloc] initWithFrame: CGRectMake(X_COOR_OF_HOURS_LABEL + i*WIDTH_OF_PAGE, Y_COOR_OF_HOURS_LABEL, WIDTH_OF_HOURS_LABEL, HEIGHT_OF_HOURS_LABEL)];
        
        hoursLabel.text = [hours objectAtIndex: i];
        hoursLabel.textColor = [UIColor whiteColor];
        hoursLabel.backgroundColor = [UIColor clearColor];
        hoursLabel.textAlignment = NSTextAlignmentCenter;
        [self.scrollHours addSubview: hoursLabel];
        [self viewWasAddedToScrollView: hoursLabel]; //need to keep track of added views to remove later
    }
    

}

/////////////////////////
//scroll view delegate//
////////////////////////

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / 320;
}



@end
