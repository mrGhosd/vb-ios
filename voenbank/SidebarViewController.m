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
    // Do any additional setup after loading the view.
//    NSUserDefaults *userName = [NSUserDefaults standardUserDefaults];
//    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
//    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
//    self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];
//    leftMenu = [NSArray arrayWithObjects: @"Новости", nil];
    _menuItems = @[@"my_page", @"news"];
}
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    if([[segue identifier] isEqualToString:@"news_page"]){
        NewsViewController *news = [segue destinationViewController];
    }
    if([[segue identifier] isEqualToString:@"my_page"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        MainViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        [self.navigationController pushViewController:viewController animated:YES];    }
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
