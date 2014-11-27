//
//  RegistrationViewController.m
//  voenbank
//
//  Created by vsokoltsov on 01.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "RegistrationViewController.h"
#import "APIConnect.h"
#import "EntryViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface RegistrationViewController (){
    UIDatePicker *date;
}
@property (weak, nonatomic) UITextField *activeField;

@end

@implementation RegistrationViewController

@synthesize sum;
@synthesize time;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initApi];
    [self registerForKeyboardNotifications];
    [self setTimeAndSum];
    [self setupDatePicker];
    [_dateOfBirthField setInputView:date];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)sender
{
    self.activeField = nil;
}
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [scroll convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    scroll.contentInset = contentInsets;
    scroll.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [scroll scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scroll.contentInset = contentInsets;
    scroll.scrollIndicatorInsets = contentInsets;
}


-(void) initApi{
    APIConnect *connection = [[APIConnect alloc] init];
    self.connection = connection;
}

-(void) setupDatePicker{
    date = [[UIDatePicker alloc] init];
    [date addTarget:self action:@selector(updateDateOfBirthField:) forControlEvents:UIControlEventValueChanged];
    date.datePickerMode = UIDatePickerModeDate;
}
-(void) updateDateOfBirthField:(id) sender{
    UIDatePicker *picker = (UIDatePicker *)self.dateOfBirthField.inputView;
    self.dateOfBirthField.text = [NSString stringWithFormat:@"%@", picker.date];
}
-(void) setTimeAndSum{
    _sumField.text = [NSString stringWithFormat:@"%i",self.sum];
    _timeField.text = [NSString stringWithFormat:@"%i", self.time];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL) isFieldCorrect{
    Boolean result = '\0';
    NSArray *fieldsArr = @[_surnameField, _nameField, _secondNameField, _dateOfBirthField, _sumField, _timeField, _phoneNumberField,
                           _emailField];
    for(UITextField *field in fieldsArr){
        field.layer.borderWidth = 1.0;
        field.layer.cornerRadius=8.0f;
        
        if(field == _dateOfBirthField)
        {
            
        }
        
        if([field.text length] == 0){
            field.layer.borderColor = [[UIColor redColor]CGColor];
            result = false;
        } else
        {
            field.layer.borderColor = [[UIColor clearColor]CGColor];
            result = true;
        }
    }
    return result;
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
-(NSDictionary *) formRequestParams{
    NSString *mainUserDictKey;
    NSDictionary *mainUserDict;
    
    if([self.operationType isEqualToString:@"Loan"]){
        mainUserDictKey = @"loans_attributes";
        NSDate *beginDate = [NSDate date];
        NSDate *endDate = [self showEndDate];
        mainUserDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                        self.sumField.text, @"sum",
                        [NSString stringWithFormat:@"%@", beginDate], @"begin_date",
                        [NSString stringWithFormat:@"%@", endDate ], @"end_date",
                        nil];
    } else if([self.operationType isEqualToString:@"Deposit"])
    {
        mainUserDictKey = @"deposits_attributes";
        mainUserDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                        self.sumField.text, @"current_amount",
                        nil];
    }
    NSDictionary *contactInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.emailField.text, @"email", nil];
    NSDictionary *mainData = [[NSDictionary alloc] initWithObjectsAndKeys:
                              self.surnameField.text, @"surname",
                              self.nameField.text, @"name",
                              self.secondNameField.text, @"secondname",
                              self.dateOfBirthField.text, @"date_of_birth",
                              self.phoneNumberField.text, @"contact_phone",
                              [NSString stringWithFormat:@"%hhd", [self getSexFieldData]], @"sex",
                              contactInfo, @"contact_information_attributes",
                              mainUserDict, mainUserDictKey,
                              self.userRole, @"role_id",
                              self.operationType, @"operation", nil];
    return mainData;
}

- (NSDate *) showEndDate{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    int months = self.timeField.text.integerValue;
    [dateComponents setMonth:months];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    return newDate;
}
- (IBAction)registrationButton:(id)sender {
//    if([self isFieldCorrect]){
//        NSDictionary *param = [self formRequestParams];
//        [self.connection getData:@"/users" params:param type:@"POST" success:^(id json){
//            [self showAlertWindow:@"Поздравляем!" text:@"Спасбио за регистрацию в нашем сервисе!"];
//            [self performSegueWithIdentifier:@"entryViewBack" sender:self];
//        }];
//    } else {
//        [self showAlertWindow:@"Ошибка!" text:@"Поля пустые! Заполните выделенные поля для продолжения"];
//    }
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    [self.connection login:[self formRequestParams] forUrl:@"/users" withComplition:^(id data, BOOL result){
        if(result){
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self showAlertWindow:@"Поздравляем!" text:@"Спасбио за регистрацию в нашем сервисе!"];
            [self performSegueWithIdentifier:@"entryViewBack" sender:self];;
        } else {

        }
    }];
}
- (BOOL) getSexFieldData{
    if([self.sexField isOn]){
        return YES;
    } else {
        return NO;
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"entryViewBack"]){
        EntryViewController *view = segue.destinationViewController;
    }
}
@end
