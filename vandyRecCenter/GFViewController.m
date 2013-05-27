//
//  GFViewController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFViewController.h"
#import "GFCollection.h"
@interface GFViewController ()

@end

@implementation GFViewController
@synthesize GFTabs = _GFTabs;
@synthesize model = _model;

#pragma mark - getters

- (GFModel*) model {
    if (_model == nil) {
        _model = [[GFModel alloc] init];
    }
    return _model;
}

#pragma mark - initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.GFTabs.layer.cornerRadius = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
