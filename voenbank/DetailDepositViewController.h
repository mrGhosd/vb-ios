//
//  DetailDepositViewController.h
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailDepositViewController : UIViewController
@property(strong, nonatomic) NSDictionary *deposit;
@property (strong, nonatomic) IBOutlet UILabel *depositTitle;
@property (strong, nonatomic) IBOutlet UILabel *depositSum;
@property (strong, nonatomic) IBOutlet UILabel *depositResponse;
@property (strong, nonatomic) IBOutlet UILabel *depositDaysDiff;
@property (strong, nonatomic) IBOutlet UILabel *depositCreate;
- (IBAction)contributionAccounts:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *depositUpdate;
@end
