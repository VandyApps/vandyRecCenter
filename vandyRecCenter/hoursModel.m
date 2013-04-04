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
@synthesize path = _path;

//getters and setters
- (id) initWithPathToPList:(NSString *)path {
    self.path = path;
    
}
@end
