//
//  TabBarNavigationController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/16/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "TabBarNavigationController.h"

@interface TabBarNavigationController ()

@end

@implementation TabBarNavigationController

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
    [(UIViewController*) [self.viewControllers objectAtIndex: 0] navigationItem].leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"400-list2.png"] style: UIBarButtonItemStyleBordered target: self action: @selector(leftBarButtonClicked)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) leftBarButtonClicked {

    NSLog(@"Button clicked");
    //[self.tabBarDelegate toggleTabBar];
}

@end
