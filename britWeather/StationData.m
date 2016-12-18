//
//  StationData.m
//  britWeather
//
//  Created by Nikita Taranov on 12/15/16.
//  Copyright © 2016 Nikita Taranov. All rights reserved.
//

#import "StationData.h"

@implementation StationData

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.stationWebPath = _stationWebPath;
        self.stationDescription = _stationDescription;
      
    }
    return self;
}

@end
