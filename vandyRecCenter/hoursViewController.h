//
//  hoursViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/3/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hoursModel.h"


//macros
#define DEFAULT_HEIGHT_FOR_CELL 51
//macros for scroll view
#define DEFAULT_NUM_OF_PAGES 7 
#define HEIGHT_OF_PAGE 80
#define WIDTH_OF_PAGE 320
#define X_COOR_OF_PAGE 0
#define Y_COOR_OF_PAGE 59

//macros for elements inside a single page

//title label
#define X_COOR_OF_TITLE_LABEL 35
#define Y_COOR_OF_TITLE_LABEL 10
#define HEIGHT_OF_TITLE_LABEL 25
#define WIDTH_OF_TITLE_LABEL 250
//hours label
#define X_COOR_OF_HOURS_LABEL 35
#define Y_COOR_OF_HOURS_LABEL 40
#define HEIGHT_OF_HOURS_LABEL 35
#define WIDTH_OF_HOURS_LABEL 250
//button views
#define X_COOR_OF_LEFT_BUTTON 50
#define X_COOR_OF_RIGHT_BUTTON 257.5
#define Y_COOR_OF_BUTTON 35
#define HEIGHT_OF_BUTTON 10
#define WIDTH_OF_BUTTON 10

@interface hoursViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *titleDisplay;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollHours;
@property (weak, nonatomic) IBOutlet UILabel *remainingTime;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) hoursModel* hours;

- (IBAction)current:(UIBarButtonItem *)sender;
- (IBAction) scrollOnePageLeft;
- (IBAction) scrollOnePageRight;
@end
