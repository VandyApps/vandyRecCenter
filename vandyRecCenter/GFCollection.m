//
//  GFCollection.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFCollection.h"

@implementation GFCollection

#pragma mark - Getters
- (NSArray*) models {
    if (_models == nil) {
        _models = [[NSArray alloc] init];
    }
    return _models;
}

#pragma mark - Model Getters
- (void) GFModelForYear:(NSUInteger)year month:(NSUInteger)month block:(void (^)(NSError *error, GFModel *model))block {
  //array of models is in chronological order
    BOOL foundModel = NO;
    for (GFModel* model in self.models) {
        if (model.month == month && model.year == year) {
            foundModel = YES;
            block(nil, model);
        }
    }
    if (!foundModel) {
        GFModel * newModel = [[GFModel alloc] init];
        [newModel loadData:^(NSError *error, NSArray *data) {
            if (error) {
                NSLog(@"%@", error);
                block(error, nil);
            } else {
                self.models = [self.models arrayByAddingObject: newModel];
                [self sort];
                block(nil, newModel);
            }
        } forMonth: month andYear: year];
    }
   
    
}
- (void) GFModelForCurrentMonth:(void (^)(NSError *, GFModel *))block {
    NSTimeZone* nashville = [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE];
    NSDate* current = [[NSDate alloc] init];
    NSUInteger month = [current monthForAdjustedTimeZone: nashville];
    NSUInteger year = [current yearForAdjustedTimeZone: nashville];
    [self GFModelForYear: year month: month block:^(NSError *error, GFModel *model) {
        block(error, model);
    }];
    
}

#pragma mark - Sorting method
//sorts the GFModels in the collection so that they are in chronological
//order
- (void) sort {
    self.models = [self.models sortedArrayUsingComparator:^NSComparisonResult(GFModel* obj1, GFModel* obj2) {
        return ([GFModel compareModel1:obj1 model2: obj2]);
    }];
}
@end
