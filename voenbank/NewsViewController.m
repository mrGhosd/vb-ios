//
//  NewsViewController.m
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()
{
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *stock_title;
    NSString *date;
    NSString *image;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    stock_title = @"stock_title";
    date = @"date";
    image = @"image_url";
    myObject = [[NSMutableArray alloc] init];
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:@"http://localhost:3000/api/stocks"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *stock_title_data = [dataDict objectForKey:@"stock_title"];
        NSString *time_data = [dataDict objectForKey:@"created_at"];
        NSString *image_data = [dataDict objectForKey:@"image_url"];
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      stock_title_data, stock_title,
                      image_data, image,
                      time_data,date,
                      nil];
        [myObject addObject:dictionary];
    }

    // Do any additional setup after loading the view.
}
- (void) apiConnect{
    APIConnect *connection = [[APIConnect alloc] init];
    self.connection = connection;
   
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
    
    //    NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:image]];
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    UIImage *img = [[UIImage alloc]initWithData:data];
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
