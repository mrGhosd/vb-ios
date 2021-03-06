//
//  ViewController.m
//  voenbank
//
//  Created by vsokoltsov on 22.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "MainViewController.h"
#import "SidebarViewController.h"
#import "RegistrationViewController.h"

@interface ViewController ()
{
    NSMutableArray *userObject;
    
    NSDictionary *UserList;
    NSString *login;
    NSString *password;
}


@end

@implementation ViewController
@synthesize entryView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewsInit];
    [_creditView setHidden:YES];
    [_depositView setHidden:YES];
    
    _depositAmount.minimumValue = 1000000;
    _depositAmount.maximumValue = 3000000;
    _depositTime.minimumValue = 12;
    _depositTime.maximumValue = 36;
    
    
    [self.depositAmount setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.depositAmount setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                    forState:UIControlStateNormal];
    [self.depositAmount setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                    forState:UIControlStateNormal];
    [self.depositTime setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.depositTime setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                  forState:UIControlStateNormal];
    [self.depositTime setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                  forState:UIControlStateNormal];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewsInit{
//    RegViewController *registrationView = [[RegViewController alloc] initWithNibName:@"RegViewController" bundle:nil];
//    UIView *myView = self.loginView;
//    UIView *superView = self.entryView;
//    self.regView = registrationView.view;
    
//    self.secondnView.backgroundColor = [UIColor redColor];
//    registrationView.view.backgroundColor = [UIColor redColor];
    [self.regView setHidden:YES];
    
//    [self.ent addSubview:self.regView];
}

-(void) setRegistrationView:(int) index
{
    if(index == 0){
        [self.loginView setHidden:NO];
        [self.regView setHidden:YES];
    } else if(index == 1) {
        [self.loginView setHidden:YES];
        [self.regView setHidden:NO];
    }

//    [self.navigationController pushViewController:regView animated:NO];
}

- (IBAction)segment:(id)sender {
    [self setRegistrationView:self.segmentControl.selectedSegmentIndex];
//    switch (self.segmentControl.selectedSegmentIndex)
//    {
//        case 0:
//        case 1:
//        case 2:
//            [entryView setHidden:YES];
//            [self setRegistrationView];
//            break;
//        default:
//            break;
//    }
}
- (IBAction)sliderAmount:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    int val = slider.value;
    
    if (val >= 30000)
    {
        _sliderTime.value = 6;
        _creditTime.text = @"6 м.";
        
    }
    if (val >= 45000)
    {
        _sliderTime.value = 9;
        _creditTime.text = @"9 м.";
    }
    if (val >= 72000)
    {
        _sliderTime.value = 12;
        _creditTime.text = @"12 м.";
    }
    
    self.creditAmount.text = [NSString stringWithFormat:@"%i р.", val];
}

- (IBAction)depositAmount:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    int val = slider.value;
    
    if (val >= 600000)
    {
        _depositTime.value = 12;
        _depositTimeLabel.text = @"12 м.";
        
    }
    if (val >= 1200000)
    {
        _depositTime.value = 24;
        _depositTimeLabel.text = @"24 м.";
    }
    if (val >= 2400000)
    {
        _depositTime.value = 36;
        _depositTimeLabel.text = @"36 м.";
    }
    
    self.depositAmountLabel.text = [NSString stringWithFormat:@"%i р.", val];
}

- (IBAction)depositTime:(id)sender {
}

- (IBAction)sliderTime:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    int val = slider.value;
    
    if(val >= 3)
    {
        _sliderAmount.value = 30000;
        _creditAmount.text = @"30000 р.";
    }
    if(val >= 6)
    {
        _sliderAmount.value = 45000;
        _creditAmount.text = @"45000 р.";
    }
    if(val >= 12)
    {
        _sliderAmount.value = 72000;
        _creditAmount.text = @"72000 р.";
    }
    
    self.creditTime.text = [NSString stringWithFormat:@"%i м.", val];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"authButton"])
    {
        //        CurrentUserViewController *destViewController = segue.destinationViewController;
        //        destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
        //
    }
    if([segue.identifier isEqualToString:@"loanRegistration"])
    {
        RegistrationViewController *regView = (RegistrationViewController *) segue.destinationViewController;
//        regView.regType = @"Loan";
//        regView.loanSum = _sliderAmount.value;
//        regView.loanTime = _sliderTime.value;

    }
    if([segue.identifier isEqualToString:@"depositRegistration"])
    {
        RegistrationViewController *regView = (RegistrationViewController *) segue.destinationViewController;
//        regView.regType = @"Deposit";
    }
}
/**
 * При получении новой порции данных добавляем их к уже полученным
 **/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [userData appendData:data];
}
/**
 * Если соединение не удалось - выводим в консоль сообщение об ошибке
 **/
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

/**
 * Когда все данные получены - разбираем их
 **/
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *result = [[NSString alloc] initWithData:userData encoding:NSUTF8StringEncoding];
    NSLog(@"result is %@", result);
    if([result isEqualToString:@"null"])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"ОШИБКА"
                              message:@"Пользователя с такими данными не существует"
                              delegate:self
                              cancelButtonTitle: @"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableContainers error:nil];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        MainViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        
        viewController.userInformation = jsonObject;
        [self.navigationController pushViewController:viewController animated:YES];
        
	}
}

- (IBAction)authButton:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"localhost:3000/api/users/login"];    //создаем объект NSURL с адресом, на который
    //будет идти запрос
    
    NSString *params = [NSString stringWithFormat:@"login=%@&password=%@", _loginField.text, _passwordField.text];
    NSData *postData = [params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    //// создаем объект NSURLRequest - запрос
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3000/api/users/login"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    request.HTTPMethod = @"POST";
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection)
    {
        NSLog(@"CONNECTION SUCESS!!");
        userData = [NSMutableData data];
    }
    else
    {
        NSLog(@"Connection failed");
    }
    
    //    // создаем запрос
    //    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"api.voenbank.com:3000/api/users/login"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    //    request.HTTPMethod = @"POST";
    //
    //    // указываем параметры POST запроса
    //    NSString *params = [NSString stringWithFormat:@"login=%@&password=%@", _loginField.text, _passwordField.text];
    //    request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    //
    //    // создаём соединение и начинаем загрузку
    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}



- (IBAction)loanRegistration:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    RegistrationViewController *regView = [storyboard instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
//    
//    regView.regType = @"Loan";
//    [self.navigationController pushViewController:regView animated:YES];
//    RegistrationViewController *regView = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
//    regView.regType = @"Loan";
//    [self.navigationController pushViewController: regView animated:YES];
    
}
- (IBAction)depositRegistration:(id)sender {
}

-(IBAction)showRegisterView{
    [[NSBundle mainBundle] loadNibNamed:@"test" owner:self options:nil];
    [self.view addSubview:self.regView];
}

@end
