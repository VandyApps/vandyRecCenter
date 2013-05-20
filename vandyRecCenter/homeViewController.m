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

- (NewsModel*) newsModel {
    if (_newsModel == nil) {
        _newsModel = [[NewsModel alloc] init];
    }
    return _newsModel;
}

#pragma - events

- (IBAction) scrollLeft {}
- (IBAction) scrollRight {}


- (void) viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
}

- (void) viewDidLayoutSubviews {
    NSLog(@"Layout the subviews");
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.scrollView.frame.size.height);
    
    [self setScrollViewSubviews];
    
}


#pragma mark - manage views

//NOTE THAT CALLING REMOVEFROMSUPERVIEW METHOD ON SELF.VIEWS CAUSES THIS METHOD TO AUTOMATICALLY BE CALLED
- (void) setScrollViewSubviews {
    //hide scrollers at the start
    self.leftScroller.hidden = YES;
    self.rightScroller.hidden = YES;
    
    [self removeAllViewsFromScrollView];
    
    UIActivityIndicatorView *connectionIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    connectionIndicator.center = self.view.center;
    [connectionIndicator startAnimating];
    [self.view addSubview: connectionIndicator];
    
    [self.newsModel loadData:^(NSError *error) {
        
        if (error) {
            //should make sure the error message is readable
            UIAlertView *connectionAlert = [[UIAlertView alloc] initWithTitle: @"Error With Internet Connection" message: [error localizedDescription] delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
            [connectionAlert show];
           
        } else {
            BOOL hideScroller = NO;
            if (self.newsModel.news.count == 1) {
                hideScroller = YES;
            }
            for (NSUInteger i = 0; i < self.newsModel.news.count; ++i) {
                [self addPageToScrollViewAtIndex: i hideScrollersInPortraitOrientation: hideScroller];
            }
            
            //set up offset
            [self.scrollView setContentOffset: CGPointMake(self.indexOfScroll * self.view.frame.size.width, 0) animated: YES];
        }
        [connectionIndicator stopAnimating];
        
       
    }];
    
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
    descriptionLabel.text = [self.newsModel.news objectAtIndex: index];
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.numberOfLines = 8;
    descriptionLabel.font = [UIFont systemFontOfSize: 15];
    
    [page addSubview: descriptionLabel];
    
    
    [self.scrollView addSubview: page];
    //keep track of pages so they may be removed when needed
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
