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
        self.selectedHours = [self findCurrentHours];
        
    }
    return self;
    
}

- (id) init {
    self = [self initWithPathToPList:nil];
    return self;
}

- (BOOL) selectHoursWithTitle:(NSString *)title {
    return NO;
}


//private methods

//this assumes that the selected hours has been set
- (NSDictionary*) findCurrentHours {
    NSEnumerator *hoursEnumerator = [self.allHours objectEnumerator];
    
    NSDictionary* nextHours;
    while (nextHours = [hoursEnumerator nextObject]) {
        
        if ([[nextHours objectForKey: @"closed"] boolValue]) {
            
            if ([[nextHours objectForKey: @"mainHours"] boolValue]) {
                
                NSDate* currentDate = [[NSDate alloc] init];
                if ([currentDate compare: [nextHours objectForKey: @"beginningDate"]] == NSOrderedDescending && [currentDate compare: [nextHours objectForKey: @"endDate"]] == NSOrderedAscending) {
                    
                    //then this is the object to be selected
                    return nextHours;
                }
            }
        } else { //it must be a holiday
            NSDate *currentDate = [[NSDate alloc] init];
            
            if ([currentDate compare: [nextHours objectForKey: @"beginningDate"]] == NSOrderedDescending && [currentDate compare: [nextHours objectForKey: @"endDate"]] == NSOrderedAscending) {
                
                //then this is the object to be selected
                return nextHours;
            }
        }
    }
    //the date could not be found for some reason
    return nil;
}
@end
