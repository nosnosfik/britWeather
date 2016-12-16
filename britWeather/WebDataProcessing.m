//
//  WebDataProcessing.m
//  britWeather
//
//  Created by Nikita Taranov on 12/15/16.
//  Copyright © 2016 Nikita Taranov. All rights reserved.
//

#import "WebDataProcessing.h"
#import "AFNetworking.h"
#import "StationData.h"

@implementation WebDataProcessing

+ (id)sharedManager {
    static WebDataProcessing *sharedDataProcessing = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataProcessing = [[self alloc] init];
    });
    return sharedDataProcessing;
}

-(void) getWebData:(NSString*)webURL {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:webURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
      
        if ([self.delegate respondsToSelector:@selector(webDataProcessing:didUpdateWithStations:)]) {
            [self.delegate webDataProcessing:self didUpdateWithStations:responseObject];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(webDataProcessing:didFailWithError:)]) {
            [self.delegate webDataProcessing:self didFailWithError:error];
        }
    }];

}


@end
