//
//  WeatherRequest.h
//  WeatherTest
//
//  Created by Phillip Sommerfeld on 3/22/14.
//  Copyright (c) 2014 P. Sommerfeld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WeatherRequest : NSObject<NSXMLParserDelegate>

+(WeatherRequest *) sharedInstance;

-(void) requestWeather:(CLLocation *)location
                sucess:(void (^)(void))success
               failure:(void (^)(void))failure;


@end
