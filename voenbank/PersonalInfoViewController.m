//
//  PersonalInfoViewController.m
//  voenbank
//
//  Created by vsokoltsov on 01.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "User.h"
#import "APIConnect.h"

@interface PersonalInfoViewController (){
    NSString *userID;
    User *user;
    APIConnect *api;
    UIRefreshControl *refreshControl;
}

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUser];
    [self refreshInit];
    [self setMainPanelData];
    // Do any additional setup after loading the view.
}
-(void) setUser {
    user = [User sharedManager];
}
- (void) refreshInit{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.scrollView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(updatePersonalUserInfo) forControlEvents:UIControlEventValueChanged];
}
-(void)updatePersonalUserInfo{
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
    [self setMainPanelData];
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setMainPanelData{
    api = [[APIConnect alloc] init];
    userID = user.main[@"id"];
    self.infoSurname.text = [user.main objectForKey:@"surname"];
    self.infoName.text = [user.main objectForKey:@"name"];
    self.infoSecondName.text = [user.main objectForKey:@"secondname"];
    self.infoDateOfBirth.text = [user.main objectForKey:@"date_of_birth"];
    self.infoPlaceOfBirth.text = [user.main objectForKey:@"place_of_birth"];
//    self.infoCreatedAt.text = [user.main objectForKey:@"created_at"];
    self.infoRole.text = [user.main objectForKey:@"user_role"];
    self.infoSex.text = [user.main objectForKey:@"user_sex"];
    self.infoPhone.text = [user.main objectForKey:@"contact_phone"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
