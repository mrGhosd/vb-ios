//
//  SidebarViewController.h
//  voenbank
//
//  Created by vsokoltsov on 26.07.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsViewController;
@class MainViewController;
@class SharesViewController;
@class PartnersViewController;
@class LoansListViewController;
@class DepositsListViewController;
@class User;

@interface SidebarViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) id userInformation;
@property (nonatomic, strong) NSArray *menuItems;
@end
