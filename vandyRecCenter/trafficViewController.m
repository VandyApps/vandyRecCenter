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
    [self scrollViewSetUp];
        
}

//setting up the scroll view
- (void) scrollViewSetUp {
    self.scrollGraphs.contentSize = self.scrollGraphs.frame.size;
    UIView* graphView = [[UIView alloc] initWithFrame: CGRectMake(X_COOR_OF_GRAPH, Y_COOR_OF_GRAPH, WIDTH_OF_GRAPH, HEIGHT_OF_GRAPH)];
    graphView.layer.cornerRadius = 5;
    graphView.backgroundColor = [UIColor whiteColor];
    [self.scrollGraphs addSubview: graphView];

}

//setting up the graph (within the scroll view)
- (void) graphViewSetUp {

}
@end
