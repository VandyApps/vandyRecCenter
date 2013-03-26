//
//  browserViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 3/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface browserViewController : UIViewController

#define REC_URL @"http://www.vanderbilt.edu/studentrec/"

@property (nonatomic, weak) IBOutlet UIWebView *homePageForRec;
@end
