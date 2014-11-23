//
//  FullNewsInfoViewController.m
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "FullNewsInfoViewController.h"
#import <DTCoreText.h>
#import "APIConnect.h"

@interface FullNewsInfoViewController (){
    APIConnect *api;
    UIRefreshControl *refreshControl;
    NSString *newsID;
}

@end

@implementation FullNewsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    api = [[APIConnect alloc] init];
    [self refreshInit];
    [self initNewsInfo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) initNewsInfo{
    [self initImageNews];
    newsID = self.newsData[@"id"];
    _newsLabel.text = self.newsData[@"stock_title"];
    [_newsText setEditable:NO];
    _newsText.backgroundColor = [UIColor clearColor];

    
    NSData *textData = [[_newsData objectForKey:@"stock_text"] dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *text = [[NSAttributedString alloc] initWithHTMLData:textData documentAttributes:nil];
    self.newsText.text = text.string;
}
-(void) initImageNews{
    NSString *fullURL = [[NSString alloc] initWithFormat:@"http://127.0.0.1:3000%@",[_newsData objectForKey:@"image_url"]];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    self.newsImage.image = img;
    self.newsImage.clipsToBounds = YES;
    self.newsImage.layer.borderWidth = 3.0f;
    self.newsImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.newsImage.layer.cornerRadius = 10.0f;
}
- (void) refreshInit{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.scrollView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(updateNewsInfo) forControlEvents:UIControlEventValueChanged];
}

-(void)updateNewsInfo{
    NSString *url = [NSString stringWithFormat:@"/stocks/%@", newsID];
    [api staticPagesInfo:url withComplition:^(id data, BOOL result){
        if(result){
            [self parseNewsInfo:data];
        } else {
            
        }
    }];
}
- (void) parseNewsInfo:(id) data{
    self.newsData = (NSDictionary *)data;
    [self initNewsInfo];
    [refreshControl endRefreshing];
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
