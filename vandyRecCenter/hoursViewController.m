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
@synthesize hoursDisplay = _hoursDisplay;
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
   [(UILabel*) [cell viewWithTag: 2] setText:[(NSDictionary*) [self.hours objectAtIndex: indexPath.row] objectForKey: @"title"]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"%u", [self.hours count]);
    return [self.hours count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void) setUpScrollView {
    
    self.scrollHours.frame = CGRectMake(0, 59, 320, 80);
    
    //this is temporary to make debugging easier
    self.scrollHours.backgroundColor = [UIColor whiteColor];
    
    UILabel* dayOfWeek = [[UILabel alloc] init];
    dayOfWeek.frame = CGRectMake(110, 10, 100, 30);
    dayOfWeek.textAlignment = NSTextAlignmentCenter;
    
    
    dayOfWeek.text = @"Monday";
    [self.scrollHours addSubview: dayOfWeek];
    NSLog(@"Height of %g, width of %g, x of %g and y of %g", self.scrollHours.frame.size.height, self.scrollHours.frame.size.width, self.scrollHours.frame.origin.x, self.scrollHours.frame.origin.y);
}


@end
