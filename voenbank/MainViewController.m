    
//  MainViewController.m
//  voenbank
//
//  Created by vsokoltsov on 26.07.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "User.h"
#import "APIConnect.h"
#import "PersonalInfoViewController.h"
#import "LoansListViewController.h"
#import "DepositsListViewController.h"
#import "EntryViewController.h"
#import <UICKeyChainStore.h>

@interface MainViewController ()
{
    NSString* image;
    APIConnect *api;
    NSString *userID;
    User *user;
    UICKeyChainStore *store;
    UIRefreshControl *refreshControl;
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
    [self defineNavigationPanel];
    [self refreshInit];
    [self setupMainPageData];
}
-(void) defineNavigationPanel{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideButton setTarget: self.revealViewController];
        [self.sideButton setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
    }
}
- (void) refreshInit{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.scrollView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(updateUserInfo) forControlEvents:UIControlEventValueChanged];
}
- (void) updateUserInfo{
    NSString *url = [NSString stringWithFormat:@"/users/%@", userID];
    [api staticPagesInfo:url withComplition:^(id data, BOOL result){
        if(result){
            [self parseUserData:data];
        } else {
            
        }
    }];
}

-(void) parseUserData:(id)data{
    [user parseUserInfo:data];
    [self setupMainPageData];
    [refreshControl endRefreshing];
}

-(void) setupMainPageData{
    api = [[APIConnect alloc] init];
    user = [User sharedManager];
    userID = user.main[@"id"];
    _nameField.text = [user.main objectForKey:@"name"];
    _surnameField.text = [user.main objectForKey:@"surname"];
    _secondname_field.text = [user.main objectForKey:@"secondname"];
    self.roleField.text = [user.main objectForKey:@"user_role"];
    self.dateOfBirthField.text = [user.main objectForKey:@"date_of_birth"];
    self.place_of_birth.text = user.main[@"place_of_birth"];
    _userAvatar.image = [api loadImageHelper:user.main[@"avatar_url"]];
    
    _userAvatar.clipsToBounds = YES;
    _userAvatar.layer.borderWidth = 3.0f;
    _userAvatar.layer.borderColor = [UIColor grayColor].CGColor;
    _userAvatar.layer.cornerRadius = 10.0f;

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
- (IBAction)exitButtonTap:(id)sender {
    store = [UICKeyChainStore keyChainStore];
    [store removeItemForKey:@"login"];
    [store removeItemForKey:@"password"];
    [store synchronize];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    EntryViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"EntryViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
