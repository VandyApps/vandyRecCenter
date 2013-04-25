//
//  homeViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 3/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//@property (strong, nonatomic) IBOutlet UIImageView *imageOfRec;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
