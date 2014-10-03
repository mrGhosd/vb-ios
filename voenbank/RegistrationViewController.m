//
//  RegistrationViewController.m
//  voenbank
//
//  Created by vsokoltsov on 01.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()


@end

@implementation RegistrationViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    _backButton.title = @"wadwa";
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(320, 784)];

//    self.navigationController.navigationBar.titleTextAttributes=@"Назад";
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationController.na
//    vigationBar.tintColor = [UIColor blackColor];
//    self.navigationItem.backBarButtonItem = backButton;
    // Do any additional setup after loading the view.
//    NSLog(@"regType is %@, loan sum is %f and time is %f", regType, loanSum, loanTime);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
