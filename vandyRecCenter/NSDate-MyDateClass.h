//
//  NSDate-MyDateClass.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(MyDateClass)


//classes for retrieving the day of the week
- (NSUInteger) dayOfTheWeekAsInt;
- (NSString*) dayOfTheWeekAsString;
- (NSString*) dayOfTheWeekForIndex: (NSInteger) index;
@end
