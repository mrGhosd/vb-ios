
//  MainViewController.m
//  voenbank
//
//  Created by vsokoltsov on 26.07.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface MainViewController ()
{
    NSString* image ;
}

@end

@implementation MainViewController

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
    
    NSLog(@"MAINVIEWCONTROLLER JSON: %@", [_userInformation objectForKey:@"name"]);
    _nameField.text = [_userInformation objectForKey:@"name"];
    _surnameField.text = [_userInformation objectForKey:@"surname"];
    _secondname_field.text = [_userInformation objectForKey:@"secondname"];
    
    image = @"avatar_url";
    NSString *imageURL = [[NSString alloc] initWithFormat:@"http://127.0.0.1:3000%@",[_userInformation objectForKey:image]];
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *avatar = [[UIImage alloc] initWithData:data];
    _userAvatar.image = avatar;
    NSLog(@"IMAGE URL IS %@", imageURL);
    

    // Do any additional setup after loading the view.
    _sideButton.target = self.revealViewController;
    _sideButton.action = @selector(revealToggle:);
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(revealToggle:)];
    [self.navigationController.view addGestureRecognizer:gesture];
    [self.navigationController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
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

- (IBAction)sidebarButton:(id)sender {
}
@end
