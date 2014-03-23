//
//  WeatherData.m
//  WeatherTest
//
//  Created by Phillip Sommerfeld on 3/23/14.
//  Copyright (c) 2014 P. Sommerfeld. All rights reserved.
//

#import "WeatherData.h"

@interface WeatherData ()

@property (nonatomic, retain) NSNumber *todaysCode;
@property (nonatomic, retain) NSNumber *todaysHigh;
@property (nonatomic, retain) NSNumber *todaysLow;
@property (nonatomic, retain) NSString *todaysText;

@end

@implementation WeatherData

+(WeatherData *) sharedInstance
{
    static WeatherData *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void) clearTodaysWeather {
    self.todaysCode = nil;
    self.todaysHigh = nil;
    self.todaysLow = nil;
    self.todaysText = nil;
}

-(void) setTodaysWeather:(NSNumber *) code
                     low:(NSNumber *) low
                    high:(NSNumber *) high
                    text:(NSString *) text
{
    self.todaysCode = [NSNumber numberWithInt:code.intValue];
    self.todaysHigh = [NSNumber numberWithInt:high.intValue];
    self.todaysLow = [NSNumber numberWithInt:low.intValue];
    self.todaysText = [NSString stringWithString:text];
}

-(NSUInteger) getTodaysCode {
    NSUInteger retVal = NSUIntegerMax;
    if ( self.todaysCode != nil ) {
        retVal = self.todaysCode.unsignedIntegerValue;
    }
    return retVal;
}

-(NSInteger) getTodaysLowTemp {
    NSInteger retVal = NSIntegerMin;
    if ( self.todaysCode != nil ) {
        retVal = self.todaysLow.unsignedIntegerValue;
    }
    return retVal;
}

-(NSInteger) getTodaysHighTemp {
    NSInteger retVal = NSIntegerMin;
    if ( self.todaysCode != nil ) {
        retVal = self.todaysHigh.unsignedIntegerValue;
    }
    return retVal;
}

-(NSString *) getTodaysTempText {
    return self.todaysText;
}







@end
