//
//  LoansListViewController.m
//  voenbank
//
//  Created by vsokoltsov on 02.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "LoansListViewController.h"
#import "SWRevealViewController.h"
#import "SidebarViewController.h"
#import "DetailLoanViewController.h"
#import "User.h"

@interface LoansListViewController (){
    User *user;
    NSMutableArray *loansList;
    NSMutableArray *loanCells;
    NSDictionary *chLoan;
}

@end

@implementation LoansListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defBackButton];
    [self initUser];
    [self getListOfUserLoans];
    [self initLoansList];
    
    // Do any additional setup after loading the view.
}
- (void) initUser {
    user = [[User sharedManager] parseUserData];
}
- (void) getListOfUserLoans {
    self.tableView.delegate = self;
    loansList = [NSMutableArray arrayWithArray:user.loans];
    self.choosenLoan = [NSMutableDictionary new];
    
}
- (void) initLoansList {
    loanCells = [[NSMutableArray alloc] init];
    NSMutableDictionary *loanCell;
    for(NSMutableDictionary *loanInfo in loansList){
        NSString *loanId = [loanInfo objectForKey:@"id"];
        NSString *loanSum = [loanInfo objectForKey:@"loan_sum"];
        NSString *loanTime = [loanInfo objectForKey:@"date_in_months"];
        NSString *loanCreatedAt = [loanInfo objectForKey:@"begin_date"];
        
        loanCell = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    loanId,@"id",
                    loanSum, @"loan_sum",
                    loanTime, @"loan_time",
                    loanCreatedAt, @"loan_created_at",
                    nil];
        [loanCells addObject:loanCell];
    }
}

- (void) defBackButton{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.backButton setTarget: self.revealViewController];
        [self.backButton setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return user.loans.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"loanCell";
    NSDictionary *currentLoanCell = loanCells[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:
                             UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ р. / %@ м. ", [currentLoanCell objectForKey:@"loan_sum"], [currentLoanCell objectForKey:@"loan_time"]];
    cell.detailTextLabel.text = [currentLoanCell objectForKey:@"loan_created_at"];
    cell.imageView.frame = CGRectMake(8, 5, 40, 36);
    cell.imageView.image = [UIImage imageNamed:@"banknotes-50.png"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    chLoan = [NSDictionary  dictionaryWithDictionary:loansList[indexPath.row]];
    [self performSegueWithIdentifier:@"detail_loan" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"detail_loan"]){
        DetailLoanViewController *loan = segue.destinationViewController;
        loan.loanInfo = chLoan;
    }
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
