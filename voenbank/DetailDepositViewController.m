//
//  DetailDepositViewController.m
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "DetailDepositViewController.h"
#import "ContributionAccountsViewController.h"

@interface DetailDepositViewController (){
    NSArray *currentAccounts;
}

@end

@implementation DetailDepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDepositDetail];
    // Do any additional setup after loading the view.
}
- (void) initDepositDetail {
    self.depositTitle.text = [NSString stringWithFormat:@"Вклад №%@", [self.deposit objectForKey:@"id"]];
    self.depositSum.text = [NSString stringWithFormat:@"%@ рублей", [self.deposit objectForKey:@"deposit_current_summ"]];
    self.depositResponse.text = [self getDepostResponseValue];
    self.depositDaysDiff.text = [NSString stringWithFormat:@"%@ дней", [self.deposit objectForKey:@"days_diff"]];
    self.depositCreate.text = [NSString stringWithFormat:@"%@", [self.deposit objectForKey:@"created_at"]];
    self.depositUpdate.text = [NSString stringWithFormat:@"%@", [self.deposit objectForKey:@"updated_at"]];
    
}
- (NSString *) getDepostResponseValue{
    NSString *result;
    NSString *response = [self.deposit objectForKey:@"response"];
    if(response != [NSNull null] && response.boolValue){
        result = @"Подтвержден";
    }
    else {
        result = @"Не подтвержден";
    }
    return result;
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

- (IBAction)contributionAccounts:(id)sender {
    currentAccounts = [NSArray arrayWithArray:[self.deposit objectForKey:@"contribution_accounts"]];
    [self performSegueWithIdentifier:@"accounts" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"accounts"]) {
        ContributionAccountsViewController *accounts = segue.destinationViewController;
        accounts.depositAccounts = [NSArray arrayWithArray:currentAccounts];
    }
}
@end
