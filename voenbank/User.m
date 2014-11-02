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
-(NSDictionary *) parsePassed:(id) data{
    NSData *testData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:testData options:NSUTF8StringEncoding error:nil];
    return dict;
}
- (id) parseUserData{
    self.loans = [[NSMutableArray alloc] init];
    self.deposits = [[NSMutableArray alloc] init];
    for(id key in self.userData){
        NSDictionary *result = [self parsePassed:[self.userData objectForKey:key]];
        if([key isEqualToString:@"main"]){
            self.main = result;
        }
        if([key isEqualToString:@"loans"]){
            NSDictionary *parentDict;
            NSMutableArray *repaymentArr = [[NSMutableArray alloc] init];
            
            for(NSDictionary *arr in result){
                if([arr objectForKey:@"repayments"]){
                    NSDictionary *repaymentDictionary;
                    for(NSDictionary *testDict in [arr objectForKey:@"repayments"]){
                        repaymentDictionary = [self parsePassed:testDict];
                        [repaymentArr addObject:repaymentDictionary];
                    }
                }
                parentDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [arr objectForKey:@"id"], @"id",
                              [arr objectForKey:@"user_id"], @"user_id",
                              [arr objectForKey:@"loan_sum"], @"loan_sum",
                              [arr objectForKey:@"begin_date"], @"begin_date",
                              [arr objectForKey:@"end_date"], @"end_date",
                              [arr objectForKey:@"percent_id"], @"percent_id",
                              [arr objectForKey:@"status"], @"status",
                              [arr objectForKey:@"response"], @"response",
                              [arr objectForKey:@"date_in_days"], @"date_in_days",
                              [arr objectForKey:@"date_in_months"], @"date_in_months",
                              [arr objectForKey:@"closest_payment_date"], @"closest_payment_date",
                              [arr objectForKey:@"current_day_in_loan_history"], @"current_day_in_loan_history",
                              [arr objectForKey:@"payed_sum"], @"payed_sum",
                              repaymentArr, @"repayments",
                              nil];
                [self.loans addObject:parentDict];
            }

        }
        if([key isEqualToString:@"deposits"]){
            NSDictionary *parentDict;
            for(NSDictionary *arr in result){
                parentDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [arr objectForKey:@"id"], @"id",
                              [arr objectForKey:@"user_id"], @"user_id",
                              [arr objectForKey:@"deposit_current_summ"], @"deposit_current_summ",
                              [arr objectForKey:@"percent_id"], @"percent_id",
                              [arr objectForKey:@"response"], @"response",
                              [arr objectForKey:@"created_at"], @"created_at",
                              [arr objectForKey:@"updated_at"], @"updated_at",
                              nil];
                [self.deposits addObject:parentDict];
            }
        }
        if([key isEqualToString:@"passport"]){
            self.passport = result;
        }
        if([key isEqualToString:@"voen_pasport"]){
            self.voen_pasport = result;
        }
        if([key isEqualToString:@"contact_information"]){
            self.contact_information = result;
        }
        if([key isEqualToString:@"role"]){
            self.role = result;
        }
    }
    return self;
}
@end
