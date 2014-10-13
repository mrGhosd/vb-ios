//
//  EntryViewController.h
//  voenbank
//
//  Created by vsokoltsov on 27.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationViewController.h"
#import "APIConnect.h"

@interface EntryViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property(strong, nonatomic) IBOutlet UIView *sliderView;
- (IBAction)viewSwitcher:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) IBOutlet UITextField *loginField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UILabel *sliderSumLabel;
@property (strong, nonatomic) IBOutlet UILabel *sliderTimeLabel;
@property (strong, nonatomic) IBOutlet NSString *operationType;
@property (strong, nonatomic) IBOutlet APIConnect *connection;
- (IBAction)authButton:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *sliderAmount;
@property (weak, nonatomic) IBOutlet UISlider *sliderTime;

@property (nonatomic) Boolean roleWindowShow;
@property (nonatomic) NSString *userRole;

- (IBAction)changeAmount:(id)sender;
- (IBAction)changeTime:(id)sender;


@end
