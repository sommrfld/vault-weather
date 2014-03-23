//
//  GPSTracker.m
//  WeatherTest
//
//  Created by Phillip Sommerfeld on 3/22/14.
//  Copyright (c) 2014 P. Sommerfeld. All rights reserved.
//

#import "GPSTracker.h"

@interface GPSTracker ()
@property (nonatomic, retain) CLLocationManager *mLocationManager;
@property (nonatomic) NSInteger delay;
@property (nonatomic, retain) NSMutableArray *delArray;
@property (nonatomic, retain) NSDate *startDate;


@end

@implementation GPSTracker

+ (GPSTracker *)sharedInstance {
    static GPSTracker *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GPSTracker alloc] init];
        // Do any other initialisation stuff here
        sharedInstance.mLocationManager = [[CLLocationManager alloc] init];
        sharedInstance.delArray = [NSMutableArray array];
    });
    return sharedInstance;
}

-(void) startTracking:(NSInteger)delayInMinutes
{
    self.mLocationManager.delegate = self;
    self.mLocationManager.distanceFilter =  kCLDistanceFilterNone; //whenever we move
    self.mLocationManager.desiredAccuracy = kCLLocationAccuracyBest; //100 m
    self.mLocationManager.activityType = CLActivityTypeFitness;
    self.mLocationManager.pausesLocationUpdatesAutomatically = NO;
    [self.mLocationManager startUpdatingLocation];
    self.delay = delayInMinutes;
    self.startDate = [NSDate date];
}

-(void) stopTracking
{
    [self.mLocationManager stopUpdatingLocation];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if ( self.delay == 0 || [self pastTime] ) {
        if ( self.delArray.count != 0 ) {
            for ( id<GPSDelegate> del in self.delArray ) {
                [del gpsLocationUpdate:[locations objectAtIndex:0]];
            }
        }
    }
    
}
        
-(BOOL) pastTime {
    BOOL retVal = NO;
    NSDate *date = [NSDate date];
    NSTimeInterval distanceBetweenDates = [date timeIntervalSinceDate:self.startDate];
    double secondsInMinute = 60;
    
    if ( ( distanceBetweenDates / secondsInMinute ) > self.delay ) {
        retVal = YES;
    }

    return retVal;
}
        
        

-(void) becomeDelegate:(id<GPSDelegate>) del
{
    if ( ![self.delArray containsObject:del] ) {
        [self.delArray addObject:del];
    }
}

-(void) removeDelegate:(id<GPSDelegate>) del
{
    [self.delArray removeObject:del];
}



@end
