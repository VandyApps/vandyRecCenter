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

@end


@implementation hoursViewController

//private properties
@synthesize currentHoursToDisplay = _currentHoursToDisplay;
@synthesize rowOfCurrentHours = _rowOfCurrentHours;
@synthesize sectionOfCurrentHours = _sectionOfCurrentHours;
@synthesize rowOfSelectedCell = _rowOfSelectedCell;
@synthesize sectionOfSelectedCell = _sectionOfSelectedCell;

//public properties
@synthesize hours = _hours;

//UI properties
@synthesize tableView = _tableView;
@synthesize remainingTime = _remainingTime;
@synthesize titleDisplay = _titleDisplay;

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


/////////////////////
//loading the view///
////////////////////

- (void) viewDidLoad {
    
    //is this the best place to set this?
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setUpScrollView];
    
}

- (void) viewDidAppear:(BOOL)animated {
  
    //set the remaining time label
    [self refreshRemainingTime];
    //make the selected cell the current hours
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
    
    self.titleDisplay.text = title;
    
    //change color of gradient here
    self.sectionOfSelectedCell = indexPath.section;
    self.rowOfSelectedCell = indexPath.row;
    [tableView reloadData];
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
- (void) setUpScrollView {
    
    
    self.scrollHours.frame = CGRectMake(X_COOR_OF_PAGE, Y_COOR_OF_PAGE, WIDTH_OF_PAGE, HEIGHT_OF_PAGE);
    
    self.scrollHours.contentSize = CGSizeMake(WIDTH_OF_PAGE * NUM_OF_PAGES, HEIGHT_OF_PAGE);
    
    self.scrollHours.backgroundColor = [UIColor whiteColor];
    
    UILabel* tempLabel = [[UILabel alloc] initWithFrame: CGRectMake(X_COOR_OF_TITLE_LABEL, Y_COOR_OF_TITLE_LABEL, WIDTH_OF_TITLE_LABEL, HEIGHT_OF_TITLE_LABEL)];
    
    tempLabel.text = @"Title here";
    [self.scrollHours addSubview: tempLabel];
    
    
    UILabel* anotherLabel = [[UILabel alloc] initWithFrame: CGRectMake(X_COOR_OF_TITLE_LABEL + WIDTH_OF_PAGE, Y_COOR_OF_TITLE_LABEL, WIDTH_OF_TITLE_LABEL, HEIGHT_OF_TITLE_LABEL)];
    
    anotherLabel.text = @"Title here";
    [self.scrollHours addSubview: anotherLabel];

}


//////////////////////
//view related setup//
//////////////////////

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
@end
