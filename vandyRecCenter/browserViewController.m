//
//  browserViewController.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 3/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "browserViewController.h"

@interface browserViewController ()

@end

@implementation browserViewController
@synthesize homePageForRec = _homePageForRec;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL: [NSURL URLWithString: REC_URL]];
    [self.homePageForRec loadRequest: urlRequest];
    self.homePageForRec.scalesPageToFit = YES;
    
    //create an asynchronous loading spiral
    
}



@end
