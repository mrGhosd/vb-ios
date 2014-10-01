//
//  APIConnect.h
//  voenbank
//
//  Created by vsokoltsov on 30.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConnect : NSObject{
    NSMutableData *userData;
}
@property (nonatomic) id dataFromServer;
-(void)getData:(NSString *)url params: (NSString *) params;
@end
