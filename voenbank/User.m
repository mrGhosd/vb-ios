//
//  User.m
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userData;

static User *sharedSingleton_ = nil;

+ (id) sharedManager{
    static User *sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUser = [[self alloc] init];
    });
    return sharedUser;
}
- (id)init {
    if (self = [super init]) {
        userData = @"Default Property Value";
    }
    return self;
}
-(void) parseUserInfo:(id)data{
    self.main = [self convertUserInfo:data[@"main"]];
    self.passport = [self convertUserInfo:data[@"passport"]];
    self.voen_pasport = [self convertUserInfo:data[@"voen_pasport"]];
    self.contact_information = [self convertUserInfo:data[@"contact_information"]];
    [self initLoanData:data];
    [self initDepositData:data];
}

-(void) initLoanData:(id)info{
    NSData *testData = [info[@"loans"] dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *loans = [NSJSONSerialization JSONObjectWithData:testData options:NSUTF8StringEncoding error:nil];
    self.loans = [NSMutableArray arrayWithArray:loans];
}
-(void) initDepositData:(id)info{
    NSData *testData = [info[@"deposits"] dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *deposits = [NSJSONSerialization JSONObjectWithData:testData options:NSUTF8StringEncoding error:nil];
    self.deposits = [NSMutableArray arrayWithArray:deposits];
}
-(NSDictionary *) convertUserInfo:(id) data{
    NSData *testData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:testData options:NSUTF8StringEncoding error:nil];
    return dict;
}
@end
