//
//  DepositsListViewController.m
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "DepositsListViewController.h"
#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "APIConnect.h"
#import "User.h"
#import "DetailDepositViewController.h"
#import <MBProgressHUD.h>

@interface DepositsListViewController (){
    UIRefreshControl *refreshControl;
    NSString *userID;
    APIConnect *api;
    User *user;
    NSMutableArray *depositCells;
    NSMutableDictionary *depositCellInfo;
    NSDictionary *detail;
}

@end

@implementation DepositsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defBackButton];
    [self initUser];
    [self refreshInit];
    [self initArrays];
    [self initDepositsData];
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
    NSString *fullURL = [NSString stringWithFormat:@"/users/%@/deposits", userID];
    [api staticPagesInfo:fullURL withComplition:^(id data, BOOL success){
        if(success){
            [self parseDepositsData:data];
        } else {
        }
    }];
}
-(void) parseDepositsData:(id) data{
    depositCells = [NSMutableArray arrayWithArray:data ];
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
    if([depositCells count] != nil){
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

- (void) defBackButton{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.backButton setTarget: self.revealViewController];
        [self.backButton setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}
- (void) initUser {
    user = [User sharedManager];
    api = [[APIConnect alloc] init];
    userID = user.main[@"id"];
}
- (void) initArrays {
    depositCellInfo = [[NSMutableDictionary alloc] init];
}
- (void) initDepositsData {
    depositCells = [NSMutableArray arrayWithArray:user.deposits];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return user.deposits.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"depositCell";
    NSDictionary *currentDepositCell = depositCells[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:
                             UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ рублей", [currentDepositCell objectForKey:@"current_amount"]];
    cell.detailTextLabel.text = [self correctConvertOfDate:[currentDepositCell objectForKey:@"created_at"]];
    cell.imageView.frame = CGRectMake(8, 5, 40, 36);
    cell.imageView.image = [UIImage imageNamed:@"money_bag-50.png"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    detail = [NSDictionary  dictionaryWithDictionary:user.deposits[indexPath.row]];
    [self performSegueWithIdentifier:@"detail_deposit" sender:self];
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"detail_deposit"]) {
        DetailDepositViewController *view = segue.destinationViewController;
        view.deposit = detail;
    }
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
