//
//  VoenPasportInfoViewController.m
//  voenbank
//
//  Created by vsokoltsov on 01.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "VoenPasportInfoViewController.h"
#import "User.h"

@interface VoenPasportInfoViewController () {
    User *user;
}

@end

@implementation VoenPasportInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUser];
    [self initVoenPasportData];
    
    // Do any additional setup after loading the view.
}
- (void)initUser {
    user = [[User sharedManager] parseUserData];
}

- (void) initVoenPasportData {
    self.infoVoenPasportSeria.text = [NSString stringWithFormat:@"%@", [user.voen_pasport objectForKey:@"voen_seria"]];
    self.infoVoenPasportNumber.text = [NSString stringWithFormat:@"%@", [user.voen_pasport objectForKey:@"voen_number"]];
    self.infoVoenPasportWhen.text = [NSString stringWithFormat:@"%@", [user.voen_pasport objectForKey:@"voen_when"]];
    self.infoVoenPasportWhere.text = [user.voen_pasport objectForKey:@"voen_where"];
    self.infoVoenPasportNationality.text = [user.voen_pasport objectForKey:@"user_nationality"];
    self.infoVoenPasportEducation.text = [user.voen_pasport objectForKey:@"user_education"];
    self.infoVoenPasportRelationship.text = [user.voen_pasport objectForKey:@"user_relationship"];
    self.infoVoenPasportSpecialization.text = [user.voen_pasport objectForKey:@"user_specialization"];
    self.infoVoenPasportSportMastery.text = [user.voen_pasport objectForKey:@"user_sport_mastery"];
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
