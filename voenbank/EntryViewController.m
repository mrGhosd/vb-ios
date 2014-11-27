//
//  EntryViewController.m
//  voenbank
//
//  Created by vsokoltsov on 27.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "EntryViewController.h"
#import "MainViewController.h"
#import "RegistrationViewController.h"
#import "User.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "RegistrationViewController.h"
#import "APIConnect.h"

@interface EntryViewController ()
@property (weak, nonatomic) UITextField *activeField;
@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    APIConnect *connection = [[APIConnect alloc] init];
    self.connection = connection;
    self.loginField.delegate = self;
//    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    UITapGestureRecognizer *messagesTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    messagesTap.delegate = self;
    [self.navigationItem setHidesBackButton:YES];
    [self initSliderApperance];
}
//- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
//{
//    self.activeField = sender;
//}
//
//- (IBAction)textFieldDidEndEditing:(UITextField *)sender
//{
//    self.activeField = nil;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//// Call this method somewhere in your view controller setup code.
//- (void)registerForKeyboardNotifications
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardDidShow:)
//                                                 name:UIKeyboardDidShowNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
//}
//
//// Called when the UIKeyboardDidShowNotification is sent.
//- (void) keyboardDidShow:(NSNotification *)notification
//{
//    NSDictionary* info = [notification userInfo];
//    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    kbRect = [self.scrollView convertRect:kbRect fromView:nil];
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
//    self.scrollView.contentInset = contentInsets;
//    self.scrollView.scrollIndicatorInsets = contentInsets;
//    
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbRect.size.height;
//    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
//        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
//    }
//}
//
//- (void) keyboardWillBeHidden:(NSNotification *)notification
//{
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    self.scrollView.contentInset = contentInsets;
//    self.scrollView.scrollIndicatorInsets = contentInsets;
//    
//}
-(void) initLittlePopup{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Пожалуйста, выберите роль:" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil otherButtonTitles:
                            @"Курсант",
                            @"В/С контрактной службы",
                            @"Офицер",
                            nil];
    popup.tag = 1;
    [popup showInView:self.sliderView];
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch(buttonIndex)
    {
        case 0:
            _userRole = @"1";
            break;
        case 1:
            _userRole = @"2";
            break;
        case 2:
            _userRole= @"3";
            break;
    }
}
-(void) initSliderApperance{
    [self.sliderAmount setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderAmount setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                   forState:UIControlStateNormal];
    [self.sliderAmount setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                   forState:UIControlStateNormal];
    [self.sliderTime setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderTime setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                 forState:UIControlStateNormal];
    [self.sliderTime setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                 forState:UIControlStateNormal];

}
-(void) initViewWithSliders: (int) segmentValue{
    NSLog(@"segment value is %i", segmentValue);
    if(segmentValue == 1){
        //Займ
        self.operationType= @"Loan";
        self.sliderAmount.minimumValue = 15000;
        self.sliderAmount.maximumValue = 90000;
        self.sliderAmount.value = 21000;
        self.sliderTime.minimumValue = 3;
        self.sliderTime.maximumValue = 15;
        self.sliderTime.value = 3;
        self.sliderSumLabel.text = @"15000 р.";
        self.sliderTimeLabel.text = @"3 м";
        
    } else if(segmentValue == 2) {
        //Вклад
        self.operationType = @"Deposit";
        _sliderAmount.minimumValue = 100000;
        _sliderAmount.maximumValue = 3000000;
        _sliderAmount.value = 300000;
        _sliderTime.minimumValue = 12;
        _sliderTime.maximumValue = 36;
        _sliderTime.value = 12;
        self.sliderSumLabel.text = @"300000 р.";
        self.sliderTimeLabel.text = @"12 м";
    }
    
}


-(void) switchView:(int) index{
    if(index == 0){
        [self.sliderView setHidden:YES];
        [self.loginView setHidden:NO];
    } else {
        if(index == 1)
        {
            
        }
        [self initViewWithSliders:index];
        [self.sliderView setHidden:NO];
        [self.loginView setHidden:YES];
        if(self.roleWindowShow != true){
            [self initLittlePopup];
            self.roleWindowShow = true;
        }

    }
}

- (IBAction)authButton:(id)sender {
    if([_loginField.text length] == 0 || [_passwordField.text length] == 0){
        [self showAlertWindow:@"ОШИБКА" text:@"Поле логин и/или пароль пустое!"];
    } else {
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     _loginField.text, @"login",
                                     _passwordField.text, @"password", nil];
        [MBProgressHUD showHUDAddedTo:self.view
                             animated:YES];
        [self.connection login:data forUrl:@"/users/login" withComplition:^(id data, BOOL result){
            if(result){
                [self toUserProfile:data];
            } else {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
        }];
    }
}
-(void) toUserProfile:(id) user{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    MainViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    User *userObject = [User sharedManager];
    [userObject parseUserInfo:user];
//    userObject.userData = user;
    viewController.userInformation = user;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)viewSwitcher:(id)sender {
    [self switchView:self.segment.selectedSegmentIndex];
}

- (IBAction)changeTime:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    int val = slider.value;
    self.sliderTimeLabel.text = [NSString stringWithFormat:@"%i м.", val];
}

- (IBAction)changeAmount:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int val = slider.value;
    self.sliderSumLabel.text = [NSString stringWithFormat:@"%i р.", val];
}

-(void) showAlertWindow: (NSString *) title text:(NSString *) text{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:text
                          delegate:self
                          cancelButtonTitle: @"OK"
                          otherButtonTitles:nil];
    [alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"registrationView"]) {
        RegistrationViewController *registration = segue.destinationViewController;
        registration.sum = _sliderAmount.value;
        registration.time = _sliderTime.value;
        registration.userRole = _userRole;
        registration.operationType = self.operationType;
    }
}

- (IBAction)outerTouch:(id)sender {
    
}
@end
