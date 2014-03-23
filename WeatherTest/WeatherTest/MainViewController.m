//
//  MainViewController.m
//  WeatherTest
//
//  Created by Phillip Sommerfeld on 3/22/14.
//  Copyright (c) 2014 P. Sommerfeld. All rights reserved.
//

#import "MainViewController.h"
#import "WeatherRequest.h"
#import "WeatherData.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelWeather;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[GPSTracker sharedInstance] removeDelegate:self];
}

- (IBAction)btnCheckWeatherPressed:(id)sender {
    [self.labelWeather setText:@"Waiting for response"];
    [[GPSTracker sharedInstance] becomeDelegate:self];
    [[GPSTracker sharedInstance] startTracking:0];
}

-(void)gpsLocationUpdate:(CLLocation *)loc {
    [[GPSTracker sharedInstance] stopTracking];
    [[GPSTracker sharedInstance] removeDelegate:self];
    
    [[WeatherRequest sharedInstance] requestWeather:loc sucess:^{
        [self.labelWeather setText:[[WeatherData sharedInstance] getTodaysTempText]];
    } failure: ^{
        NSLog(@"Failure");
    }];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
