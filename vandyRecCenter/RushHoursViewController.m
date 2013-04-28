//
//  RushHoursViewController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/28/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "RushHoursViewController.h"

@interface RushHoursViewController ()

@end

@implementation RushHoursViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) exit {
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
