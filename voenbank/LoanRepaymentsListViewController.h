//
//  LoanRepaymentsListViewController.h
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanRepaymentsListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSDictionary *loanInfo;
@property(nonatomic, strong) NSArray *loanRepayments;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
