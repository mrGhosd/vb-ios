//
//  LoansListViewController.h
//  voenbank
//
//  Created by vsokoltsov on 02.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWRevealViewController;
@class SidebarViewController;
@class DetailLoanViewController;
@class User;

@interface LoansListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property(strong, nonatomic) NSMutableDictionary *choosenLoan;
@end
