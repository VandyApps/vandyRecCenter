//
//  HoursModel.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/14/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate-MyDateClass.h"
#import "NSDate-WeekDateClass.h"

@interface HoursModel : NSObject

//this is the default initializer
//sets selected hours to the first intance of hours that it sees in the pList
- (id) initWithPathToPList: (NSString*) path;
- (id) init;

- (NSDictionary*) hoursWithTitle: (NSString*) title;

//these methods all return an array of size 0
//if nothing could be found
- (NSArray*) closedHours;
- (NSArray*) openHours;
- (NSArray*) mainHours;
- (NSArray*) otherHours; //hours that are not main hours or closed hours

//methods dealing with the current time
- (NSDictionary*) hoursForCurrentTime; //compresses hours
- (NSString*) openingTime; //formatted as 12:00 AM, returns nil if it is closed all day
- (NSString*) closingTime; //formatted as 12:00 AM, returns nil if it is closed all day

//checks the status of the rec center with respect to the current time
- (BOOL) isOpen;
- (BOOL) willOpenLaterToday; //NO if it is currently open
- (BOOL) wasOpenEarlierToday; //NO if it is currently open

- (NSTimeInterval) timeUntilOpen; //returns 0 when the rec center is open
- (NSTimeInterval) timeUntilClosed;//returns 0 when the rec center is closed
@end
