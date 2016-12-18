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

- (void)requestTextFile:(NSString*)urlString {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSString* content = [NSString stringWithContentsOfFile:filePath.relativePath encoding:NSUTF8StringEncoding error:NULL];
        NSLog(@"content = %@", content);
        if ([self.delegate respondsToSelector:@selector(webDataProcessing:didUpdateWithWeather:)]) {
            [self.delegate webDataProcessing:self didUpdateWithWeather:content];
        }
    }];
    [downloadTask resume];
}



@end
