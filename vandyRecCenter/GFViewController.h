//
//  GFViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GFModel.h"

@interface GFViewController : UIViewController

@property (nonatomic, weak) IBOutlet UISegmentedControl* GFTabs;
@property (nonatomic, strong) GFModel *model;
@end
