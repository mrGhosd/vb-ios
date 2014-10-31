//
//  RightPanelViewController.h
//  voenbank
//
//  Created by vsokoltsov on 15.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightPanelViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSArray *menuItems;
@property (strong, nonatomic) IBOutlet UIView *loanView;
@property (strong, nonatomic) IBOutlet UIView *depositView;
@property (strong, nonatomic) IBOutlet UIImageView *loanArrow;
@property (strong, nonatomic) IBOutlet UIImageView *depositArrow;
@property (strong, nonatomic) IBOutlet UIView *emptyLoanView;
@property (strong, nonatomic) IBOutlet UIView *emptyDepositView;
@end
