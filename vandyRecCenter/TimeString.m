//
//  TimeString.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "TimeString.h"

@implementation TimeString

@synthesize isAM = _isAM;
@synthesize hours = _hours;
@synthesize minutes = _minutes;
@synthesize style = _style;

#pragma mark - Initializer
- (id) initWithTimeString:(NSString *)timeString {
    self = [super init];
    if (self) {
        if ([TimeString validTimeString:timeString]) {
            //the object at the first index has the hours
            //the second index still needs to be parsed 
            NSArray *firstBreak = [timeString componentsSeparatedByString: @":"];
            
            //hours
            NSUInteger hours = [[firstBreak objectAtIndex: 0] intValue];
            //get the minutes
            self.minutes = [[[firstBreak objectAtIndex: 1] substringToIndex: 2] intValue];
            if ([[firstBreak objectAtIndex: 1] length] == 2) {
                
                //no ampm indications so the time is in military
                if (hours > 12) {
                    self.isAM = NO;
                    self.hours = hours - 12;
                } else if (hours == 0) {
                    self.isAM = YES;
                    self.hours = 12;
                } else {
                    self.isAM = YES;
                    self.hours = hours;
                }
                
            } else {
                //not in military time with ampm indicator
                self.hours = hours;
                NSString* indicator = [[firstBreak objectAtIndex: 1] substringFromIndex: 2];
                if ([indicator characterAtIndex: 0] == ' ') {
                    indicator = [indicator substringFromIndex: 1];
                }
                if ([[indicator uppercaseString] isEqualToString: @"AM"]) {
                    self.isAM = YES;
                } else {
                    self.isAM = NO;
                }
            }
        }
        self.style = TimeStringStyleAMPM;
    }
    return self;
}

#pragma mark - Public
- (NSString*) stringValue {
    NSString* returnString = [[NSString alloc] init];
    
    if (self.style == TimeStringStyleMilitary && !self.isAM) {
        returnString = [returnString stringByAppendingFormat: @"%i:%i", (self.hours + 12) % 24, self.minutes];
    } else {
        returnString = [returnString stringByAppendingFormat: @"%i:%i", self.hours, self.minutes];
    }
    
    NSString* indicator;
    if (self.style == TimeStringStyleAMPM) {
        if (self.isAM) {
            indicator = @"am";
        } else {
            indicator = @"pm";
        }
        returnString = [returnString stringByAppendingString: indicator];
        
    } else if (self.style == TimeStringStyleAMPMSpaced) {
        if (self.isAM) {
            indicator = @" am";
            
        } else {
            indicator = @" pm";
        }
        returnString = [returnString stringByAppendingString: indicator];
    }
    
    return returnString;
}
- (NSString*) description {
    return [self stringValue];
}
#pragma mark  Validation
+ (BOOL) validTimeString:(NSString *)timeString {
    return YES;
}
@end
