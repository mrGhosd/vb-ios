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

@interface SharesViewController (){
    int selectedIndex;
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
    [self initMainData];
    [self initDicitionaries];
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

- (void) apiConnect{
    APIConnect *connection = [[APIConnect alloc] init];
    self.connection = connection;
}

-(void) initMainData{
    selectedIndex = -1;
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
    return [myObject count];
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
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *label;
    //text = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:title]];
    label = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKeyedSubscript:title]];
    
    NSMutableString *detail;
    detail = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:date]];
    
    NSMutableString *shareText = [NSMutableString stringWithFormat:[ tmpDict objectForKey:text]];
    cell.clipsToBounds =YES;
    cell.titleLabel.text = label;
    cell.timeLabel.text = detail;
    cell.shareText.text = shareText;
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
        return 150;
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
