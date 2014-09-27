//
//  ViewController.h
//  voenbank
//
//  Created by vsokoltsov on 22.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationViewController.h"
#import "RegViewController.h"

@interface ViewController : UIViewController
{
    NSMutableData *userData;
}


//segmentControl
@property(strong, nonatomic) IBOutlet UIView *view;

@property (nonatomic, retain) NSMutableData *userData;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)segment:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *entryView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property(nonatomic, weak) IBOutlet UIView *regView;


- (IBAction)sliderAmount:(id)sender;
- (IBAction)sliderTime:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *creditAmount;
@property (weak, nonatomic) IBOutlet UILabel *creditTime;
@property (weak, nonatomic) IBOutlet UISlider *sliderAmount;
@property (weak, nonatomic) IBOutlet UISlider *sliderTime;
- (IBAction)authButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *creditView;
@property (weak, nonatomic) IBOutlet UIView *depositView;
@property (weak, nonatomic) IBOutlet UISlider *depositAmount;
- (IBAction)depositAmount:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *depositTime;
- (IBAction)depositTime:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *depositAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *depositTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditAmountValue;
@property (weak, nonatomic) IBOutlet UILabel *creditTimeValue;
@property (weak, nonatomic) IBOutlet UIButton *loanRegistration;
- (IBAction)loanRegistration:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *depositRegistration;
- (IBAction)depositRegistration:(id)sender;


-(IBAction)showRegisterView;
@end
