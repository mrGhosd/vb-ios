//
//  RegistrationViewController.m
//  voenbank
//
//  Created by vsokoltsov on 01.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController (){
    UIDatePicker *date;
}


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
    [self setTimeAndSum];
    [self setupDatePicker];
    [_dateOfBirthField setInputView:date];
//    [scroll setScrollEnabled:YES];
//    [scroll setContentSize:CGSizeMake(320, 784)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(NSString *) formRequestParams{
    NSString *params = [NSString stringWithFormat:@"surname=%@&name=%@&secondname=%@&date_of_birth=%@&sum=%@&time=%@&phone=%@&email=%@&type=%@&role=%@", _surnameField.text, _nameField.text, _secondNameField.text, _dateOfBirthField.text, _surnameField.text,
                        _timeField.text, _phoneNumberField.text, _emailField.text, _operationType, _userRole];
    return params;
}
- (IBAction)registrationButton:(id)sender {
    if([self isFieldCorrect]){
        NSString *param = [self formRequestParams];
        [self.connection getData:@"/users" params:param type:@"POST" success:^(id json){
            [self showAlertWindow:@"Поздравляем!" text:@"Спасбио за регистрацию в нашем сервисе!"];
            [self performSegueWithIdentifier:@"entryViewBack" sender:self];
        }];
    } else {
        [self showAlertWindow:@"Ошибка!" text:@"Поля пустые! Заполните выделенные поля для продолжения"];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"entryViewBack"]){
        EntryViewController *view = segue.destinationViewController;
    }
}
@end
