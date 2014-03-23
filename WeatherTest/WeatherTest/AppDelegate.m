//
//  AppDelegate.m
//  WeatherTest
//
//  Created by Phillip Sommerfeld on 3/22/14.
//  Copyright (c) 2014 P. Sommerfeld. All rights reserved.
//

#import "AppDelegate.h"
#import "WeatherRequest.h"
#import "WeatherData.h"

#define MINUTES_TO_WAIT 1


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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
    [[GPSTracker sharedInstance] becomeDelegate:self];
    [[GPSTracker sharedInstance] startTracking:MINUTES_TO_WAIT];
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

-(void)gpsLocationUpdate:(CLLocation *)loc {
    [[GPSTracker sharedInstance] stopTracking];
    [[GPSTracker sharedInstance] removeDelegate:self];
    
    [[WeatherRequest sharedInstance] requestWeather:loc sucess:^{
        [self createLocalNotification];

    } failure: ^{
        NSLog(@"Failure");
    }];
}

-(void) createLocalNotification
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:1];
    //    NSLog(@"Notification will be shown on: %@",localNotification.fireDate);
    
    NSString *s = nil;
    
    s = [NSString stringWithFormat:@"Code = %d, HighTemp = %d", [[WeatherData sharedInstance] getTodaysCode],
         [[WeatherData sharedInstance] getTodaysHighTemp]];
    
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = s;
    
    localNotification.alertAction = NSLocalizedString(@"View details", nil);
    
    /* Here we set notification sound and badge on the app's icon "-1"
     means that number indicator on the badge will be decreased by one
     - so there will be no badge on the icon */
    
//    localNotification.soundName = @"church_bells.wav";
    localNotification.applicationIconBadgeNumber = -1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}



@end
