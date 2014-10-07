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
@property(nonatomic, strong) APIConnect *connection;
@property(nonatomic, weak) id jsonObjects;
@end
