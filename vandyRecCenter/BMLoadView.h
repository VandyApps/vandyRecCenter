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

- (id) initWithParent: (UIView*) parent;
//display methods
- (void) show;
- (void) hide;
- (void) toggle;

//animation methods
- (void) start;
- (void) stop;
@end
