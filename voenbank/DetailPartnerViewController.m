//
//  DetailPartnerViewController.m
//  voenbank
//
//  Created by vsokoltsov on 31.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "DetailPartnerViewController.h"

@interface DetailPartnerViewController (){
    NSDictionary *partner;
}

@end

@implementation DetailPartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPartnerData];
    [self initPartnerPage];
    // Do any additional setup after loading the view.
}

- (void) setPartnerData{
    partner = self.detailPartner;
}
- (void) setViewTitle{
    self.navigationItem.title = [NSString stringWithFormat:@"Наш партнер - %@", [partner objectForKey:@"title"]];
}
- (void) initPartnerPage {
    [self setViewTitle];
    self.partnerTitle.text = [NSString stringWithFormat:@"%@", [partner objectForKey:@"title"]];
    self.partnerURL.text = [NSString stringWithFormat:@"%@", [partner objectForKey:@"url"]];
    [self initTextView];
    [self initImage];
}

- (void) initImage {
    NSString *fullURL = [[NSString alloc] initWithFormat:@"http://127.0.0.1:3000%@",[partner objectForKey:@"image_url"]];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    self.partnerImage.image = img;
}

- (void) initTextView{
    self.partnerDescription.text = [NSString stringWithFormat:@"%@", [partner objectForKey:@"description"]];
    [self.partnerDescription setEditable:NO];
    self.partnerDescription.backgroundColor = [UIColor clearColor];
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
