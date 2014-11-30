//
//  PartnersViewController.m
//  voenbank
//
//  Created by vsokoltsov on 31.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "PartnersViewController.h"
#import "SWRevealViewController.h"
#import "SidebarViewController.h"
#import "DetailPartnerViewController.h"
#import "APIConnect.h"

@interface PartnersViewController (){
    UIRefreshControl *refreshControl;
    NSArray *partnersList;
    NSMutableDictionary *partnerInfo;
    NSMutableArray *partnerCells;
}

@end

@implementation PartnersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.alwaysBounceVertical = YES;
    [self setBackground];
    [self backButtonDefinition];
    [self apiConnect];
    [self refreshInit];
    [self getPartnersData];
    // Do any additional setup after loading the view.
}

-(void) backButtonDefinition{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.backButton setTarget: self.revealViewController];
        [self.backButton setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
    }
}

-(void) setBackground{
    self.collectionView.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"vb_pattrn_0061.jpg"]];
}

- (void) apiConnect{
    APIConnect *connection = [[APIConnect alloc] init];
    self.connection = connection;
}
- (void) refreshInit{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.collectionView addSubview:refreshView]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor grayColor];
    [refreshView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(getPartnersData) forControlEvents:UIControlEventValueChanged];
}
- (void) getPartnersData{
    [self.collectionView reloadData];
    [self.connection staticPagesInfo:@"/partners" withComplition:^(id data, BOOL success){
        if(success){
            [self parsePartnersData:data];
        } else {
            [self reloadData];
        }
    }];
}
-(void) parsePartnersData:(id) data{
    partnersList = [NSArray arrayWithArray:data];
    [self reloadData];
}
-(void)reloadData
{
    [self.collectionView reloadData];
    
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
    [self.collectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return partnersList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"partnerCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    UIImageView *partnerView = (UIImageView *)[cell viewWithTag:5];
    
    NSDictionary *currentCell = partnersList[indexPath.row];

    UIImage *img = [self.connection loadImageHelper:currentCell[@"image_url"]];
    partnerView.image = img;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    int index = 
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DetailPartnerViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailPartnerViewController"];
//    viewController.detailPartner = [[NSDictionary alloc] init];
    viewController.detailPartner = partnersList[(int)[indexPath row]];
    [self.navigationController pushViewController:viewController animated:YES];
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
