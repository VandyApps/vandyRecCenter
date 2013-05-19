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
@property (nonatomic, assign) NSUInteger indexOfScroll;
@property (nonatomic, strong) NewsModel* newsModel;
@end

@implementation homeViewController

@synthesize indexOfScroll = _indexOfScroll;

@synthesize scrollView = _scrollView;
@synthesize leftScroller = _leftScroller;
@synthesize rightScroller = _rightScroller;

@synthesize pagesInScrollView = _pagesInScrollView;
@synthesize newsModel = _newsModel;

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
    self.scrollView.delegate = self;
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
    
    //set up offset
    [self.scrollView setContentOffset: CGPointMake(self.indexOfScroll * self.view.frame.size.width, 0) animated: YES];
}


//hideScrollers determines if the scrollers are to be hidden when in portriat orientation
//scrollers are always hidden in landscape orientation and should be hidden
//in portrait orientation only when there is only a single page to display
- (void) addPageToScrollViewAtIndex: (NSUInteger) index hideScrollersInPortraitOrientation: (BOOL) hideScrollers {
    
    CGRect frameOfPage;
    CGRect frameOfLabel;
   // CGRect frameOfLogo;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        
        frameOfPage = CGRectMake((self.scrollView.frame.size.width - DIMENSIONS_OF_PAGE_PORTRAIT)/2.0 + (index *self.view.frame.size.width), (self.scrollView.frame.size.height - DIMENSIONS_OF_PAGE_PORTRAIT)/2.0, DIMENSIONS_OF_PAGE_PORTRAIT, DIMENSIONS_OF_PAGE_PORTRAIT);
        
        frameOfLabel = CGRectMake((DIMENSIONS_OF_PAGE_PORTRAIT - LABEL_DIMENSIONS_PORTRAIT)/2.0, (DIMENSIONS_OF_PAGE_PORTRAIT - LABEL_DIMENSIONS_PORTRAIT)/2.0, LABEL_DIMENSIONS_PORTRAIT, LABEL_DIMENSIONS_PORTRAIT);
        
        /*
         frameOfLogo = CGRectMake((DIMENSIONS_OF_PAGE_PORTRAIT - LOGO_DIMENSIONS_PORTRAIT)/2.0, LOGO_Y_COOR_PORTRAIT, LOGO_DIMENSIONS_PORTRAIT, LOGO_DIMENSIONS_PORTRAIT);*/
        
        if (hideScrollers) {
            self.leftScroller.hidden = YES;
            self.rightScroller.hidden = YES;
        } else {
            self.leftScroller.hidden = NO;
            self.rightScroller.hidden = NO;
        }
        
    } else {
        
        //for now, add height translation in landscape orientation
        frameOfPage = CGRectMake((self.scrollView.frame.size.width - DIMENSIONS_OF_PAGE_LANDSCAPE)/2.0 + (index *self.view.frame.size.width), (self.scrollView.frame.size.height - DIMENSIONS_OF_PAGE_LANDSCAPE)/2.0 + 10, DIMENSIONS_OF_PAGE_LANDSCAPE, DIMENSIONS_OF_PAGE_LANDSCAPE);
        
        frameOfLabel = CGRectMake((DIMENSIONS_OF_PAGE_LANDSCAPE - LABEL_DIMENSIONS_LANDSCAPE)/2.0, (DIMENSIONS_OF_PAGE_LANDSCAPE - LABEL_DIMENSIONS_LANDSCAPE)/2.0, LABEL_DIMENSIONS_LANDSCAPE, LABEL_DIMENSIONS_LANDSCAPE);
        
        /*
        frameOfLogo = CGRectMake((DIMENSIONS_OF_PAGE_LANDSCAPE - LOGO_DIMENSIONS_LANDSCAPE)/2.0, LOGO_Y_COOR_LANDSCAPE, LOGO_DIMENSIONS_LANDSCAPE, LOGO_DIMENSIONS_LANDSCAPE);
        */
        
        self.leftScroller.hidden = YES;
        self.rightScroller.hidden = YES;
        
    }
    
    UIView* page = [[UIView alloc] initWithFrame: frameOfPage];
    page.backgroundColor = [UIColor vanderbiltGold];
    page.layer.borderWidth = 2.f;
    page.layer.borderColor = [[UIColor whiteColor] CGColor];
    page.layer.cornerRadius = 5.f;
    
    UILabel* descriptionLabel = [[UILabel alloc] initWithFrame: frameOfLabel];
    descriptionLabel.text = @"Here is where the text goes. If someone wanted to write something very long, this should be taking up to about three lines of space.  No one should type more than that";
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.numberOfLines = 8;
    descriptionLabel.font = [UIFont systemFontOfSize: 15];
    
    [page addSubview: descriptionLabel];
    
    
    [self.scrollView addSubview: page];
    self.pagesInScrollView = [self.pagesInScrollView arrayByAddingObject: page];
}
- (void) removeAllViewsFromScrollView {
    for (UIView* view in self.pagesInScrollView) {
        [view removeFromSuperview];
    }
    self.pagesInScrollView = [[NSArray alloc] init];
}

#pragma mark - scroll delegate

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.indexOfScroll = self.view.frame.size.width / self.scrollView.contentOffset.x;
    
}
@end
