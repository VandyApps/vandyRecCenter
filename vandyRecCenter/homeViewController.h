//
//  homeViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 3/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;

@property (nonatomic, weak) IBOutlet UIButton *leftScroller;
@property (nonatomic, weak) IBOutlet UIButton *rightScroller;

- (IBAction) scrollLeft;
- (IBAction) scrollRight;

@end
