//
//  hoursModel.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 4/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hoursModel : NSObject

@property (nonatomic, strong) NSArray* allHours;
@property (nonatomic, strong) NSDictionary* selectedHours;
//@property (nonatomic, strong) NSString* path; //set in the initializer

//this is the default initializer
//sets selected hours to the first intance of hours that it sees in the pList
- (id) initWithPathToPList: (NSString*) path;
- (id) init;

//returns true if it was able to locate the
//hours with the selected title
- (BOOL) selectHoursWithTitle: (NSString*) title;
 
- (NSArray*) getAllClosedHours;
- (NSArray*) getAllOpenHours;

@end
