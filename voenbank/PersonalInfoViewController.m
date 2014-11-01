//
//  PersonalInfoViewController.m
//  voenbank
//
//  Created by vsokoltsov on 01.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "User.h"

@interface PersonalInfoViewController (){
    User *user;
}

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUser];
    [self setMainPanelData];
    // Do any additional setup after loading the view.
}
-(void) setUser {
    user = [[User sharedManager] parseUserData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setMainPanelData{
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
