//
//  ViewController.m
//  voenbank
//
//  Created by vsokoltsov on 22.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "CurrentUserViewController.h"

@interface ViewController ()
{
    NSMutableArray *userObject;

    NSDictionary *UserList;
    NSString *login;
    NSString *password;
}


@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_creditView setHidden:YES];
    [_depositView setHidden:YES];
    _sliderAmount.minimumValue = 15000;
    _sliderAmount.maximumValue = 90000;
    [self.sliderAmount setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderAmount setMinimumTrackImage:[UIImage imageNamed:@"sliderFilledArea.png"]
                               forState:UIControlStateNormal];
    [self.sliderAmount setMaximumTrackImage:[UIImage imageNamed:@"sliderUnfilledArea.png"]
                                   forState:UIControlStateNormal];
    [self.sliderTime setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderTime setMinimumTrackImage:[UIImage imageNamed:@"sliderFilledArea.png"]
                                   forState:UIControlStateNormal];
    [self.sliderTime setMaximumTrackImage:[UIImage imageNamed:@"sliderUnfilledArea.png"]
                                   forState:UIControlStateNormal];

    
    
    _sliderTime.minimumValue = 3;
    _sliderTime.maximumValue = 15;
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)segment:(id)sender {
    switch (self.segmentControl.selectedSegmentIndex)
    {
        case 0:
            [_creditView setHidden:YES];
            [_depositView setHidden:YES];
            break;
        case 1:
            [_creditView setHidden:NO];
            [_depositView setHidden:YES];
            break;
        case 2:
            [_creditView setHidden:NO];
            [_depositView setHidden:NO];
        default: 
            break; 
    }
}
- (IBAction)sliderAmount:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    int val = slider.value;
    
    if (val >= 30000)
    {
        _sliderTime.value = 6;
    }
    if (val >= 45000)
    {
        _sliderTime.value = 9;
    }
    if (val >= 72000)
    {
        _sliderTime.value = 12;
    }
    
    self.creditAmount.text = [NSString stringWithFormat:@"%i р.", val];
    
    
}

- (IBAction)sliderTime:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    int val = slider.value;
    
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
        CurrentUserViewController *toViewController=[[CurrentUserViewController alloc] initWithNibName:@"CurrentUserViewController" bundle:nil];
        [self.navigationController pushViewController:toViewController animated:YES];
	// можно вывести в консоль и посмотреть - что мы получили
	NSLog( @"%@",result );
    NSLog(@"ID: %@", [jsonObject objectForKey:@"name"]);
    
	}
}

- (IBAction)authButton:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"api.voenbank.com:3000/api/users/login"];    //создаем объект NSURL с адресом, на который
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



@end
