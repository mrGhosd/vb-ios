//
//  LoanRepaymentsListViewController.m
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "LoanRepaymentsListViewController.h"

@interface LoanRepaymentsListViewController (){
    NSMutableArray *repaymentCell;
    NSMutableDictionary *repCell;
}

@end

@implementation LoanRepaymentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRepaymentCells];
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.loanRepayments.count;
}
-(void) initRepaymentCells{
    repaymentCell = [NSMutableArray new];
    for(NSDictionary *payment in self.loanRepayments){
        NSString *sum = [payment objectForKey:@"granted_summ"];
        NSString *createdAt = [payment objectForKey:@"created_at"];
        
        repCell = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   sum,@"sum",
                   createdAt, @"create",nil];
        [repaymentCell addObject:repCell];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"repaymentCell";
    NSDictionary *currentLoanCell = repaymentCell[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:
                             UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [currentLoanCell objectForKey:@"sum"] ];
    cell.detailTextLabel.text = [currentLoanCell objectForKey:@"create"];
    cell.imageView.frame = CGRectMake(8, 5, 40, 36);
    cell.imageView.image = [UIImage imageNamed:@"money_box-50.png"];
    return cell;

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
