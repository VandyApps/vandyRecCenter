//
//  HoursScrollView.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate-MyDateClass.h"
#import "NSDate-WeekDateClass.h"


//title label

#define Y_COOR_OF_TITLE_LABEL 10
#define HEIGHT_OF_TITLE_LABEL 25
#define WIDTH_OF_TITLE_LABEL 250
//hours label
#define Y_COOR_OF_HOURS_LABEL 40
#define HEIGHT_OF_HOURS_LABEL 35
#define WIDTH_OF_HOURS_LABEL 250
//button views
#define X_COOR_OF_LEFT_BUTTON 50
#define X_COOR_OF_RIGHT_BUTTON 257.5
#define Y_COOR_OF_BUTTON 35
#define HEIGHT_OF_BUTTON 10
#define WIDTH_OF_BUTTON 10
//error label

#define Y_COOR_OF_ERROR_LABEL 35
#define HEIGHT_OF_ERROR_LABEL 25
#define WIDTH_OF_ERROR_LABEL 250

//images
#define IMAGE_CELL_SELECTED @"blue.png"
#define IMAGE_CELL_NORMAL @"blackGradient.png"
#define IMAGE_SECTION_HEAD @"goldTint.png"

@interface HoursScrollView : UIScrollView

- (NSUInteger) setUpScrollViewWithHours: (NSDictionary*) hours;
- (NSArray*) arrayOfUniqueIndices: (NSArray*) hours;
- (void) removeAllSubviews;
@end
