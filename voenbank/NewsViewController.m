//
//  NewsViewController.m
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "NewsViewController.h"
#import "SWRevealViewController.h"
#import "FullNewsInfoViewController.h"
#import "APIConnect.h"
#import <MBProgressHUD.h>

@interface NewsViewController ()
{
    UIRefreshControl *refreshControl;
    NSArray *newsList;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defBackButton];
    [self refreshInit];
    [self apiConnect];
    [self getNewsData];
}

-(void) initMainData{
    self.tableView.delegate = self;
    [self defBackButton];
}

- (void) apiConnect{
    APIConnect *connection = [[APIConnect alloc] init];
    self.connection = connection;
   
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
    [self.connection staticPagesInfo:@"/stocks" withComplition:^(id data, BOOL success){
        if(success){
            [self parseNewsData:data];
        } else {
            }
    }];
}
-(void) parseNewsData:(id) data{
        newsList = [NSArray arrayWithArray:data];
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
    if([newsList count] != nil){
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Item";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSDictionary *tmpDict = newsList[indexPath.row];
    
    NSMutableString *images = tmpDict[@"image_url"];
    NSString *fullURL = [[NSString alloc] initWithFormat:@"http://127.0.0.1:3000%@",tmpDict[@"image_url"]];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    
    
    cell.textLabel.text = tmpDict[@"stock_title"];
    cell.detailTextLabel.text= [self correctConvertOfDate:tmpDict[@"created_at"] ];
    cell.imageView.frame = CGRectMake(0, 0, 80, 70);
    cell.imageView.image = img;
    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentCellData = newsList[indexPath.row];
    [self performSegueWithIdentifier:@"detail_view" sender:self];
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"detail_view"]){
        FullNewsInfoViewController *detailView = segue.destinationViewController;
        detailView.newsData = self.currentCellData;
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
#pragma mark - Navigation

@end
