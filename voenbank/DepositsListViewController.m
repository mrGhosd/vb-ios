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
#import "User.h"
#import "DetailDepositViewController.h"

@interface DepositsListViewController (){
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
    [self initArrays];
    [self initDepositsData];
    // Do any additional setup after loading the view.
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
}
- (void) initArrays {
    depositCells = [[NSMutableArray alloc] init];
    depositCellInfo = [[NSMutableDictionary alloc] init];
}
- (void) initDepositsData {
    NSMutableDictionary *depositCell;
    for(NSMutableDictionary *dict in user.deposits){
        NSString *current_summ = [dict objectForKey:@"deposit_current_summ"];
        NSString *createdAt = [dict objectForKey:@"created_at"];
        
        depositCell = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       current_summ, @"sum",
                       createdAt, @"time", nil];
        [depositCells addObject:depositCell];
    }
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ рублей", [currentDepositCell objectForKey:@"sum"]];
    cell.detailTextLabel.text = [currentDepositCell objectForKey:@"time"];
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
