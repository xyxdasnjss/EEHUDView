//
//  AppDelegate.m
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 11/12/07.
//  Copyright (c) 2011年 Milestoneeee.com. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    // ignore counter
    int ignoringCounter_;
}
@property (nonatomic) int ignoringCounter;
@end

@implementation AppDelegate
@synthesize ignoringCounter = ignoringCounter_;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - Common
- (void)countUpIgnoringCounter
{
    // countUP
    ignoringCounter_++;
    
    if (![[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }
    
    //printf("%s(%d)\n", __func__, ignoringCounter_);
}

- (void)countDownIgnoringCounter
{
    // countDown
    ignoringCounter_--;
    
    //printf("%s(%d)\n", __func__, ignoringCounter_);
    
    if (ignoringCounter_ <= 0) {
        
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        
        // refresh
        ignoringCounter_ = 0;
    }
}

@end
