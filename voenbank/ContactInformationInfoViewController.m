//
//  ContactInformationInfoViewController.m
//  voenbank
//
//  Created by vsokoltsov on 01.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "ContactInformationInfoViewController.h"
#import "User.h"

@interface ContactInformationInfoViewController () {
    User *user;
}

@end

@implementation ContactInformationInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUser];
    [self initContactInformationData];
    // Do any additional setup after loading the view.
}
- (void) initUser {
    user = [[User sharedManager] parseUserData];
}
- (void) initContactInformationData {
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
