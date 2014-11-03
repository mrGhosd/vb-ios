//
//  ContributionAccountsViewController.h
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContributionAccountsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) NSArray *depositAccounts;
@end
