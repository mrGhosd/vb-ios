//
//  NewsViewController.h
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIConnect.h"


@interface NewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableData;
}
@property(nonatomic, strong) APIConnect *connection;
@property(nonatomic, weak) id jsonObjects;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property(nonatomic, strong) IBOutlet NSDictionary *currentCellData;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell;
@end
