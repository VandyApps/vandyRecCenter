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
@property (nonatomic, readonly) NSUInteger selectedHours; //index of NSArray for the hours selected
//@property (nonatomic, strong) NSString* path; //set in the initializer

//this is the default initializer
//sets selected hours to the first intance of hours that it sees in the pList
- (id) initWithPathToPList: (NSString*) path;
- (id) init;

//returns true if it was able to locate the
//hours with the selected title
- (BOOL) selectHoursWithTitle: (NSString*) title;


//these methods all return an array of size 0
//if nothing could be found
- (NSArray*) getAllClosedHours;
- (NSArray*) getAllOpenHours;
- (NSArray*) getAllMainHours;
- (NSArray*) getAllOtherHours; //hours that are not main hours

//methods dealing with the current time
- (NSDictionary*) getHoursForCurrentTime;
- (NSString*) getOpenningTime; //formatted as 12:00 AM, returns nil if it is closed all day
- (NSString*) getClosingTime; //formatted as 12:00 AM, returns nil if it is closed all day
- (BOOL) isOpen;
- (BOOL) isClosed;
- (NSTimeInterval) timeUntilOpen;
- (NSTimeInterval) timeUntilClosed;

@end
