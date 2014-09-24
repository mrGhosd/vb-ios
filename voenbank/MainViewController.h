//
//  MainViewController.h
//  voenbank
//
//  Created by vsokoltsov on 26.07.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideButton;
@property(nonatomic) id userInformation;
- (IBAction)sidebarButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *surnameField;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *secondname_field;
@end
