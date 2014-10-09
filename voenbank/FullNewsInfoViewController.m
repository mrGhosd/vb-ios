//
//  FullNewsInfoViewController.m
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "FullNewsInfoViewController.h"

@interface FullNewsInfoViewController ()

@end

@implementation FullNewsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNewsInfo];
    NSLog(@"News data is %@", self.newsData);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) initNewsInfo{
    [self initImageNews];
    _newsLabel.text = [_newsData objectForKey:@"stock_title"];
    [_newsText setEditable:NO];
    _newsText.backgroundColor = [UIColor clearColor];
    _newsText.text = [_newsData objectForKey:@"stock_text"];
}
-(void) initImageNews{
    NSString *fullURL = [[NSString alloc] initWithFormat:@"http://127.0.0.1:3000%@",[_newsData objectForKey:@"image_url"]];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    _newsImage.frame = CGRectMake(10, 70, 300, 150);
    _newsImage.image = img;

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
