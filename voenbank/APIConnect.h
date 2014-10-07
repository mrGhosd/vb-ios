//
//  APIConnect.h
//  voenbank
//
//  Created by vsokoltsov on 30.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^requestCompletedBlock)(id);
typedef void(^requestErrorBlock)(NSError *);

@interface APIConnect : NSObject{
    NSMutableData *userData;
}

@property (nonatomic, copy) requestCompletedBlock completed;
@property (nonatomic, copy) requestErrorBlock errored;

@property (nonatomic) NSString *dataFromServer;
-(void)getData:(NSString *)url params: (NSString *) params type: (NSString *) requestType success: (requestCompletedBlock) completed;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (id) requestForStaticPages: (NSString *) urlPart;
@end
