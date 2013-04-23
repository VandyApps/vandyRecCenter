//
//  CustomTabBarController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/23/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "CustomTabBarController.h"

@interface CustomTabBarController ()


@end

@implementation CustomTabBarController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

 */

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //set up view controllers
    //testViewController1 *firstController = [[testViewController1 alloc] init];
   // testViewController2 *secondController = [[testViewController2 alloc] init];
   // self.viewControllers = [[NSArray alloc] initWithObjects: firstController, secondController, nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

//delegate

- (CGSize) tabBarController:(NGTabBarController *)tabBarController sizeOfItemForViewController:(UIViewController *)viewController atIndex:(NSUInteger)index position:(NGTabBarPosition)position {
    
    return CGSizeMake(320, 480);
}

@end
