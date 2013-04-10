//
//  hoursModel.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate-MyDateClass.h"

@interface hoursModel : NSObject

@property (nonatomic, strong) NSArray* allHours;

//this is the default initializer
//sets selected hours to the first intance of hours that it sees in the pList
- (id) initWithPathToPList: (NSString*) path;
- (id) init;


//these methods all return an array of size 0
//if nothing could be found
- (NSArray*) getAllClosedHours;
- (NSArray*) getAllOpenHours;
- (NSArray*) getAllMainHours;
- (NSArray*) getAllOtherHours; //hours that are not main hours or closed hours

//methods dealing with the current time
- (NSDictionary*) getHoursForCurrentTime; //compresses hours
- (NSString*) getOpenningTime; //formatted as 12:00 AM, returns nil if it is closed all day
- (NSString*) getClosingTime; //formatted as 12:00 AM, returns nil if it is closed all day

//checks the status of the rec center with respect to the current time
- (BOOL) isOpen;
- (BOOL) willOpenLaterToday; //NO if it is currently open
- (BOOL) wasOpenEarlierToday; //NO if it is currently open

- (NSTimeInterval) timeUntilOpen; //returns 0 when the rec center is open
- (NSTimeInterval) timeUntilClosed;//returns 0 when the rec center is closed

@end
