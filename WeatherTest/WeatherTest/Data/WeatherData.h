//
//  WeatherData.h
//  WeatherTest
//
//  Created by Phillip Sommerfeld on 3/23/14.
//  Copyright (c) 2014 P. Sommerfeld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherData : NSObject

+(WeatherData *) sharedInstance;

-(void) clearTodaysWeather;

-(void) setTodaysWeather:(NSNumber *) code
                     low:(NSNumber *) low
                    high:(NSNumber *) high
                    text:(NSString *) text;

-(NSUInteger) getTodaysCode;
-(NSInteger) getTodaysLowTemp;
-(NSInteger) getTodaysHighTemp;
-(NSString *) getTodaysTempText;

enum WeatherTypes : NSUInteger {
    WeatherTypeTornado = 0,
    WeatherTypeTropicalStorm = 1,
    WeatherTypeHurricane = 2,
    WeatherTypeSeverThunderstorms = 3,
    WeatherTypeThunderstorms = 4,
    WeatherTypeMixedRainAndSnow = 5,
    WeatherTypeMixedRaindAndSleet = 6,
    WeatherTypeMixedSnowAndSleet = 7,
    WeatherTypeFreezingDrizzle = 8,
    WeatherTypeDrizzle = 9,
    WeatherTypeFreezingRain = 10,
    WeatherTypeShowers = 11,
    WeatherTypeShowers2 = 12,
    WeatherTypeSnowFlurries = 13,
    WeatherTypeLightSnowShowers = 14,
    WeatherTypeBlowingSnow = 15,
    WeatherTypeSnow = 16,
    WeatherTypeHail = 17,
    WeatherTypeSleet = 18,
    WeatherTypeDust = 19,
    WeatherTypeFoggy = 20,
    WeatherTypeHaze = 21,
    WeatherTypeSmoky = 22,
    WeatherTypeBlustery = 23,
    WeatherTypeWindy = 24,
    WeatherTypeCold = 25,
    WeatherTypeCloudy = 26,
    WeatherTypeMostlyCloudyNight = 27,
    WeatherTypeMostlyCloudyDay = 28,
    WeatherTypePartlyCloudyNight = 29,
    WeatherTypePartlyCloudyDay = 30,
    WeatherTypeClearNight = 31,
    WeatherTypeSunny = 32,
    WeatherTypeFairNight = 33,
    WeatherTypeFairDay = 34,
    WeatherTypeMixedRainAndHail = 35,
    WeatherTypeHot = 36,
    WeatherTypeIsoloatedThunderstorms = 37,
    WeatherTypeScatteredThunderstroms = 38,
    WeatherTypeScatteredThunderstroms2 = 39,
    WeatherTypeScatteredShowers = 40,
    WeatherTypeHeavySnow = 41,
    WeatherTypeScatteredSnowShowers = 42,
    WeatherTypeHeavySnow2 = 43,
    WeatherTypePartlyCloudy = 44,
    WeatherTypeThundershowers = 45,
    WeatherTypeSnowShowers = 46,
    WeatherTypeIsolatedThunderstorms = 47,
};



@end
