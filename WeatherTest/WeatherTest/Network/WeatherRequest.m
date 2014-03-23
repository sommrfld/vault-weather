//
//  WeatherRequest.m
//  WeatherTest
//
//  Created by Phillip Sommerfeld on 3/22/14.
//  Copyright (c) 2014 P. Sommerfeld. All rights reserved.
//

#import "WeatherRequest.h"
#import "AFNetworking.h"
#import "WeatherData.h"

@interface WeatherRequest ()

@property (nonatomic) BOOL parsedWOEID;
@property (nonatomic) BOOL parsedForecast;
@property (nonatomic) NSInteger woeid;

@end

@implementation WeatherRequest

+(WeatherRequest *) sharedInstance
{
    static WeatherRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


-(void) requestWeather:(CLLocation *)location
                sucess:(void (^)(void))success
               failure:(void (^)(void))failure;
{
    [self retrieveLocationCode:location
                       success:^(NSInteger code){
                           [self retrieveWeather:code success:^{
                               success();
                           }failure:^{
                               failure();
                           }];
                       }
                       failure:^{
                           failure();
                       }];
    
}

-(void) retrieveLocationCode:(CLLocation *)location
                     success:(void (^)(NSInteger code))success
                     failure:(void (^)(void))failure
{
    NSString *string = [NSString stringWithFormat:
                        @"http://query.yahooapis.com/v1/public/yql?q=select woeid from geo.placefinder where text=\"%f,%f\" and gflags=\"R\"",
                        location.coordinate.latitude, location.coordinate.longitude];
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:string];
    
    [[WeatherData sharedInstance] clearTodaysWeather];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPResponseSerializer *serializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer = serializer;
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             self.parsedWOEID = NO;
             self.woeid = -1;
             NSXMLParser *parse = responseObject;
             [parse setShouldProcessNamespaces:YES];
             parse.delegate = self;
             [parse parse];
             if ( self.woeid != -1 ) {
                 success(self.woeid);
             }
                 
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // handle failure
             if ( failure != nil ) {
                 failure();
             }
         }];

}

-(void) retrieveWeather:(NSInteger) code
                success:(void (^)(void))success
                failure:(void (^)(void))failure
{
    NSString *string = [NSString stringWithFormat:
                        @"http://weather.yahooapis.com/forecastrss?w=%d", code];
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:string];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPResponseSerializer *serializer = [AFXMLParserResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
    manager.responseSerializer = serializer;

    [manager GET:[url absoluteString]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             self.parsedForecast = NO;
             NSXMLParser *parse = responseObject;
             [parse setShouldProcessNamespaces:YES];
             parse.delegate = self;
             [parse parse];
             success();
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // handle failure
             if ( failure != nil ) {
                 failure();
             }
         }];
    
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ( [qName isEqualToString:@"woeid"] ) {
        self.parsedWOEID = YES;
    }
    if ( [elementName isEqualToString:@"forecast"] && !self.parsedForecast ) {
        self.parsedForecast = YES;
        [[WeatherData sharedInstance] setTodaysWeather:[attributeDict valueForKey:@"code"]
              low:[attributeDict valueForKey:@"low"] high:[attributeDict valueForKey:@"high"]
             text:[attributeDict valueForKey:@"text"]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ( self.parsedWOEID ) {
        self.woeid = string.integerValue;
        self.parsedWOEID = NO;
    }
}




@end
