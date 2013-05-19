//
//  VandyRecClient.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/19/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "VandyRecClient.h"

@implementation VandyRecClient

- (id) init {
    self = [super initWithBaseURL: [NSURL URLWithString: BASE_URL]];
    return self;
}

- (void) getJSONFromNewsTab:(void (^)(NSError *, NSData *))block {

    
}
@end
