//
//  WeatherViewController.h
//  britWeather
//
//  Created by Nikita Taranov on 12/15/16.
//  Copyright © 2016 Nikita Taranov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebDataProcessing.h"

@interface WeatherViewController : UIViewController <WebDataProcessingDelegate>

@property (weak, nonatomic) IBOutlet UITextView *weatherText;

@property (strong,nonatomic) NSString *stationWebData;

@end

