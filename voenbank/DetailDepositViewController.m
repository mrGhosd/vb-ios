//
//  DetailDepositViewController.m
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "DetailDepositViewController.h"
#import "ContributionAccountsViewController.h"
#import "APIConnect.h"

@interface DetailDepositViewController (){
    NSArray *currentAccounts;
    APIConnect *api;
    UIRefreshControl *refreshControl;
    NSString *userID;
    NSString *depositID;
}

@end

@implementation DetailDepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    api = [[APIConnect alloc] init];
    [self refreshInit];
    [self initDepositDetail];
    // Do any additional setup after loading the view.
}

- (void) refreshInit{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.scrollView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(updateDepositInfo) forControlEvents:UIControlEventValueChanged];
}

-(void)updateDepositInfo{
    NSString *url = [NSString stringWithFormat:@"/users/%@/deposits/%@", userID, depositID];
    [api staticPagesInfo:url withComplition:^(id data, BOOL result){
        if(result){
            [self parseLoanInfo:data];
        } else {
            
        }
    }];
}
- (void) parseLoanInfo:(id) data{
    self.deposit = (NSMutableDictionary *)data;
    [self initDepositDetail];
    [refreshControl endRefreshing];
}


- (void) initDepositDetail {
    userID = self.deposit[@"user_id"];
    depositID = self.deposit[@"id"];
    self.depositTitle.text = [NSString stringWithFormat:@"Вклад №%@", [self.deposit objectForKey:@"id"]];
    self.depositSum.text = [NSString stringWithFormat:@"%@ рублей", [self.deposit objectForKey:@"current_amount"]];
    self.depositResponse.text = [self getDepostResponseValue];
    self.depositDaysDiff.text = [NSString stringWithFormat:@"%@ дней", [self.deposit objectForKey:@"days_diff"]];
    self.depositCreate.text = [self correctConvertOfDate:[NSString stringWithFormat:@"%@", [self.deposit objectForKey:@"created_at"]] ];
    self.depositUpdate.text = [self correctConvertOfDate:[NSString stringWithFormat:@"%@", [self.deposit objectForKey:@"updated_at"]] ];
    
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

- (NSString *) correctConvertOfDate:(NSString *) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *correctDate = [dateFormat dateFromString:date];
    [dateFormat setDateFormat:@"dd.MM.YYYY"];
    NSString *finalDate = [dateFormat stringFromDate:correctDate];
    return finalDate;
}


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
