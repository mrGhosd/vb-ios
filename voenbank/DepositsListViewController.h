//
//  DepositsListViewController.h
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepositsListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;

@end
