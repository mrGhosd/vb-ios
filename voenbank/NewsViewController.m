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

@interface NewsViewController ()
{
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *stock_title;
    NSString *date;
    NSString *image;
    NSString *text;
    UIRefreshControl *refreshControl;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshInit];
    [self apiConnect];
    [self initMainData];
    [self initDicitionaries];
}

-(void) initMainData{
    self.tableView.delegate = self;
    [self defBackButton];
    stock_title = @"stock_title";
    date = @"date";
    image = @"image_url";
    text = @"stock_text";
    myObject = [[NSMutableArray alloc] init];
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

-(void) initDicitionaries{
    id jsonObjects = [self.connection requestForStaticPages:@"/stocks"];
    
    for (NSDictionary *dataDict in jsonObjects) {
            NSString *stock_title_data = [dataDict objectForKey:@"stock_title"];
            NSString *time_data = [dataDict objectForKey:@"created_at"];
            NSString *image_data = [dataDict objectForKey:@"image_url"];
            NSString *stockText_data = [dataDict objectForKey:@"stock_text"];
    
            dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                          stock_title_data, stock_title,
                          image_data, image,
                          time_data,date,
                          stockText_data, text,
                          nil];
            [myObject addObject:dictionary];
        }
}
- (void) refreshInit{
//    UITableViewController *tableViewController = [[UITableViewController alloc] init];
//    tableViewController.tableView = self.tableView;
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
//    tableViewController.refreshControl = refreshControl;
//    
//    refreshControl = [[UIRefreshControl alloc] init];
//    refreshControl.backgroundColor = [UIColor purpleColor];
//    refreshControl.tintColor = [UIColor whiteColor];
//    [refreshControl addTarget:self
//                            action:@selector(getLatestLoans)
//                  forControlEvents:UIControlEventValueChanged];
    
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.tableView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(getNewsData) forControlEvents:UIControlEventValueChanged];
    
    
}
- (void) getNewsData{

}
-(void)reloadData
{
    [self.tableView reloadData];
    
    if (refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
    
    [refreshControl endRefreshing];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([myObject count] != nil){
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
    } else {
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
    // Return the number of rows in the section.
    return [myObject count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Item";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *text;
    //text = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:title]];
    text = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKeyedSubscript:stock_title]];
    
    NSMutableString *detail;
    detail = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:date]];
    NSMutableString *images;
    images = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:image]];
    NSString *fullURL = [[NSString alloc] initWithFormat:@"http://127.0.0.1:3000%@",[tmpDict objectForKey:image]];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    
    
    cell.textLabel.text = text;
    cell.detailTextLabel.text= detail;
    cell.imageView.frame = CGRectMake(0, 0, 80, 70);
    cell.imageView.image = img;
    
    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentCellData = myObject[indexPath.row];
    [self performSegueWithIdentifier:@"detail_view" sender:self];
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"detail_view"]){
        FullNewsInfoViewController *detailView = segue.destinationViewController;
        detailView.newsData = self.currentCellData;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)reloadData
//{
//    // Reload table data
//    [self.tableView reloadData];
//    
//    // End the refreshing
//    if (self.tableView.refreshControl) {
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"MMM d, h:mm a"];
//        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
//        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
//                                                                    forKey:NSForegroundColorAttributeName];
//        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
//        self.refreshControl.attributedTitle = attributedTitle;
//        
//        [self.refreshControl endRefreshing];
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
