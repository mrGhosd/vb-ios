//
//  ContributionAccountsViewController.m
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "ContributionAccountsViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "APIConnect.h"

@interface ContributionAccountsViewController ()
{
    NSMutableArray *accountCells;
    NSMutableDictionary *accountCellInfo;
    UIRefreshControl *refreshControl;
    APIConnect *api;
    NSString *userID;
    NSString *depositID;
}

@end

@implementation ContributionAccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    api = [[APIConnect alloc] init];
    [self refreshInit];
    [self initAccountCell];
    // Do any additional setup after loading the view.
}
- (void) refreshInit{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.tableView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(getAccountsData) forControlEvents:UIControlEventValueChanged];
}
- (void) getAccountsData{
    [self.tableView reloadData];
    NSString *fullURL = [NSString stringWithFormat:@"/users/%@/deposits/%@/accounts", userID, depositID];
    [api staticPagesInfo:fullURL withComplition:^(id data, BOOL success){
        if(success){
            [self parseRepaymentsData:data];
        } else {
        }
    }];
}
-(void) parseRepaymentsData:(id) data{
    accountCells = [NSMutableArray arrayWithArray:data];
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
    if([accountCells count] != nil){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
    } else {
        [MBProgressHUD showHUDAddedTo:self.view
                             animated:YES];
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.layer.frame.size.width, 500)];
        messageLabel.text = @"По данному вкладу не выполнялись операции.";
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.depositAccounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    static NSString *identifier = @"accountCell";
    NSString *imageName;
    NSDictionary *currentAccountCell = (NSDictionary *)accountCells[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:
                             UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSString *labelSum = [NSString stringWithFormat:@"%@ рублей", currentAccountCell[@"operation_summ"]];
    cell.detailTextLabel.text = [self correctConvertOfDate:[NSString stringWithFormat:@"%@", currentAccountCell[@"created_at"] ] ];
    cell.imageView.frame = CGRectMake(8, 5, 40, 36);
    NSString *val = [currentAccountCell objectForKey:@"removed_brought"];
    NSString *operationType;
    if(val.boolValue == true){
        operationType = @"Вложили";
        imageName = @"card_in_use-50.png";
    } else {
        operationType = @"Сняли";
        imageName = @"money_box-50.png";
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", operationType, labelSum];
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
}


-(void) initAccountCell{
    userID = self.deposit[@"user_id"];
    depositID = self.deposit[@"id"];
    accountCells = [NSMutableArray arrayWithArray:self.depositAccounts];
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
