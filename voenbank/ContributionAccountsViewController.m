//
//  ContributionAccountsViewController.m
//  voenbank
//
//  Created by vsokoltsov on 03.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "ContributionAccountsViewController.h"

@interface ContributionAccountsViewController ()
{
    NSMutableArray *accountCells;
    NSMutableDictionary *accountCellInfo;
}

@end

@implementation ContributionAccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAccountCell];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.depositAccounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    static NSString *identifier = @"accountCell";
    NSString *imageName;
    NSDictionary *currentAccountCell = accountCells[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:
                             UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSString *labelSum = [NSString stringWithFormat:@"%@ рублей", [currentAccountCell objectForKey:@"sum"] ];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [currentAccountCell objectForKey:@"time"] ];
    cell.imageView.frame = CGRectMake(8, 5, 40, 36);
    NSString *val = [currentAccountCell objectForKey:@"type"];
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
    accountCells = [NSMutableArray new];
    NSDictionary *cell;
    for(NSDictionary *payment in self.depositAccounts){
        NSNumber *sum = [payment objectForKey:@"operation_summ"];
        NSString *createdAt = [payment objectForKey:@"created_at"];
        NSString *removed_brought = [payment objectForKey:@"removed_brought"];

        cell = [NSDictionary dictionaryWithObjectsAndKeys:
                           sum, @"sum",
                           createdAt, @"time",
                           removed_brought, @"type", nil];
        [accountCells addObject:cell];
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
