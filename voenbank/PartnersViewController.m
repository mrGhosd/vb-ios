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

@interface PartnersViewController (){
    NSMutableArray *partnersList;
    NSMutableDictionary *partnerInfo;
    NSMutableArray *partnerCells;
}

@end

@implementation PartnersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imageName.pnd"]];
    self.collectionView.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"vb_pattrn_0061.jpg"]];
    [self backButtonDefinition];
    [self apiConnect];
    [self initPartnersData];
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

- (void) apiConnect{
    APIConnect *connection = [[APIConnect alloc] init];
    self.connection = connection;
}
- (void) initPartnersData{
    partnerCells = [[NSMutableArray alloc] init];
    partnerInfo = [NSMutableDictionary new];
    id jsonObjects = [self.connection requestForStaticPages:@"/partners"];
    NSString *keyTitle= @"title";
    NSString *keyDescription = @"description";
    NSString *keyURL = @"url";
    NSString *keyImageURL = @"image_url";
    
    for(NSDictionary *dict in jsonObjects){
        NSString *title = [dict objectForKey:@"partner_title"];
        NSString *description = [dict objectForKey:@"partner_description"];
        NSString *linkURL = [dict objectForKey:@"partner_url"];
        NSString *imageURL = [dict objectForKey:@"image_url"];
        
        partnerInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       title, keyTitle,
                       description, keyDescription,
                       linkURL, keyURL,
                       imageURL, keyImageURL,
                       nil];
        
        [partnerCells addObject:partnerInfo];
    }
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return partnerCells.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"partnerCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    UIImageView *partnerView = (UIImageView *)[cell viewWithTag:5];
    
    NSDictionary *currentCell = [partnerCells objectAtIndex:indexPath.row];
    
    NSString *fullURL = [[NSString alloc] initWithFormat:@"http://127.0.0.1:3000%@",[currentCell objectForKey:@"image_url"]];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    partnerView.image = img;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DetailPartnerViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailPartnerViewController"];
    viewController.detailPartner = partnerCells[indexPath.row];
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
