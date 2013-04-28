//
//  trafficViewController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/13/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "trafficViewController.h"

@implementation trafficViewController


// UI properties
@synthesize pageControl = _pageControl;
@synthesize dateLabel = _dateLabel;
@synthesize scrollGraphs = _scrollGraphs;


- (void) viewDidLoad {
    //temp set up of scroll view here
    [self.view addSubview: [self graphOuterView]];
}

//setting up the scroll view
- (UIView*) graphOuterView {
    
    self.scrollGraphs.contentSize = self.scrollGraphs.frame.size;
    CGFloat xValueOfGraphView = (self.view.frame.size.width - WIDTH_OF_GRAPH_VIEW) / 2.0;
    UIView* graphOuterView = [[UIView alloc] initWithFrame: CGRectMake(xValueOfGraphView, Y_COOR_OF_GRAPH_VIEW, WIDTH_OF_GRAPH_VIEW, HEIGHT_OF_GRAPH_VIEW)];
    graphOuterView.layer.cornerRadius = 5;
    graphOuterView.layer.borderWidth = 5;
    graphOuterView.layer.borderColor = [[UIColor vanderbiltGold] CGColor];
    graphOuterView.backgroundColor = [UIColor whiteColor];
    
    //[graphOuterView addSubview: [self graphInnerView]];
    return graphOuterView;

}

- (UIView*) graphInnerView {

    UIView* graphInnerView;
    
    return graphInnerView;
}


@end
