//
//  DetailLoanViewController.m
//  voenbank
//
//  Created by vsokoltsov on 02.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "DetailLoanViewController.h"
#import "LoanRepaymentsListViewController.h"
#import "APIConnect.h"

@interface DetailLoanViewController (){
    NSMutableArray *loanrepayments;
    APIConnect *api;
    UIRefreshControl *refreshControl;
    NSString *userID;
    NSString *loanID;
}

@end

@implementation DetailLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    api = [[APIConnect alloc] init];
    [self refreshInit];
    [self initLoanData];
    // Do any additional setup after loading the view.
}
- (void) refreshInit{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.scrollView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(updateLoanInfo) forControlEvents:UIControlEventValueChanged];
    
}
- (void) initLoanData{
    userID = self.loanInfo[@"user_id"];
    loanID = self.loanInfo[@"id"];
    NSString *title = [NSString stringWithFormat:@"Займ №%@", [self.loanInfo objectForKey:@"id"]];
    self.loanTitle.text = title;
    self.loanSum.text = [NSString stringWithFormat:@"%@ рублей", [self.loanInfo objectForKey:@"sum"]];
    self.loanTime.text = [NSString stringWithFormat:@"%@ месяца(ев)", [self.loanInfo objectForKey:@"date_in_months"]];
    self.loanPayedSum.text = [self.loanInfo objectForKey:@"payed_sum"];
    self.loanBeginDate.text = [self correctConvertOfDate:[self.loanInfo objectForKey:@"begin_date"] ];
    self.loanEndDate.text = [self correctConvertOfDate:[self.loanInfo objectForKey:@"end_date"]];
    self.loanStatus.text = [self getLoanStatus];
    self.loanResponse.text = [self getLoanResponse];
    self.loanCurrentDay.text = [NSString stringWithFormat:@"%@ день", [self.loanInfo objectForKey:@"current_day_in_loan_history"]];
}

-(NSString *) getLoanStatus{
    NSString *status;
    NSString *value = [self.loanInfo objectForKey:@"status"];
    if(value.boolValue){
        status = @"Оплачен";
    } else {
        status = @"В процессе оплаты";
    }
    return status;
}
-(void)updateLoanInfo{
    NSString *url = [NSString stringWithFormat:@"/users/%@/loans/%@", userID, loanID];
    [api staticPagesInfo:url withComplition:^(id data, BOOL result){
        if(result){
            [self parseLoanInfo:data];
        } else {
            
        }
    }];
}
- (void) parseLoanInfo:(id) data{
    self.loanInfo = (NSMutableDictionary *)data;
    [self initLoanData];
    [refreshControl endRefreshing];
}

-(NSString *) getLoanResponse{
    NSString *response;
    NSString *value = [self.loanInfo objectForKey:@"response"];
    if(value.boolValue) {
        response = @"Подтвержден";
    } else {
        response = @"Не подтвержден";
    }
    return response;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *) correctConvertOfDate:(NSString *) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *correctDate = [dateFormat dateFromString:date];
    [dateFormat setDateFormat:@"dd.MM.YYYY"];
    NSString *finalDate = [dateFormat stringFromDate:correctDate];
    return finalDate;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)toLoanRepayment:(id)sender {
    loanrepayments = [NSMutableArray arrayWithArray:[self.loanInfo objectForKey:@"repayments"]];
    [self performSegueWithIdentifier:@"loan_repayments" sender:self];
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"loan_repayments"]) {
        LoanRepaymentsListViewController *repayment = segue.destinationViewController;
        repayment.loanRepayments = [NSArray arrayWithArray:loanrepayments];
    }
}
@end
