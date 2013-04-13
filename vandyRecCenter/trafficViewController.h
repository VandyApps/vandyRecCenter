//
//  trafficViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/13/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface trafficViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView* scrollGraphs;
@property (nonatomic, weak) IBOutlet UIPageControl* pageControl;
@property (nonatomic, weak) IBOutlet UILabel* dateLabel;

- (IBAction) scrollOnePageLeft;
- (IBAction) scrollOnePageRight;

@end
