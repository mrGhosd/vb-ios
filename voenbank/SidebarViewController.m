//
//  SidebarViewController.m
//  voenbank
//
//  Created by vsokoltsov on 26.07.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "SidebarViewController.h"
#import "NewsViewController.h"
#import "MainViewController.h"
#import "SharesViewController.h"
#import "PartnersViewController.h"
#import "LoansListViewController.h"
#import "User.h"

@interface SidebarViewController ()
{
    NSArray *leftMenu;
}

@end

@implementation SidebarViewController

@synthesize userInformation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _menuItems = @[@"my_page", @"loans", @"news", @"shares", @"partners"];
}
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    if([[segue identifier] isEqualToString:@"news_page"]){
        NewsViewController *news = [segue destinationViewController];
    }
    if([[segue identifier] isEqualToString:@"my_page"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        MainViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if([[segue identifier] isEqualToString:@"shares_page"]){
        SharesViewController *share = [segue destinationViewController];
    }
    
    if([[segue identifier] isEqualToString:@"partners_page"]){
        PartnersViewController *partner = [segue destinationViewController];
    }
    if([[segue identifier] isEqualToString:@"loans_list"]){
        LoansListViewController *list = [segue destinationViewController];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
