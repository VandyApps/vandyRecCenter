//
//  TimeString.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeStringStyle.h"
//this class is for parsing and validating time strings
//of the following formats:
// 12:00 am
// 6:30am
// 14:37
//if am or pm is not specified, then the time string
//is assumed to be in military time
//there could or could not be a space in between the
//time and the am/pm indication
//am and pm are case insensitive

@interface TimeString : NSObject

@property (nonatomic) BOOL isAM;
@property (nonatomic) NSUInteger hours;
@property (nonatomic) NSUInteger minutes;
@property (nonatomic) TimeStringStyle style;

- (id) initWithTimeString: (NSString*) timeString;

//prints out the string according to the time string style
- (NSString*) timeString;

- (NSUInteger) timeInMinutes;
- (NSUInteger) timeInSeconds;

+ (NSComparisonResult) compareTimeString1: (TimeString*) timeString1 timeString2: (TimeString*) timeString2;
- (NSComparisonResult) compareTimeString: (TimeString*) timeString;

+ (BOOL) validTimeString: (NSString*) timeString;
@end
