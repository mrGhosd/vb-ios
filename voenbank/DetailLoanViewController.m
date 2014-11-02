//
//  DetailLoanViewController.m
//  voenbank
//
//  Created by vsokoltsov on 02.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "DetailLoanViewController.h"
#import "LoanRepaymentsListViewController.h"
@interface DetailLoanViewController (){
    NSMutableArray *loanrepayments;
}

@end

@implementation DetailLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLoanData];
    // Do any additional setup after loading the view.
}
- (void) initLoanData{
    NSString *title = [NSString stringWithFormat:@"Займ №%@", [self.loanInfo objectForKey:@"id"]];
    self.loanTitle.text = title;
    self.loanSum.text = [NSString stringWithFormat:@"%@ рублей", [self.loanInfo objectForKey:@"loan_sum"]];
    self.loanTime.text = [NSString stringWithFormat:@"%@ месяца(ев)", [self.loanInfo objectForKey:@"date_in_months"]];
    self.loanPayedSum.text = [self.loanInfo objectForKey:@"payed_sum"];
    self.loanBeginDate.text = [self.loanInfo objectForKey:@"begin_date"];
    self.loanEndDate.text = [self.loanInfo objectForKey:@"end_date"];
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
