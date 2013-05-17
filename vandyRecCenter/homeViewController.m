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

@synthesize scrollView = _scrollView;
@synthesize leftScroller = _leftScroller;
@synthesize rightScroller = _rightScroller;

#pragma - events

- (IBAction) scrollLeft {}
- (IBAction) scrollRight {}


- (void) viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidLayoutSubviews {
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.scrollView.frame.size.height);
    
    [self addPageToScrollViewAtIndex: 0 withInterfaceOrientation: nil];
    [self addPageToScrollViewAtIndex: 1 withInterfaceOrientation: nil];
}


#pragma mark - set up views

- (void) addPageToScrollViewAtIndex: (NSUInteger) index withInterfaceOrientation: (UIInterfaceOrientation) orientation {
    
    CGRect frameOfPage = CGRectMake((self.scrollView.frame.size.width - DIMENSIONS_OF_PAGE)/2.0 + (index *self.view.frame.size.width), (self.scrollView.frame.size.height - DIMENSIONS_OF_PAGE)/2.0, DIMENSIONS_OF_PAGE, DIMENSIONS_OF_PAGE);
    
    UIView* page = [[UIView alloc] initWithFrame: frameOfPage];
    page.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview: page];
}

#pragma mark - manage rotations

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {


}

@end
