//
//  User.h
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic) id userData;
@property(nonatomic) NSDictionary *main;
@property(nonatomic) NSMutableArray *loans;
@property(nonatomic) NSDictionary *loans_repayments;
@property(nonatomic) NSMutableArray *deposits;
@property(nonatomic) NSDictionary *contrib_account;
@property(nonatomic) NSDictionary *passport;
@property(nonatomic) NSDictionary *voen_pasport;
@property(nonatomic) NSDictionary *contact_information;
@property(nonatomic) NSDictionary *role;
+ (id) sharedManager;
- (id) parseUserData;
@end
