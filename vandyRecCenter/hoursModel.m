//
//  hoursModel.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "hoursModel.h"

@implementation hoursModel

@synthesize allHours = _allHours;
@synthesize selectedHours = _selectedHours;


//getters and setters
- (id) initWithPathToPList:(NSString *)path {
    
    self = [super init];
    if (self) {
        self.allHours = [[NSArray alloc] initWithContentsOfFile: path];
        
        //make selected hours the current hours
        
    }
    return self;
    
}

- (void) setSelectedHoursWithTitle: (NSString*) title {
    
   
    BOOL foundSelectedObject = NO;
    for (size_t i = 0; i < [self.allHours count] && !foundSelectedObject; ++i) {
        if ([[(NSDictionary*) [self.allHours objectAtIndex: i] objectForKey: @"title"] isEqualToString: title]) {
            _selectedHours = i;
            foundSelectedObject = YES;
        }
    }
}



- (id) init {
    self = [self initWithPathToPList:nil];
    return self;
}

- (BOOL) selectHoursWithTitle:(NSString *)title {
    return NO;
}


- (NSArray*) getAllClosedHours {
    NSArray *closeHours = [[NSArray alloc] init];
    NSEnumerator *enumerateHours = [self.allHours objectEnumerator];
    
    NSDictionary* nextHours;
    while (nextHours = [enumerateHours nextObject]) {
        
        if ([[nextHours objectForKey: @"closed"] boolValue]) {
            closeHours = [closeHours arrayByAddingObject: nextHours];
        }
    }
    return closeHours;
    
}

- (NSArray*) getAllOpenHours {
    NSArray *openHours = [[NSArray alloc] init];
    NSEnumerator *enumerateHours = [self.allHours objectEnumerator];
    
    NSDictionary* nextHours;
    while (nextHours = [enumerateHours nextObject]) {
        
        if (![[nextHours objectForKey: @"closed"] boolValue]) {
            openHours = [openHours arrayByAddingObject: nextHours];
        }
    }
    return openHours;
}

- (NSArray*) getAllMainHours {
    
    NSArray *mainHours = [[NSArray alloc] init];
    NSEnumerator *enumerateHours = [self.allHours objectEnumerator];
    
    NSDictionary* nextHours;
    while (nextHours = [enumerateHours nextObject]) {
        
        if (![[nextHours objectForKey: @"closed"] boolValue] && [[nextHours objectForKey:@"mainHours"] boolValue]) {
            mainHours = [mainHours arrayByAddingObject: nextHours];
        }
    }
    return mainHours;
}

- (NSArray*) getAllOtherHours {
    
    NSArray *mainHours = [[NSArray alloc] init];
    NSEnumerator *enumerateHours = [self.allHours objectEnumerator];
    
    NSDictionary* nextHours;
    while (nextHours = [enumerateHours nextObject]) {
        
        if (![[nextHours objectForKey: @"closed"] boolValue] && ![[nextHours objectForKey:@"mainHours"] boolValue]) {
            mainHours = [mainHours arrayByAddingObject: nextHours];
        }
    }
    return mainHours;
}


- (NSDictionary*) getHoursForCurrentTime {

    NSEnumerator *hoursEnum = [self.allHours objectEnumerator];
    NSDictionary* nextHours;
    NSDictionary * currentHours;
    nextHours = [hoursEnum nextObject];
    
    NSDate *currentDate = [[NSDate alloc] init];
    while (nextHours = [hoursEnum nextObject]) {
        if (![[nextHours objectForKey: @"closed"] boolValue]) {
        
            if ([[nextHours objectForKey: @"facilityHours"] boolValue]) {
                if ([currentDate compare: [nextHours objectForKey: @"beginningDate"]] == NSOrderedDescending && [currentDate compare: [nextHours objectForKey: @"endDate"]] == NSOrderedAscending) {
                    currentHours = nextHours;
                    return currentHours;
                }
            }
        } else if ([currentDate compare: [nextHours objectForKey: @"beginningDate"]] == NSOrderedDescending && [currentDate compare: [nextHours objectForKey: @"endDate"]] == NSOrderedAscending) {
            currentHours = nextHours;
            return currentHours;
        }
        
    }
    NSLog(@"Could not find current hours");
    return  currentHours;
}


- (NSString*) getOpenningTime {
    NSArray* arrayOfHours = [[self getHoursForCurrentTime] objectForKey: @"hours"];
    NSLog(@"Current day is %u", [NSDate currentDayOfTheWeekAsInt]);
    NSString* hours = [arrayOfHours objectAtIndex: [NSDate currentDayOfTheWeekAsInt]];
    //get the string up until the space
    for (size_t i = 0; i < [hours length]; ++i) {
        if ([hours characterAtIndex: i] == ' ') {
            return [hours substringWithRange: NSMakeRange(0, i)];
        }
    }
    return nil;
}

- (NSString*) getClosingTime {
    NSArray* arrayOfHours = [[self getHoursForCurrentTime] objectForKey: @"hours"];
    NSLog(@"Current day is %u", [NSDate currentDayOfTheWeekAsInt]);
    NSString* hours = [arrayOfHours objectAtIndex: [NSDate currentDayOfTheWeekAsInt]];
    //get the string up until the space
    for (size_t i = 0; i < [hours length]; ++i) {
        if ([hours characterAtIndex: i] == '-') {
            return [hours substringWithRange: NSMakeRange(i+2, [hours length] - (i+2))];
        }
    }
    return nil;
}


- (BOOL) isOpen {
    
   
    NSDate *currentDate = [NSDate dateByAddingTimeCurrentTime: -60*60*5];
    NSLog(@"The time is %@", currentDate);
    NSDateFormatter *getTimeFormat = [[NSDateFormatter alloc] init];
    getTimeFormat.timeStyle = NSDateFormatterShortStyle;
    getTimeFormat.dateStyle = NSDateFormatterNoStyle;
    NSLog(@"%@", [getTimeFormat stringFromDate: currentDate]);
   // if ([NSDate compareTime: [self getOpenningTime] withTime: [getTimeFormat]]) {}
    return NO;
}

//private methods

@end
