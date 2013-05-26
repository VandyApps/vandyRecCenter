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
    if (self.month >= 0) {
        
    }
}

#pragma mark - Private

- (BOOL) class: (NSDictionary*) class isOnDay: (NSUInteger) day {
    
}
@end
