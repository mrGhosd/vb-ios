//
//  NewsViewController.h
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIConnect.h"
#import "SWRevealViewController.h"

@interface NewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableData;
}
@property(nonatomic, strong) APIConnect *connection;
@property(nonatomic, weak) id jsonObjects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UITableViewCell *cell;
@end
