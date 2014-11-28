//
//  RightPanelViewController.m
//  voenbank
//
//  Created by vsokoltsov on 15.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "RightPanelViewController.h"
#import "User.h"
#import "APIConnect.h"
#import "RightPanelTableViewCell.h"
#import <MBProgressHUD.h>

@interface RightPanelViewController (){
    UIRefreshControl *refreshControl;
    NSString *userID;
    User *user;
    APIConnect *api;
    NSInteger selectedIndex;
    int clickCount;
}

@end

@implementation RightPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    clickCount = 1;
    _menuItems = @[@"loanPart", @"depositPart"];
    selectedIndex = -1;
    user = [User sharedManager];
    userID = user.main[@"id"];
    api = [[APIConnect alloc] init];
    [self refreshInit];
    [self updateCellsRows];
    // Do any additional setup after loading the view.
}
- (void)updateCellsRows{
    RightPanelTableViewCell *topCell = (RightPanelTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [topCell setArrowDown:selectedIndex == 0];
    if(user.loans.count == 0){
        [topCell setViewForCell:YES];
    }
    
    RightPanelTableViewCell *buttomCell = (RightPanelTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [buttomCell setArrowDown:selectedIndex == 1];
    if(user.deposits.count == 0){
        [topCell setViewForCell: NO];
    }
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
    NSString *fullURL = [NSString stringWithFormat:@"/users/%@", userID];
    [api staticPagesInfo:fullURL withComplition:^(id data, BOOL success){
        if(success){
            [self parseLoansData:data];
        } else {
        }
    }];
}
-(void) parseLoansData:(id) data{
    [user parseUserInfo:data];
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
-(void) initUserLoanDepositData{
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    RightPanelTableViewCell *cell = [(RightPanelTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath] setUserInfo:user];
    cell.clipsToBounds =YES;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedIndex == indexPath.row){
        return 260;
    }
    else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RightPanelTableViewCell *cell = (RightPanelTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell setUserInfo:user];
    if(selectedIndex == indexPath.row){
        selectedIndex = -1;
//        cell.loanArrow.layer.transform = CATransform3DMakeRotation(M_PI*1,1.0,0.0,0.0);
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    
    if(selectedIndex != -1){
        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationFade];
//        cell.loanArrow.layer.transform = CATransform3DMakeRotation(M_PI*2
//                                                                   ,1.0,0.0,0.0);
    }
    
    selectedIndex = indexPath.row;
    

    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    selectedIndex =   indexPath.row;
    [self updateCellsRows];
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
