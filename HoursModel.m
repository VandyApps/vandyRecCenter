//
//  HoursModel.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/14/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//


#import "HoursModel.h"

@interface HoursModel()

@property (nonatomic, strong) NSArray* allHours;

@end
@implementation HoursModel

@synthesize allHours = _allHours;


//getters and setters
- (id) initWithPathToPList:(NSString *)path {
    
    self = [super init];
    if (self) {
        self.allHours = [[NSArray alloc] initWithContentsOfFile: path];
        
        //make selected hours the current hours
        
    }
    return self;
    
}


- (id) init {
    self = [self initWithPathToPList:nil];
    return self;
}

- (NSDictionary*) hoursWithTitle:(NSString *)title {
    NSEnumerator* hoursEnum = [self.allHours objectEnumerator];
    NSDictionary* nextHours;
    while (nextHours = [hoursEnum nextObject]) {
        if ([[nextHours objectForKey: @"title"] isEqualToString: title]) {
            return nextHours;
        }
    }
    return nil;
}


- (NSArray*) closedHours {
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

- (NSArray*) openHours {
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

- (NSArray*) mainHours {
    
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

- (NSArray*) otherHours {
    
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


- (NSDictionary*) hoursForCurrentTime {
    
    NSEnumerator *hoursEnum = [self.allHours objectEnumerator];
    NSDictionary* nextHours;
    NSDictionary* currentHours;
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
    
    return  currentHours;
}


- (NSString*) openingTime {
    NSArray* arrayOfHours = [[self hoursForCurrentTime] objectForKey: @"hours"];
    NSString* hours = [arrayOfHours objectAtIndex: [NSDate currentDayOfTheWeekAsIntWithTimeZone: [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE]]];
    //get the string up until the space
    for (size_t i = 0; i < [hours length]; ++i) {
        if ([hours characterAtIndex: i] == ' ') {
            return [hours substringWithRange: NSMakeRange(0, i)];
        }
    }
    return nil;
}

- (NSString*) closingTime {
    NSArray* arrayOfHours = [[self hoursForCurrentTime] objectForKey: @"hours"];
    NSString* hours = [arrayOfHours objectAtIndex: [NSDate currentDayOfTheWeekAsIntWithTimeZone: [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE]]];
    //get the string up until the space
    for (size_t i = 0; i < [hours length]; ++i) {
        if ([hours characterAtIndex: i] == '-') {
            return [hours substringWithRange: NSMakeRange(i+2, [hours length] - (i+2))];
        }
    }
    return nil;
}


- (BOOL) isOpen {
    
    NSDate *currentDate = [[NSDate alloc] init];
    
    NSDateFormatter *getTimeFormat = [[NSDateFormatter alloc] init];
    getTimeFormat.timeStyle = NSDateFormatterShortStyle;
    getTimeFormat.dateStyle = NSDateFormatterNoStyle;
    //set time to Nashville time
    getTimeFormat.timeZone = [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE];
    
    
    //if the current time is after the opening time
    if ( [NSDate compareTime: [self openingTime] withTime: [getTimeFormat stringFromDate: currentDate]] == NSOrderedAscending || [NSDate compareTime: [self openingTime] withTime: [getTimeFormat stringFromDate: currentDate]] == NSOrderedSame) {
        
        //if it is closing at midnight, then it must be currently open
        if ([NSDate compareTime: @"12:00AM" withTime: [self closingTime]] == NSOrderedSame) {
            return YES;
        }
        else if ([NSDate compareTime: [self closingTime] withTime: [getTimeFormat stringFromDate: currentDate]] == NSOrderedDescending)
        {
            return YES;
        }
        
        
    }
    return NO;
}

- (BOOL) willOpenLaterToday {
    NSDate *currentDate = [[NSDate alloc] init];
    
    NSDateFormatter *getTimeFormat = [[NSDateFormatter alloc] init];
    getTimeFormat.timeStyle = NSDateFormatterShortStyle;
    getTimeFormat.dateStyle = NSDateFormatterNoStyle;
    //set time to Nashville time
    getTimeFormat.timeZone = [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE];
    
    if ([self openingTime] && [NSDate compareTime: [self openingTime] withTime: [getTimeFormat stringFromDate: currentDate]] == NSOrderedDescending) {
        return YES;
    }
    return NO;
}

- (BOOL) wasOpenEarlierToday {
    NSDate *currentDate = [[NSDate alloc] init];
    
    NSDateFormatter *getTimeFormat = [[NSDateFormatter alloc] init];
    getTimeFormat.timeStyle = NSDateFormatterShortStyle;
    getTimeFormat.dateStyle = NSDateFormatterNoStyle;
    //set time to Nashville time
    getTimeFormat.timeZone = [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE];
   
    if ([self closingTime]) {
        //if the closing time is midnight, it is either still open or did not open yet
        if ([NSDate compareTime: @"12:00AM" withTime: [self closingTime]] == NSOrderedSame) {
            return NO;
        }
        else if ([self closingTime] && [NSDate compareTime: [self closingTime] withTime: [getTimeFormat stringFromDate: currentDate]] == NSOrderedAscending) {
            
            return YES;
        }
    }
    
    return NO;
}


- (NSTimeInterval) timeUntilClosed {
    
    if ([self isOpen]) {
        
        
        NSDate *currentDate = [NSDate dateByAddingTimeCurrentTime: [[NSTimeZone timeZoneWithName:NASHVILLE_TIMEZONE] secondsFromGMT]]; //adjust to nashville time
        NSDate *closingDate = [currentDate dateBySettingTimeToTime: [self closingTime]];
        return [closingDate timeIntervalSinceDate: currentDate];
    }
    return 0;
}

- (NSTimeInterval) timeUntilOpen {
    if ([self willOpenLaterToday]) {
        
        
       NSDate *currentDate = [NSDate dateByAddingTimeCurrentTime: [[NSTimeZone timeZoneWithName:NASHVILLE_TIMEZONE] secondsFromGMT]]; //adjust to nashville time
        NSDate *openingDate = [currentDate dateBySettingTimeToTime: [self openingTime]];
        return [openingDate timeIntervalSinceDate: currentDate];
    }
    return 0;
}
//private methods


@end
