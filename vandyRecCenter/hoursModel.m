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
                if ([currentDate compare: [nextHours objectForKey: @"beginningDate"]] == NSOrderedAscending && [currentDate compare: [nextHours objectForKey: @"endDate"]] == NSOrderedDescending) {
                    
                    return currentHours;
                }
            }
        } else if ([currentDate compare: [nextHours objectForKey: @"beginningDate"]] == NSOrderedAscending && [currentDate compare: [nextHours objectForKey: @"endDate"]] == NSOrderedDescending){
            
            return currentHours;
        }
        
    }
    return  currentHours;
}

//private methods

//this assumes that the selected hours has been set
/*
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
 */

@end
