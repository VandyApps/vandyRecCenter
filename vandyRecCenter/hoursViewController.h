//
//  hoursViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/3/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hoursModel.h"

//macros for scroll view
#define NUM_OF_PAGES 7
#define HEIGHT_OF_PAGE 80
#define WIDTH_OF_PAGE 320
#define X_COOR_OF_PAGE 0
#define Y_COOR_OF_PAGE 59

//macros for elements inside a single page

//title label
#define X_COOR_OF_TITLE_LABEL 110
#define Y_COOR_OF_TITLE_LABEL 10
#define HEIGHT_OF_TITLE_LABEL 30
#define WIDTH_OF_TITLE_LABEL 100
//hours label


@interface hoursViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleDisplay;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollHours;
@property (weak, nonatomic) IBOutlet UILabel *remainingTime;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) hoursModel* hoursModel;
@end
