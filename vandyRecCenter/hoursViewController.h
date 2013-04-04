//
//  hoursViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/3/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hoursViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleDisplay;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollHours;
@property (weak, nonatomic) IBOutlet UILabel *remainingTime;

@property (weak, nonatomic) IBOutlet UITextView *hoursDisplay;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
