//
//  LoanRepaymentsListViewController.m
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "LoanRepaymentsListViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "APIConnect.h"

@interface LoanRepaymentsListViewController (){
    APIConnect *api;
    NSString *userID;
    NSString *loanID;
    NSMutableArray *repaymentCell;
    UIRefreshControl *refreshControl;
    NSMutableDictionary *repCell;
}

@end

@implementation LoanRepaymentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    api = [[APIConnect alloc] init];
    userID = self.loanInfo[@"user_id"];
    loanID = self.loanInfo[@"id"];
    [self refreshInit];
    [self initRepaymentCells];
    // Do any additional setup after loading the view.
}

- (void) refreshInit{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.tableView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(getNewsData) forControlEvents:UIControlEventValueChanged];
}
- (void) getNewsData{
    [self.tableView reloadData];
    NSString *fullURL = [NSString stringWithFormat:@"/users/%@/loans/%@/repayments", userID, loanID];
    [api staticPagesInfo:fullURL withComplition:^(id data, BOOL success){
        if(success){
            [self parseRepaymentsData:data];
        } else {
        }
    }];
}
-(void) parseRepaymentsData:(id) data{
    repaymentCell = [NSMutableArray arrayWithArray:data];
    [self reloadData];
}
-(void)reloadData
{
    [self.tableView reloadData];
    
    if (refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Последнее обновление: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
        
        [refreshControl endRefreshing];
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([repaymentCell count] != nil){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
    } else {
        [MBProgressHUD showHUDAddedTo:self.view
                             animated:YES];
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.layer.frame.size.width, 500)];
        messageLabel.text = @"По данному займу не выполнялись выплаты.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return repaymentCell.count;
}
-(void) initRepaymentCells{
    repaymentCell = [NSMutableArray arrayWithArray:self.loanRepayments];
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [currentLoanCell objectForKey:@"granted_summ"] ];
    cell.detailTextLabel.text = [self correctConvertOfDate:[currentLoanCell objectForKey:@"created_at"]];
    cell.imageView.frame = CGRectMake(8, 5, 40, 36);
    cell.imageView.image = [UIImage imageNamed:@"money_box-50.png"];
    return cell;

}
- (NSString *) correctConvertOfDate:(NSString *) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *correctDate = [dateFormat dateFromString:date];
    [dateFormat setDateFormat:@"dd.MM.YYYY HH:mm:SS"];
    NSString *finalDate = [dateFormat stringFromDate:correctDate];
    return finalDate;
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
