//
//  RegistrationViewController.h
//  voenbank
//
//  Created by vsokoltsov on 01.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class APIConnect;
@class EntryViewController;

@interface RegistrationViewController : UIViewController <UITextFieldDelegate>{
    IBOutlet UIScrollView *scroll;
}
@property(strong, nonatomic) APIConnect *connection;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;

@property(nonatomic) int sum;
@property(nonatomic) int time;
@property (strong, nonatomic) IBOutlet UITextField *surnameField;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *secondNameField;
@property (strong, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (strong, nonatomic) IBOutlet UITextField *sumField;
@property (strong, nonatomic) IBOutlet UITextField *timeField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UISwitch *sexField;

@property (strong, nonatomic) IBOutlet NSString *userRole;
@property (strong, nonatomic) IBOutlet NSString *operationType;

//@property (nonatomic, weak) IBOutlet  UIDatePicker *date;
- (IBAction)registrationButton:(id)sender;
@end
