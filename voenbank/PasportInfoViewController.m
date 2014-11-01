//
//  PasportInfoViewController.m
//  voenbank
//
//  Created by vsokoltsov on 01.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "PasportInfoViewController.h"
#import "User.h"

@interface PasportInfoViewController (){
    User *user;
}

@end

@implementation PasportInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUser];
    [self initPasportData];
    // Do any additional setup after loading the view.
}
- (void) initUser {
    user = [[User sharedManager] parseUserData];
}
- (void) initPasportData {
    self.InfoPasportSeria.text = [NSString stringWithFormat:@"%@", [user.passport objectForKey:@"pasport_seria"] ];
    self.infoPasportNumber.text = [NSString stringWithFormat:@"%@", [user.passport objectForKey:@"pasport_number"] ];
    self.infoPasportWhen.text = [user.passport objectForKey:@"pasport_when"];
    self.infoPasportWhere.text = [user.passport objectForKey:@"pasport_where"];
    self.infoPasportDefinitionAddress.text = [user.passport objectForKey:@"definite_registration"];
    self.infoPasportCode.text = [NSString stringWithFormat:@"%@", [user.passport objectForKey:@"pasport_code"]];
    self.infoPasportOldNumber.text = [NSString stringWithFormat:@"%@", [user.passport objectForKey:@"old_pasport_seria"]];
    self.infoPasportOldSeria.text = [NSString stringWithFormat:@"%@", [user.passport objectForKey:@"old_pasport_number"]];
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
