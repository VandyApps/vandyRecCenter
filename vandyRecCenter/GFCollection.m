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

#pragma mark - Sub-model getters
- (void) GFClassesForYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day block:(void (^)(NSError *, NSArray *))block {
    
    [self GFModelForYear: year month: month block:^(NSError *error, GFModel *model) {
        if (error) {
            block(error, nil);
        } else {
            block(nil,[model GFClassesForDay: day]);
        }
    }];
}

- (void) GFClassesForCurrentDay:(void (^)(NSError *, NSArray *))block {
    [self GFModelForCurrentMonth:^(NSError *error, GFModel *model) {
        if (error) {
            block(error, nil);
        } else {
            NSDate* current = [[NSDate alloc] init];
            NSUInteger day = [current dayForAdjustedTimeZone: [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE]];
            block(nil, [model GFClassesForDay: day]);
        }
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

#pragma mark - Loading/Reloading
//loading methods do not need to be called unless a model wants to be
//reloaded.  Getters will automatically load data
- (void) loadMonth:(NSUInteger)month andYear:(NSUInteger)year block:(void (^)(NSError *, GFModel *))block {
    BOOL foundModel = NO;
    for (GFModel* model in self.models) {
        if (model.month == month && model.year == year) {
            foundModel = YES;
            [model loadData:^(NSError *error, NSArray *data) {
                if (error) {
                    block(error, nil);
                } else {
                    block(nil, model);
                }
            } forMonth: month andYear: year];
        }
    }
    
    if (!foundModel) {
        GFModel* newModel = [[GFModel alloc] init];
        [newModel loadData:^(NSError *error, NSArray *data) {
            if (error) {
                block(error, nil);
            } else {
                self.models = [self.models arrayByAddingObject: newModel];
                [self sort];
                block(nil, newModel);
            }
        } forMonth: month andYear: year];
    }
}

- (void) loadCurrentMonth:(void (^)(NSError *, GFModel *))block {
    NSDate *current = [[NSDate alloc] init];
    NSUInteger month = [current monthForAdjustedTimeZone: [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE]];
    NSUInteger year = [current yearForAdjustedTimeZone: [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE]];
    [self loadMonth: month andYear: year block:^(NSError *error, GFModel *model) {
        if (error) {
            block(error, nil);
        } else {
            block(error, model);
        }
    }];
}

#pragma mark - Validate
- (BOOL) dataLoadedForYear:(NSUInteger)year month:(NSUInteger)month {
    for (GFModel* model in self.models) {
        if (model.year == year && model.month == month) {
            return [model dataLoaded];
        } else if (model.year < year || (model.year == year && model.month < month)) {
            return NO;
        }
    }
    return NO;
}
@end