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
    //add spinner to indicate that the page is loading
    dispatch_queue_t loadRequest = dispatch_queue_create("load home page", 0);
    dispatch_async(loadRequest, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homePageForRec loadRequest: urlRequest];
            self.homePageForRec.scalesPageToFit = YES;
            
        });
        
    });
    

    
    //create an asynchronous loading spiral
    
    
}



@end
