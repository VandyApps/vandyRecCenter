//
//  homeViewController.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 3/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIColor-BMColors.h"
#import "NewsModel.h"

@interface homeViewController : UIViewController <UIScrollViewDelegate>

#define ARROW_BORDER_PADDING 10
#define ARROW_DIMENSIONS 20

#define DIMENSIONS_OF_PAGE_PORTRAIT 220
#define DIMENSIONS_OF_PAGE_LANDSCAPE 180

#define LABEL_DIMENSIONS_PORTRAIT 190
#define LABEL_DIMENSIONS_LANDSCAPE 130
#define DESCRIPTION_FONT_SIZE_PORTRAIT 18
#define DESCRIPTION_FONT_SIZE_LANDSCAPE 15

#define LOGO_DIMENSIONS_PORTRAIT 40
#define LOGO_DIMENSIONS_LANDSCAPE 40
#define LOGO_Y_COOR_PORTRAIT 10
#define LOGO_Y_COOR_LANDSCAPE 10

@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;

@property (nonatomic, strong) UIButton *leftScroller;
@property (nonatomic, strong) UIButton *rightScroller;

- (IBAction) scrollLeft;
- (IBAction) scrollRight;

@end
