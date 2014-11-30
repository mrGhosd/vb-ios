//
//  APIConnect.m
//  voenbank
//
//  Created by vsokoltsov on 30.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "APIConnect.h"
//169.254.119.75
#define MAIN_URL [NSURL URLWithString:@"http://localhost:3000"]
#define MAIN_API_URL [NSURL URLWithString:[NSString stringWithFormat: @"%@/api", MAIN_URL]]


@implementation APIConnect

@synthesize completed = _completed;
@synthesize errored = _errored;

- (void) login:(NSDictionary *)data forUrl:(NSString *)url withComplition:(ResponseCopmlition) complition{
    ResponseCopmlition response = [complition copy];
    NSMutableURLRequest *request = [[[AFJSONRequestSerializer new] requestWithMethod:@"POST"
                                                                           URLString:[NSString stringWithFormat:@"%@%@", MAIN_API_URL, url]
                                                                          parameters:@{@"user": data}
                                                                               error:nil] mutableCopy];
    
    AFHTTPRequestOperation *requestAPI = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer new];
    serializer.readingOptions = NSJSONReadingAllowFragments;
    requestAPI.responseSerializer = serializer;
    
    [requestAPI setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        response(responseObject, YES);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        response(error, NO);
    }];
    
    [requestAPI start];

}

-(void) staticPagesInfo:(NSString *) url withComplition:(ResponseCopmlition) complition{
    ResponseCopmlition response = [complition copy];
    NSMutableURLRequest *request = [[[AFJSONRequestSerializer new] requestWithMethod:@"GET"
                                                                           URLString:[NSString stringWithFormat:@"%@%@", MAIN_API_URL, url]
                                                                          parameters:@{}
                                                                               error:nil] mutableCopy];
    
    AFHTTPRequestOperation *requestAPI = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer new];
    serializer.readingOptions = NSJSONReadingAllowFragments;
    requestAPI.responseSerializer = serializer;
    
    [requestAPI setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        response(responseObject, YES);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        response(error, NO);
    }];
    
    [requestAPI start];

}
- (id) requestForStaticPages: (NSString *) urlPart{
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", MAIN_URL, urlPart]]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    return jsonObjects;

}
- (UIImage *) loadImageHelper:(NSString *) receivedUrl{
    NSString *fullURL = [[NSString alloc] initWithFormat:@"%@%@",MAIN_URL,receivedUrl];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    return img;
}
- (NSString *) dataParseHelper:(NSString *) date withPattern: (NSString *)pattern{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *correctDate = [dateFormat dateFromString:date];
    [dateFormat setDateFormat:pattern];
    NSString *finalDate = [dateFormat stringFromDate:correctDate];
    return finalDate;
}

@end
