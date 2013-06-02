//
//  GFSpecialDates.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 6/2/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFSpecialDates.h"

@interface GFSpecialDates()

@property (nonatomic, strong) VandyRecClient* webClient;

@end

@implementation GFSpecialDates

#pragma mark - Getter

- (VandyRecClient*) webClient {
    if (_webClient == nil) {
        _webClient = [[VandyRecClient alloc] init];
    }
    return _webClient;
}


#pragma mark - Public

- (void) loadData:(void (^)(NSError *, GFSpecialDates *))block {
    
    
    if (self.specialDates == nil) {
       
        //month and year do not matter for special dates type
        [self.webClient JSONFromGFTab:^(NSError *error, NSArray *jsonData) {
            if (jsonData != nil) {
                self.specialDates = jsonData;
            }
            block(error, self);
            
        } forType:@"GFSpecialDate" month: 0 andYear: 0];

    } else {
        block(nil, self);
    }
}

- (BOOL) isSpecialDateForDate:(NSDate *)date {
    
}

- (void) specialDateForDate:(NSDate *)date {
    for (NSDictionary* specialDate in self.specialDates) {
        
    }
}


@end
