//
//  homeViewController.m
// 
//
//  Created by Brendan McNamara on 3/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "homeViewController.h"

@interface homeViewController ()

@property (nonatomic, strong) NSArray* pagesInScrollView;
@end

@implementation homeViewController

@synthesize scrollView = _scrollView;
@synthesize leftScroller = _leftScroller;
@synthesize rightScroller = _rightScroller;

@synthesize pagesInScrollView = _pagesInScrollView;

#pragma - getters

- (NSArray*) pagesInScrollView {
    if (_pagesInScrollView == nil) {
        _pagesInScrollView = [[NSArray alloc] init];
    }
    return _pagesInScrollView;
}


#pragma - events

- (IBAction) scrollLeft {}
- (IBAction) scrollRight {}


- (void) viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidLayoutSubviews {
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.scrollView.frame.size.height);
    
    [self setScrollViewSubviews];
    
}


#pragma mark - manage views

- (void) setScrollViewSubviews {
    [self removeAllViewsFromScrollView];
    [self addPageToScrollViewAtIndex: 0 hideScrollersInPortraitOrientation: NO];
    [self addPageToScrollViewAtIndex: 1 hideScrollersInPortraitOrientation: NO];
}


//hideScrollers determines if the scrollers are to be hidden when in portriat orientation
//scrollers are always hidden in landscape orientation and should be hidden
//in portrait orientation only when there is only a single page to display
- (void) addPageToScrollViewAtIndex: (NSUInteger) index hideScrollersInPortraitOrientation: (BOOL) hideScrollers{
    
    CGRect frameOfPage;
    if (UIInterfaceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
        
        frameOfPage = CGRectMake((self.scrollView.frame.size.width - DIMENSIONS_OF_PAGE_PORTRAIT)/2.0 + (index *self.view.frame.size.width), (self.scrollView.frame.size.height - DIMENSIONS_OF_PAGE_PORTRAIT)/2.0, DIMENSIONS_OF_PAGE_PORTRAIT, DIMENSIONS_OF_PAGE_PORTRAIT);
        NSLog(@"In portrait mode");
        if (hideScrollers) {
            self.leftScroller.hidden = YES;
            self.rightScroller.hidden = YES;
        } else {
            self.leftScroller.hidden = NO;
            self.rightScroller.hidden = NO;
        }
        
    } else {
        NSLog(@"Landscape is called");
        //for now, add height translation in landscape orientation
        frameOfPage = CGRectMake((self.scrollView.frame.size.width - DIMENSIONS_OF_PAGE_LANDSCAPE)/2.0 + (index *self.view.frame.size.width), (self.scrollView.frame.size.height - DIMENSIONS_OF_PAGE_LANDSCAPE)/2.0 + 10, DIMENSIONS_OF_PAGE_LANDSCAPE, DIMENSIONS_OF_PAGE_LANDSCAPE);
        
        self.leftScroller.hidden = YES;
        self.rightScroller.hidden = YES;
        
    }
    UIView* page = [[UIView alloc] initWithFrame: frameOfPage];
    page.backgroundColor = [UIColor vanderbiltGold];
    page.layer.borderWidth = 2.f;
    page.layer.borderColor = [[UIColor whiteColor] CGColor];
    page.layer.cornerRadius = 5.f;
    
    [self.scrollView addSubview: page];
    self.pagesInScrollView = [self.pagesInScrollView arrayByAddingObject: page];
}
- (void) removeAllViewsFromScrollView {
    for (UIView* view in self.pagesInScrollView) {
        [view removeFromSuperview];
    }
    self.pagesInScrollView = [[NSArray alloc] init];
}

#pragma mark - manage rotations

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

    NSLog(@"This method is called");

}

@end
