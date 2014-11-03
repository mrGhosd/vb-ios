    
//  MainViewController.m
//  voenbank
//
//  Created by vsokoltsov on 26.07.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "User.h"
#import "PersonalInfoViewController.h"
#import "LoansListViewController.h"
#import "DepositsListViewController.h"

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
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideButton setTarget: self.revealViewController];
        [self.sideButton setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
    }

//    [self callSideBarButton];
    [self setupMainPageData];
    
    
}
-(void) setupMainPageData{
    User *user = [[User sharedManager] parseUserData];
    
    
    _nameField.text = [user.main objectForKey:@"name"];
    _surnameField.text = [user.main objectForKey:@"surname"];
    _secondname_field.text = [user.main objectForKey:@"secondname"];
    self.roleField.text = [user.main objectForKey:@"user_role"];
    self.dateOfBirthField.text = [user.main objectForKey:@"date_of_birth"];
    
    image = @"avatar_url";
    NSString *imageURL = [[NSString alloc] initWithFormat:@"http://127.0.0.1:3000%@",[user.main objectForKey:image]];
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *avatar = [[UIImage alloc] initWithData:data];
    _userAvatar.image = avatar;
//    NSLog(@"IMAGE URL IS %@", imageURL);

}
- (void) callSideBarButton{
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
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"personalInfo"]){
        PersonalInfoViewController *view = segue.destinationViewController;
    }
    if([[segue identifier] isEqualToString:@"loans"]){
        LoansListViewController *list = segue.destinationViewController;
    }
    if([[segue identifier] isEqualToString:@"deposits"] ){
        DepositsListViewController *list = segue.destinationViewController;
    }
}

- (IBAction)loansList:(id)sender {
}
@end
