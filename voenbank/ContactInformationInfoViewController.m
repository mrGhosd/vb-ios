//
//  ContactInformationInfoViewController.m
//  voenbank
//
//  Created by vsokoltsov on 01.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "ContactInformationInfoViewController.h"
#import "User.h"
#import "APIConnect.h"

@interface ContactInformationInfoViewController () {
    NSString *userID;
    APIConnect *api;
    User *user;
    UIRefreshControl *refreshControl;
}

@end

@implementation ContactInformationInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    api = [[APIConnect alloc] init];
    [self initUser];
    [self refreshInit];
    [self initContactInformationData];
    // Do any additional setup after loading the view.
}
- (void) initUser {
    user = [User sharedManager] ;
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
    [self initContactInformationData];
    [refreshControl endRefreshing];
}
- (void) initContactInformationData {
    userID = user.main[@"id"];
    self.infoContactAddress.text = [user.contact_information objectForKey:@"actual_adress"];
    self.infoContactPhone.text = [NSString stringWithFormat:@"%@", [user.contact_information objectForKey:@"phone_adress"]];
    self.infoContactEmail.text = [user.contact_information objectForKey:@"email"];
    self.infoContactPersonSurname.text = [user.contact_information objectForKey:@"contact_person_surname"];
    self.infoContactPersonName.text = [user.contact_information objectForKey:@"contact_person_name"];
    self.infoContactPersonSecondName.text = [user.contact_information objectForKey:@"contact_person_secondname"];
    self.infoContactPersonPhone.text = [NSString stringWithFormat:@"%@", [user.contact_information objectForKey:@"contact_person_phone"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
