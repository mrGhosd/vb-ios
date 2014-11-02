//
//  MainViewController.h
//  voenbank
//
//  Created by vsokoltsov on 26.07.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideButton;
@property(nonatomic) id userInformation;
- (IBAction)sidebarButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *surnameField;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *secondname_field;
@property (strong, nonatomic) IBOutlet UILabel *roleField;
@property (strong, nonatomic) IBOutlet UILabel *dateOfBirthField;
- (IBAction)personalInfo:(id)sender;
- (IBAction)loansList:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *depositsList;
@end
