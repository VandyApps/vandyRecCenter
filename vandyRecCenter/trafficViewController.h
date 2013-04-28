//
//  trafficViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/13/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "UIColor-BMColors.h"

//parent scroll view of graph view has width of 320 and height of 220

#define Y_COOR_OF_GRAPH_VIEW 70
#define WIDTH_OF_GRAPH_VIEW 260
#define HEIGHT_OF_GRAPH_VIEW 160



@interface trafficViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView* scrollGraphs;
@property (nonatomic, weak) IBOutlet UIPageControl* pageControl;
@property (nonatomic, weak) IBOutlet UILabel* dateLabel;

- (UIView*) graphOuterView;
- (UIView*) graphInnerView;
- (IBAction) scrollOnePageLeft;
- (IBAction) scrollOnePageRight;

@end
