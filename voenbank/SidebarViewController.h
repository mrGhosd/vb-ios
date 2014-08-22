//
//  SidebarViewController.h
//  voenbank
//
//  Created by vsokoltsov on 26.07.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) id userInformation;
@end
