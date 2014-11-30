//
//  APIConnect.h
//  voenbank
//
//  Created by vsokoltsov on 30.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef void(^ResponseCopmlition)(id data, BOOL success);
typedef void (^requestCompletedBlock)(id);
typedef void(^requestErrorBlock)(NSError *);

@interface APIConnect : NSObject{
    NSMutableData *userData;
}

@property (nonatomic, copy) requestCompletedBlock completed;
@property (nonatomic, copy) requestErrorBlock errored;

@property (nonatomic) NSString *dataFromServer;
-(void)login:(NSDictionary *)data forUrl:(NSString *)url withComplition:(ResponseCopmlition) complition;
-(void) staticPagesInfo:(NSString *) url withComplition:(ResponseCopmlition) complition;
- (UIImage *) loadImageHelper:(NSString *) receivedUrl;
@end
