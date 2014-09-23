//
//  RegistrationViewController.h
//  voenbank
//
//  Created by vsokoltsov on 01.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
enum regType
{
    loan,
    deposit
};
@interface RegistrationViewController : UIViewController
@property(nonatomic, retain) NSString *regType;
@property(nonatomic) float loanSum;
@property(nonatomic) float loanTime;
@property(nonatomic) float *depositSum;
@property(nonatomic) float *depositTime;
@end
