//
//  WeatherViewController.m
//  britWeather
//
//  Created by Nikita Taranov on 12/15/16.
//  Copyright © 2016 Nikita Taranov. All rights reserved.
//

#import "WeatherViewController.h"
#import "StationData.h"
#import "AFNetworking.h"

static NSString *const stationsURL = @"http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/";

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WebDataProcessing *client = [WebDataProcessing sharedManager];
    
    client.delegate = self;
    
    NSString *weatherURL = [NSString stringWithFormat:@"%@%@",stationsURL,self.stationWebData];
    
   [client requestTextFile:weatherURL];

}

-(void)webDataProcessing:(WebDataProcessing *)client didUpdateWithStations:(id)stations{
    
    
}

-(void)webDataProcessing:(WebDataProcessing *)client didFailWithError:(NSError *)error{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Station Error" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)webDataProcessing:(WebDataProcessing *)client didUpdateWithWeather:(id)weather{
    
    self.weatherText.text = weather;
    
}


@end
