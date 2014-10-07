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

@end
