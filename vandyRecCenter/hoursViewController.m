//
//  hoursViewController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/3/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "hoursViewController.h"

@interface hoursViewController()

@property (nonatomic, strong, readonly) NSArray* hours;

//should this be a strong pointer?
@property (nonatomic, strong) NSDictionary* currentHoursToDisplay;
@end


@implementation hoursViewController

@synthesize tableView = _tableView;
@synthesize hoursModel = _hoursModel;
@synthesize hours = _hours;

///////////////////////////////////
//custom getters and setters///////
/////////////////////////////////

- (NSArray*) hours {
    if (_hours == nil) {
        NSString *pathToHours = [[NSBundle mainBundle] pathForResource: @"hours" ofType: @"plist"];
        _hours = [[NSArray alloc] initWithContentsOfFile: pathToHours];
    }
    return _hours;
}

- (hoursModel*) hoursModel {
    if (!_hoursModel) {
        NSString *path = [[NSBundle mainBundle] pathForResource: @"hours" ofType:@"plist"];
        _hoursModel = [[hoursModel alloc] initWithPathToPList: path];
    }
    return _hoursModel;
}

- (void) viewDidLoad {
    
    //is this the best place to set this?
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setUpScrollView];
}

//table view stuff

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier: @"hoursCell"];
    
    if (cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"hoursCell"];
    }
   
    if (indexPath.section == 0) {
    
        
         NSString* title = [[[self.hoursModel getAllMainHours] objectAtIndex:indexPath.row] objectForKey: @"title"];
        
        NSDate* startDate = [[[self.hoursModel getAllMainHours] objectAtIndex:indexPath.row] objectForKey: @"beginningDate"];
        NSDate *endDate = [[[self.hoursModel getAllMainHours] objectAtIndex:indexPath.row] objectForKey: @"endDate"];
        
        [ (UILabel*) [cell viewWithTag: 2] setText: title];
        
        [(UILabel *) [cell viewWithTag: 3] setText: [self getDateStringWithStartDate: startDate andEndDate:endDate] ];
    } else if (indexPath.section == 1) {
        
        NSString* title = [[[self.hoursModel getAllOtherHours] objectAtIndex:indexPath.row] objectForKey: @"title"];
        
        NSDate *startDate = [[[self.hoursModel getAllOtherHours] objectAtIndex:indexPath.row] objectForKey: @"beginningDate"];
        NSDate *endDate = [[[self.hoursModel getAllOtherHours] objectAtIndex:indexPath.row] objectForKey: @"endDate"];
        
        
        [ (UILabel*) [cell viewWithTag: 2] setText: title];
         [(UILabel *) [cell viewWithTag: 3] setText: [self getDateStringWithStartDate: startDate andEndDate:endDate] ];
        
    } else  {//last section
    
        NSString* title = [[[self.hoursModel getAllClosedHours] objectAtIndex:indexPath.row] objectForKey: @"title"];
        NSDate *startDate = [[[self.hoursModel getAllClosedHours] objectAtIndex:indexPath.row] objectForKey: @"beginningDate"];
        NSDate *endDate = [[[self.hoursModel getAllClosedHours] objectAtIndex:indexPath.row] objectForKey: @"endDate"];
        
        
        [ (UILabel*) [cell viewWithTag: 2] setText: title];
        [(UILabel *) [cell viewWithTag: 3] setText: [self getDateStringWithStartDate: startDate andEndDate:endDate] ];
    }
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
    
        return [[self.hoursModel getAllMainHours] count];
    } else if (section == 1) {
    
        return [[self.hoursModel getAllOtherHours] count];
    } else {
        return [[self.hoursModel getAllClosedHours] count];
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
 
- (NSString*) getDateStringWithStartDate: (NSDate*) startDate andEndDate: (NSDate*) endDate {
    
    NSDateFormatter *formatDate = [[NSDateFormatter alloc] init];
    formatDate.dateStyle = NSDateFormatterMediumStyle;
    NSString* semiFormattedStartDate = [formatDate stringFromDate: startDate];
    NSString *semiFormattedEndDate = [formatDate stringFromDate: endDate];
    
    NSString *formattedStartDate = [semiFormattedStartDate substringWithRange: NSMakeRange(0, [semiFormattedEndDate length] - 6)];
    NSString *formattedEndDate = [semiFormattedEndDate substringWithRange: NSMakeRange(0, [semiFormattedEndDate length] - 6)];
    
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


@end
