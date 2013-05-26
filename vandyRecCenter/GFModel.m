//
//  GFModel.m
//  
//
//  Created by Brendan McNamara on 5/26/13.
//
//

#import "GFModel.h"

@interface GFModel()

@property (nonatomic, strong) VandyRecClient* webClient;
@end

@implementation GFModel

@synthesize webClient = _webClient;


#pragma mark - getters
- (VandyRecClient*) webClient {
    if (_webClient == nil) {
        _webClient = [[VandyRecClient alloc] init];
    }
    return _webClient;
}

#pragma mark - initializers

- (id) init {
    self = [super init];
    return self;
}

#pragma mark load data

- (void) loadData:(void (^)(NSError *, NSArray *))block forMonth:(NSInteger)month andYear:(NSInteger)year {
    if (month < 0 || year < 0) {
        self.month = -1;
        self.year = -1;
        [self.webClient JSONFromGFTab:^(NSError *error, NSArray *jsonData) {
            if (error) {
                block(error, jsonData);
            } else {
                self.GFClasses = jsonData;
                block(nil, jsonData);
            }
        }];
    } else {
        self.month = month;
        self.year = year;
        [self.webClient JSONFromGFTab:^(NSError *error, NSArray *jsonData) {
            if (error) {
                block(error, jsonData);
            } else {
                self.GFClasses = jsonData;
                block(nil, jsonData);
            }
        } forMonth: month andYear: year];
    
    }
    
}

#pragma mark - Public

- (NSArray*) GFClassesForDay:(NSUInteger)day {
    //check if the GFModel instance is for a given
    //month
    if (self.month >= 0) {
        NSArray *GFClasses = [[NSArray alloc] init];
        for (NSDictionary* GFClass in self.GFClasses) {
            if ([self GFClass: GFClass isOnDay: day]) {
                GFClasses = [GFClasses arrayByAddingObject: GFClass];
            }
        }
        return GFClasses;
    }
    return nil;
}



- (BOOL) GFClass: (NSDictionary*) GFClass isOnDay: (NSUInteger) day {
    NSDate *date = [NSDate dateWithYear: self.year month: self.month andDay: day];
    if ([[GFClass objectForKey: @"dayOfWeek"] intValue] != [date dayOfTheWeekAsInt]) {
        return NO;
    }
    
    
    NSArray* startDateArray = [[GFClass objectForKey: @"startDate"] componentsSeparatedByString: @"/"];

    NSDate* startDate = [NSDate dateWithYear: [[startDateArray objectAtIndex: 2] intValue]  month:[[startDateArray objectAtIndex: 0] intValue] - 1 andDay:[[startDateArray objectAtIndex: 1] intValue]];
    if ([startDate compare: date] == NSOrderedDescending) {
        return NO;
    }
    NSString* endDateString = [GFClass objectForKey: @"endDate"];
    if (![endDateString isEqualToString: @"*"]) {
        NSArray* endDateArray = [endDateString componentsSeparatedByString: @"/"];
        NSDate* endDate = [NSDate dateWithYear: [[endDateArray objectAtIndex: 2] intValue] month: [[endDateArray objectAtIndex: 0] intValue] - 1 andDay: [[endDateArray objectAtIndex: 1] intValue] ];
        if ([date compare: endDate] == NSOrderedDescending) {
            return NO;
        }
    }
    
    
    return YES;
    
}
@end
