//
//  FullNewsInfoViewController.m
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "FullNewsInfoViewController.h"
#import <DTCoreText.h>
@interface FullNewsInfoViewController ()

@end

@implementation FullNewsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNewsInfo];
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

    
    NSData *textData = [[_newsData objectForKey:@"stock_text"] dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *text = [[NSAttributedString alloc] initWithHTMLData:textData documentAttributes:nil];
//    NSAttributedString *string = [[NSAttributedString alloc] string [_newsData objectForKey:@"stock_text"]];
//    [self.view addSubview:layoutFrame];
    
    self.newsText.text = text.string;
//                                    @"This is a test.\n Will I pass?" attributes:
//                                    @{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font}];
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
