//
//  AppDelegate.h
//  WeatherTest
//
//  Created by Phillip Sommerfeld on 3/22/14.
//  Copyright (c) 2014 P. Sommerfeld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSTracker.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GPSDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
