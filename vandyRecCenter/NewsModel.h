//
//  NewsModel.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/19/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VandyRecClient.h"

@interface NewsModel : NSObject

@property (nonatomic, strong) NSArray* news;

- (id) init;
@end
