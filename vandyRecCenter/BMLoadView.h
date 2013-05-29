//
//  BMLoadView.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BMLoadView : UIView

#define BM_LOADVIEW_DIMENSION 150
#define BM_TITLE_WIDTH 100
#define BM_TITLE_HEIGHT 30
#define BM_TITLE_Y 10
#define BM_INDICATOR_Y_CENTER 90

- (id) initWithParent: (UIView*) parent;
//display methods
- (void) show;
- (void) hide;
- (void) toggle;

//animation methods
- (void) start;
- (void) stop;
@end
