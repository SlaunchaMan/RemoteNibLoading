//
//  main.m
//  RemoteNibLoading
//
//  Created by Jeff Kelley on 1/2/13.
//  Copyright (c) 2013 Jeff Kelley. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "JKAppDelegate.h"


int main(int argc, char *argv[])
{
    int returnCode;
    
    @autoreleasepool {
        returnCode = UIApplicationMain(argc,
                                       argv,
                                       nil,
                                       NSStringFromClass([JKAppDelegate class]));
    }
    
    return returnCode;
}
