//
//  NEOAppDelegate.m
//  BioCalendar
//
//  Created by Sangwook Nam on 13. 5. 13..
//  Copyright (c) 2013년 Sangwook Nam. All rights reserved.
//

#import "NEOAppDelegate.h"

#import "NEOCalendarViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "MoPub.h"
#import <Google/Analytics.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGB(r, g, b)		[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a)	[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation NEOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NEOCalendarViewController *calendarViewController = [[NEOCalendarViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:calendarViewController];
    self.window.rootViewController = navi;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [Fabric with:@[[Crashlytics class], [MoPub class]]];
    
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x27ae60)];
    
    NSDictionary *titleDict = @{ NSForegroundColorAttributeName : UIColorFromRGB(0xFFFFFF),
                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:19.0]};
    
    [[UINavigationBar appearance] setTitleTextAttributes: titleDict];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xFFFFFF)];

    
    [[UIToolbar appearance] setBarTintColor:UIColorFromRGB(0x27ae60)];
    
    [[UIToolbar appearance] setTintColor:UIColorFromRGB(0xFFFFFF)];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    // Configure tracker from GoogleService-Info.plist.
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    // Optional: configure GAI options.
    GAI *gai = [GAI sharedInstance];
    gai.trackUncaughtExceptions = YES;  // report uncaught exceptions
//    gai.logger.logLevel = kGAILogLevelVerbose;  // remove before app release

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
