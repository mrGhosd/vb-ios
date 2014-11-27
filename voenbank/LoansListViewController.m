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
#import "APIConnect.h"
#import <MBProgressHUD.h>

@interface LoansListViewController (){
    UIRefreshControl *refreshControl;
    NSString *userID;
    User *user;
    APIConnect *api;
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
    [self refreshInit];
    [self getListOfUserLoans];
    [self initLoansList];
    
    // Do any additional setup after loading the view.
}
- (void) initUser {
    user = [User sharedManager];
    api = [[APIConnect alloc] init];
}
- (void) getListOfUserLoans {
    userID = user.main[@"id"];
    self.tableView.delegate = self;
    loansList = [NSMutableArray arrayWithArray:user.loans];
    self.choosenLoan = [NSMutableDictionary new];
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
    NSString *fullURL = [NSString stringWithFormat:@"/users/%@/loans", userID];
    [api staticPagesInfo:fullURL withComplition:^(id data, BOOL success){
        if(success){
            [self parseLoansData:data];
        } else {
        }
    }];
}
-(void) parseLoansData:(id) data{
    loanCells = data;
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
    if([loanCells count] != nil){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
    } else {
        [MBProgressHUD showHUDAddedTo:self.view
                             animated:YES];
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.layer.frame.size.width, 500)];
        messageLabel.text = @"No data is currently available. Please pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return 0;
}
- (void) initLoansList {
    loanCells = [NSMutableArray arrayWithArray:loansList];
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@ р. / %@ м. ", [currentLoanCell objectForKey:@"sum"], [currentLoanCell objectForKey:@"date_in_months"]];
    cell.detailTextLabel.text = [self correctConvertOfDate:[currentLoanCell objectForKey:@"begin_date"]];
    cell.imageView.frame = CGRectMake(8, 5, 40, 36);
    cell.imageView.image = [UIImage imageNamed:@"banknotes-50.png"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    chLoan = [NSDictionary  dictionaryWithDictionary:loansList[indexPath.row]];
    [self performSegueWithIdentifier:@"detail_loan" sender:self];
}

- (NSString *) correctConvertOfDate:(NSString *) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *correctDate = [dateFormat dateFromString:date];
    [dateFormat setDateFormat:@"dd.MM.YYYY HH:mm:SS"];
    NSString *finalDate = [dateFormat stringFromDate:correctDate];
    return finalDate;
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
