//
//  DetailLoanViewController.h
//  voenbank
//
//  Created by vsokoltsov on 02.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailLoanViewController : UIViewController
@property(strong, nonatomic) NSMutableDictionary *loanInfo;
@property (strong, nonatomic) IBOutlet UILabel *loanTitle;
@property (strong, nonatomic) IBOutlet UILabel *loanSum;
@property (strong, nonatomic) IBOutlet UILabel *loanTime;
@property (strong, nonatomic) IBOutlet UILabel *loanBeginDate;
@property (strong, nonatomic) IBOutlet UILabel *loanEndDate;
@property (strong, nonatomic) IBOutlet UILabel *loanResponse;
@property (strong, nonatomic) IBOutlet UILabel *loanStatus;
@property (strong, nonatomic) IBOutlet UILabel *loanPayedSum;
@property (strong, nonatomic) IBOutlet UILabel *loanCurrentDay;

@end
