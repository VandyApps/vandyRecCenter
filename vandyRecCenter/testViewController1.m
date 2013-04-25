//
//  testViewController1.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/23/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "testViewController1.h"

@interface testViewController1 ()

@end

@implementation testViewController1

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
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel* aLabel = [[UILabel alloc] initWithFrame: CGRectMake(140, 20, 100, 50)];
    aLabel.text = @"I am a label";
    [self.view addSubview: aLabel];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
