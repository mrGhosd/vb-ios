//
//  DetailPartnerViewController.m
//  voenbank
//
//  Created by vsokoltsov on 31.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "DetailPartnerViewController.h"
#import "APIConnect.h"
#import <DTCoreText.h>

@interface DetailPartnerViewController (){
    APIConnect *api;
    UIRefreshControl *refreshControl;
    NSString *partnerID;
}

@end

@implementation DetailPartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    api = [[APIConnect alloc] init];
    [self initPartnerPage];
    [self refreshInit];
    // Do any additional setup after loading the view.
}

//- (void) setPartnerData{
//    partner = self.detailPartner;
//}
- (void) setViewTitle{
    self.navigationItem.title = [NSString stringWithFormat:@"Наш партнер - %@", self.detailPartner[@"partner_title"]];
}

-(void)updatePartnerInfo{
    NSString *url = [NSString stringWithFormat:@"/partners/%@", partnerID];
    [api staticPagesInfo:url withComplition:^(id data, BOOL result){
        if(result){
            [self parsePartnerInfo:data];
        } else {
            
        }
    }];
}

- (void) refreshInit{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.scrollView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(updatePartnerInfo) forControlEvents:UIControlEventValueChanged];

}
- (void) parsePartnerInfo:(id) data{
    self.detailPartner = (NSDictionary *)data;
    [self initPartnerPage];
    [refreshControl endRefreshing];
}

- (void) initPartnerPage {
    [self setViewTitle];
    partnerID = self.detailPartner[@"id"];
    self.partnerTitle.text = [NSString stringWithFormat:@"%@", self.detailPartner[@"partner_title"]];
    self.partnerURL.text = [NSString stringWithFormat:@"%@", self.detailPartner[@"partner_url"]];
    [self initTextView];
    [self initImage];
}

- (void) initImage {
    UIImage *img = [api loadImageHelper:self.detailPartner[@"image_url"]];
    self.partnerImage.image = img;
}

- (void) initTextView{
    NSData *textData = [self.detailPartner[@"partner_description"] dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *text = [[NSAttributedString alloc] initWithHTMLData:textData documentAttributes:nil];
    [self.partnerDescription setEditable:NO];
    self.partnerDescription.backgroundColor = [UIColor clearColor];
    self.partnerDescription.text = text.string;
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
