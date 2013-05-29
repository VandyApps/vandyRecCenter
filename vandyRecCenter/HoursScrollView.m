//
//  HoursScrollView.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "HoursScrollView.h"

@interface HoursScrollView()

@property (nonatomic, assign) CGRect currentFrame;
@property (nonatomic, strong) NSArray* subviews;
@end
@implementation HoursScrollView


@synthesize scrollHoursDelegate = _scrollHoursDelegate;
@synthesize currentFrame = _currentFrame;
@synthesize subviews = _subviews;

#pragma mark - Getters
- (NSArray*) subviews {
    if (_subviews == nil) {
        _subviews = [[NSArray alloc] init];
    }
    return  _subviews;
}

#pragma mark - managing subviews
- (void) addSubview:(UIView *)view {
    [super addSubview: view];
    self.subviews = [self.subviews arrayByAddingObject: view];
}

- (void) removeAllSubviews {
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
}
#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self.currentFrame = self.frame;
    }
    return self;
}

#pragma mark - Lifecycle

- (void) layoutSubviews {
    
    [super layoutSubviews];
    if (self.frame.size.height != self.currentFrame.size.height || self.frame.size.width != self.currentFrame.size.width || self.frame.origin.x != self.currentFrame.origin.x || self.frame.origin.y != self.currentFrame.origin.y) {
        
        self.currentFrame = self.frame;
        [self setUpScrollViewWithHours: [self.scrollHoursDelegate hoursForFrameChange: self.currentFrame]];
    }
}


#pragma mark - Publics

//returns true if the scrolling arrows should be shown
//aka returns true if there is more than one page to display
- (NSUInteger) setUpScrollViewWithHours:(NSDictionary *)hours {
    [self removeAllSubviews];
    NSUInteger pageCount = 0;
    //set up the scroll view here
    NSArray* hoursArray = [hours objectForKey: @"hours"];
    //self.scrollHours.frame = CGRectMake(X_COOR_OF_PAGE, Y_COOR_OF_PAGE, self.widthOfScrollView, HEIGHT_OF_PAGE);
    
    if (hoursArray) {
        self.bounces = YES;
        NSArray* indicesOfUniqueHours = [self arrayOfUniqueIndices: hoursArray];
        NSArray *scrollTitles = [self titlesForArrayOfUniqueIndices: indicesOfUniqueHours];
        NSInteger numberOfPages = [scrollTitles count];
        
        
        self.contentSize = CGSizeMake(self.frame.size.width * numberOfPages, self.frame.size.height);
        
        //set up the page controls for the scroll view
        pageCount = numberOfPages;
        
        //add the subviews to the scroll view
        for (size_t i = 0; i < [scrollTitles count]; ++i) {
            
            CGFloat xValueForTitleLabel = (self.frame.size.width - WIDTH_OF_TITLE_LABEL) / 2.0;
            
            UILabel* titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(xValueForTitleLabel + i* self.frame.size.width, Y_COOR_OF_TITLE_LABEL , WIDTH_OF_TITLE_LABEL, HEIGHT_OF_TITLE_LABEL)];
            
            titleLabel.text = [scrollTitles objectAtIndex: i];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview: titleLabel];
            
            CGFloat xValueForHoursLabel = (self.frame.size.width - WIDTH_OF_HOURS_LABEL) / 2.0;
            UILabel* hoursLabel = [[UILabel alloc] initWithFrame: CGRectMake(xValueForHoursLabel + i* self.frame.size.width, Y_COOR_OF_HOURS_LABEL, WIDTH_OF_HOURS_LABEL, HEIGHT_OF_HOURS_LABEL)];
            
            hoursLabel.text = [hoursArray objectAtIndex: [[indicesOfUniqueHours objectAtIndex: i] intValue]];
            hoursLabel.textColor = [UIColor whiteColor];
            hoursLabel.backgroundColor = [UIColor clearColor];
            hoursLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview: hoursLabel];
        }
    } else { //could not find hours
        
        
        self.contentSize = self.frame.size;
        self.bounces = NO;
        
        //set up the x coordinate
        CGFloat xValueForErrorLabel = (self.frame.size.width - WIDTH_OF_ERROR_LABEL) / 2.0;
        UILabel *errorLabel = [[UILabel alloc] initWithFrame: CGRectMake(xValueForErrorLabel, Y_COOR_OF_ERROR_LABEL, WIDTH_OF_ERROR_LABEL, HEIGHT_OF_ERROR_LABEL)];
        errorLabel.textColor = [UIColor whiteColor];
        errorLabel.backgroundColor = [UIColor clearColor];
        errorLabel.textAlignment = NSTextAlignmentCenter;
        if ([[hours objectForKey: @"closed"] boolValue]) { //currently closed
            errorLabel.text = @"CLOSED";
        } else { //hours not added to the plist
            errorLabel.text = @"Hours Not Available";
        }
        
        [self addSubview: errorLabel];
        pageCount = 1;
    }
    
    return pageCount;

}

#pragma mark - Private

//this returns an array of all the indices that are totally unique in sequence
//MORE DETAILED COMMENTS HERE
- (NSArray*) arrayOfUniqueIndices: (NSArray*) hours {
    NSArray* arrayOfIndices = [[NSArray alloc] init];
    for (size_t i =0; i < [hours count]; ++i) {
        if (i == 0) {
            arrayOfIndices = [arrayOfIndices arrayByAddingObject: [NSNumber numberWithInt: 0]];
            
        } else {
            
            if (![[hours objectAtIndex: i] isEqualToString: [hours objectAtIndex: i - 1]]) {
                arrayOfIndices = [arrayOfIndices arrayByAddingObject: [NSNumber numberWithInt: i]];
            }
        }
        
    }
    return arrayOfIndices;
}

- (NSArray*) titlesForArrayOfUniqueIndices: (NSArray*) arrayOfUniqueIndices {
    NSArray* titles = [[NSArray alloc] init];
    for (size_t i = 0; i < [arrayOfUniqueIndices count]; ++i) {
        if (i+1 < [arrayOfUniqueIndices count]) { //then this is not the last index
            if ([[arrayOfUniqueIndices objectAtIndex:i] intValue] != [[arrayOfUniqueIndices objectAtIndex:i+1] intValue] - 1) { //there is a range
                
                NSInteger startIndex = [[arrayOfUniqueIndices objectAtIndex: i] intValue];
                NSInteger endIndex = [[arrayOfUniqueIndices objectAtIndex: i + 1] intValue] - 1;
                titles = [titles arrayByAddingObject: [NSString stringWithFormat: @"%@ - %@", [DateHelper weekAbbreviationForIndex: startIndex], [DateHelper weekAbbreviationForIndex:endIndex]]];
                
                
            } else { //there is no range, just a single day
                titles = [titles arrayByAddingObject: [DateHelper weekDayForIndex:[[arrayOfUniqueIndices objectAtIndex: i] intValue]]];
            }
        } else {
            titles = [titles arrayByAddingObject: [DateHelper weekDayForIndex: [[arrayOfUniqueIndices objectAtIndex:i] intValue]]];
        }
    }
    return titles;
}


@end
