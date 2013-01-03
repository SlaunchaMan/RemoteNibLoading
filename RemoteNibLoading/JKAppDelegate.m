//
//  JKAppDelegate.m
//  RemoteNibLoading
//
//  Created by Jeff Kelley on 1/2/13.
//  Copyright (c) 2013 Jeff Kelley. All rights reserved.
//


#import "JKAppDelegate.h"

#import "JKLoadingViewController.h"
#import "JKRemoteNibViewController.h"


static NSString * const kRemoteNibURL = @"http://www.slaunchaman.com/JKRemoteNibViewController.nib";


@implementation JKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    JKLoadingViewController *loadingViewController = [[JKLoadingViewController alloc] initWithNibName:nil
                                                                                               bundle:nil];
    
    [[self window] setRootViewController:loadingViewController];
    
    // Load the remote nib
    NSURL *remoteNibURL = [NSURL URLWithString:kRemoteNibURL];
    
    NSURLRequest *nibRequest = [NSURLRequest requestWithURL:remoteNibURL
                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:60.0];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [NSURLConnection sendAsynchronousRequest:nibRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error) {
                               [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                               if (data) {
                                   UINib *remoteNib = [UINib nibWithData:data bundle:nil];
                                   
                                   if (remoteNib) {
                                       JKRemoteNibViewController *remoteNibViewController =
                                       [[JKRemoteNibViewController alloc] init];
                                       
                                       // Load the nib, which will set up the view controller bindings
                                       [remoteNib instantiateWithOwner:remoteNibViewController options:nil];
                                       
                                       [[self window] setRootViewController:remoteNibViewController];
                                   }
                                   else {
                                       [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                   message:@"Could not create nib from data."
                                                                  delegate:nil
                                                         cancelButtonTitle:@"Aww, shucks."
                                                         otherButtonTitles:nil] show];
                                   }
                               }
                               else {
                                   if (error) {
                                       [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                   message:[error localizedDescription]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil] show];
                                   }
                               }
                           }];
    
    return YES;
}

@end
