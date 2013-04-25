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

//@synthesize imageOfRec = _imageOfRec;
@synthesize tableView = _tableView;

#pragma - Getters and Setters
/*
- (UIImageView*) imageOfRec {
    if (!_imageOfRec || _imageOfRec.image == nil) {
        NSLog(@"calling getter");
       // _imageOfRec = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"imageOfRec.jpeg"]];
       // _imageOfRec.frame = CGRectMake(0, 0, 320, 243);
        //_imageOfRec.contentMode = UIViewContentModeScaleToFill;
        
    }
    if (_imageOfRec.contentMode != UIViewContentModeScaleToFill) {
        NSLog(@"Not equal to scale to fill");
    }
    return _imageOfRec;
    
}
 */

#pragma - LifeCycle

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

#pragma - Table View Data Source and Delegate

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

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"Change in orientation was called");
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        
        //[self.imageOfRec removeFromSuperview];
        
       
    } else {
        
       // [self.view addSubview: self.imageOfRec];
    }
}

@end
