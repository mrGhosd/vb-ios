//
//  SharesViewController.h
//  voenbank
//
//  Created by vsokoltsov on 09.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "ViewController.h"
#import "APIConnect.h"

@interface SharesViewController : ViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property(strong, nonatomic) IBOutlet NSDictionary *sharesList;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) APIConnect *connection;
@end
