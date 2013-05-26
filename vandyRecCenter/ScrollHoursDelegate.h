//
//  ScrollHoursDelegate.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScrollHoursDelegate <NSObject>

- (NSDictionary*) hoursForFrameChange: (CGRect) newFrame;

@end
