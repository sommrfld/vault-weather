//
//  GPSTracker.h
//  WeatherTest
//
//  Created by Phillip Sommerfeld on 3/22/14.
//  Copyright (c) 2014 P. Sommerfeld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol GPSDelegate
-(void)gpsLocationUpdate:(CLLocation *)loc;
@end


@interface GPSTracker : NSObject <CLLocationManagerDelegate>

+ (GPSTracker *)sharedInstance;

-(void) becomeDelegate:(id<GPSDelegate>) del;
-(void) removeDelegate:(id<GPSDelegate>) del;
-(void) startTracking:(NSInteger)delayInMinutes;
-(void) stopTracking;


@end
