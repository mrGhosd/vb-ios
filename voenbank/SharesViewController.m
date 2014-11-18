//
//  SharesViewController.m
//  voenbank
//
//  Created by vsokoltsov on 09.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "SharesViewController.h"
#import "SWRevealViewController.h"
#import "SharesCell.h"
#import <DTCoreText.h>

@interface SharesViewController (){
    int selectedIndex;
    NSArray *sharesList;
    UIRefreshControl *refreshControl;
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *title;
    NSString *date;
    NSString *text;
}

@end

@implementation SharesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defBackButton];
    [self apiConnect];
    [self refreshInit];
    [self getSharesData];
    selectedIndex = -1;
//    [self initMainData];
//    [self initDicitionaries];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void) getSharesData{
    [self.tableView reloadData];
    [self.connection staticPagesInfo:@"/shares" withComplition:^(id data, BOOL success){
        if(success){
            [self parseSharesData:data];
        } else {
            [self reloadData];
        }
    }];
}
- (void) refreshInit{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.tableView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(getSharesData) forControlEvents:UIControlEventValueChanged];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([sharesList count] != nil){
        self.tableView.backgroundView = nil;
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

-(void) parseSharesData:(id) data{
    sharesList = [NSArray arrayWithArray:data];
    [self reloadData];
}

- (void) apiConnect{
    APIConnect *connection = [[APIConnect alloc] init];
    self.connection = connection;
}

-(void) initMainData{
    
    self.tableView.delegate = self;
    title = @"share_title";
    date = @"date";
    text = @"share_text";
    myObject = [[NSMutableArray alloc] init];
}

-(void) initDicitionaries{
    id jsonObjects = [self.connection requestForStaticPages:@"/shares"];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *share_title_data = [dataDict objectForKey:@"share_title"];
        NSString *time_data = [dataDict objectForKey:@"created_at"];
        NSString *share_text_data = [dataDict objectForKey:@"share_text"];
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      share_title_data, title,
                      time_data,date,
                      share_text_data, text,
                      nil];
        [myObject addObject:dictionary];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [sharesList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Item";
    
    SharesCell *cell = (SharesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"testCellView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if(selectedIndex == indexPath.row){
        
    }
    else{
        
    }
    
    NSDictionary *tmpDict = sharesList[indexPath.row];
    
    NSMutableString *label;
    //text = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:title]];
    label = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKeyedSubscript:title]];
    
    NSMutableString *detail;
    detail = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:date]];
    
//    NSMutableString *shareText = tmpDict[@"share_text"];
    NSData *textData = [tmpDict[@"share_text"] dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *text = [[NSAttributedString alloc] initWithHTMLData:textData documentAttributes:nil];
    cell.clipsToBounds =YES;
    cell.titleLabel.text = tmpDict[@"share_title"];
    cell.timeLabel.text = tmpDict[@"created_at"];
    cell.shareText.text = text.string;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedIndex == indexPath.row){
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        return;
    }
    
    if(selectedIndex != -1){
        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedIndex == indexPath.row){
        return 250;
    }
    else {
        return 44;
    }
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
