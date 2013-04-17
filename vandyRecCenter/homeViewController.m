//
//  homeViewController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 3/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "homeViewController.h"

@interface homeViewController ()

@end

@implementation homeViewController

@synthesize tableView = _tableView;

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

//////////////////////////
////Table View Protocol///
///////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"homeCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"homeCell"];
        
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //makes cell clickable under the text view

    [[(UITextView*) cell viewWithTag: 2] setUserInteractionEnabled: NO];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //simply segue to the home page of the rec center... does not matter which button is clicked
    [self performSegueWithIdentifier:@"recCenterHomePage" sender: self];
}


@end
