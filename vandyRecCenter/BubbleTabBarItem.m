//
//  BubbleTabBarItem.m
//  Pods
//
//  Created by Brendan McNamara on 4/25/13.
//
//

#import "BubbleTabBarItem.h"



@implementation BubbleTabBarItem

@synthesize radiusWithHorizontalTabBar = _radiusWithHorizontalTabBar;
@synthesize radiusWithVerticalTabBar = _radiusWithVerticalTabBar;
@synthesize heightOfItemForHorizontalTabBar = _heightOfItemForHorizontalTabBar;
@synthesize heightOfItemForVerticalTabBar = _heightOfItemForVerticalTabBar;

@synthesize backgroundColorForItem = _backgroundColorForItem;
@synthesize selectedBackgroundColorForItem = _selectedBackgroundColorForItem;

#pragma - Getters

- (CGFloat) radiusWithHorizontalTabBar {
    if (_radiusWithHorizontalTabBar == 0) {
        _radiusWithHorizontalTabBar = self.heightOfItemForHorizontalTabBar/2;
    }
    return _radiusWithHorizontalTabBar;
}

- (CGFloat) radiusWithVerticalTabBar {
    if (_radiusWithVerticalTabBar == 0) {
        _radiusWithVerticalTabBar = self.heightOfItemForVerticalTabBar/2;
    }
    return _radiusWithVerticalTabBar;
}

- (CGFloat) heightOfItemForHorizontalTabBar {
    if (_heightOfItemForHorizontalTabBar == 0) {
        _heightOfItemForHorizontalTabBar = SIZE_OF_ITEM_HORIZONTAL_DEFAULT;
    }
    return _heightOfItemForHorizontalTabBar;
}

- (CGFloat) heightOfItemForVerticalTabBar {
    if (_heightOfItemForVerticalTabBar == 0){
        _heightOfItemForVerticalTabBar = SIZE_OF_ITEM_VERTICAL_DEFAULT;
    }
    return _heightOfItemForVerticalTabBar;
}

- (UIColor*) backgroundColorForItem {
    if (!_backgroundColorForItem) {
        _backgroundColorForItem = BACKGROUND_COLOR_DEFAULT;
    }
    return _backgroundColorForItem;
}

- (UIColor*) selectedBackgroundColorForItem {
    if (!_selectedBackgroundColorForItem) {
        _selectedBackgroundColorForItem = SELECTED_BACKGROUND_COLOR_DEFAULT;
    }
    return _selectedBackgroundColorForItem;
}



#pragma - initializers

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (BubbleTabBarItem *)itemWithTitle:(NSString *)title image:(UIImage *)image {
    BubbleTabBarItem *item = [[BubbleTabBarItem alloc] initWithFrame:CGRectZero];
    
    item.title = title;
    
    item.titleColor = [UIColor whiteColor];
    item.image = image;
    //item.layer.cornerRadius = 25;
    item.layer.borderWidth = 4;
    item.layer.borderColor = [[UIColor whiteColor] CGColor];
    item.layer.backgroundColor = [item.backgroundColorForItem CGColor];
    return item;
}

#pragma - Control State Handling

- (void) setSelected:(BOOL)selected {
    [super setSelected: selected];
    if (selected) {
        self.layer.backgroundColor = [self.selectedBackgroundColorForItem CGColor];
    } else {
        self.layer.backgroundColor = [self.backgroundColorForItem CGColor];
    }
}
@end
