//
//  NewsViewController.m
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController (){
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
    // Do any additional setup after loading the view.
}
- (void) apiConnect{
    [self.connection getData:@"/users/login" params:[NSString stringWithFormat:@"",_loginField.text, _passwordField.text]
                     success:^(id json){
                         
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

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
