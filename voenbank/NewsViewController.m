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
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
//    NSLog(@"IMAGE URL: %@", url)e;
    
    
    cell.textLabel.text = text;
    cell.detailTextLabel.text= detail;
    cell.imageView.frame = CGRectMake(0, 0, 80, 70);
    cell.imageView.image = img;
    
    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"full data of news is %@", myObject[indexPath.row]);
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
