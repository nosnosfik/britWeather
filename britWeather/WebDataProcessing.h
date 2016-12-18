//
//  WebDataProcessing.h
//  britWeather
//
//  Created by Nikita Taranov on 12/15/16.
//  Copyright © 2016 Nikita Taranov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StationData.h"

@protocol WebDataProcessingDelegate;

@interface WebDataProcessing : NSObject

@property (nonatomic, weak) id<WebDataProcessingDelegate>delegate;


+ (id)sharedManager;
-(void) getWebData:(NSString*)webURL;
- (void)requestTextFile:(NSString*)urlString;

@end

@protocol WebDataProcessingDelegate <NSObject>

-(void)webDataProcessing:(WebDataProcessing *)client didUpdateWithStations:(id)stations;
-(void)webDataProcessing:(WebDataProcessing *)client didUpdateWithWeather:(id)weather;
-(void)webDataProcessing:(WebDataProcessing *)client didFailWithError:(NSError *)error;

@end
