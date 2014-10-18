//
//  RightPanelViewController.m
//  voenbank
//
//  Created by vsokoltsov on 15.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "RightPanelViewController.h"
#import "User.h"
#import "RightPanelTableViewCell.h"

@interface RightPanelViewController (){
    int selectedIndex;
    int clickCount;
}

@end

@implementation RightPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    clickCount = 1;
    _menuItems = @[@"loanPart", @"depositPart"];
    selectedIndex = -1;
    [self initUserLoanDepositData];
    // Do any additional setup after loading the view.
}

-(void) initUserLoanDepositData{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    RightPanelTableViewCell *cell = (RightPanelTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.clipsToBounds =YES;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedIndex == indexPath.row){
        return 260;
    }
    else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RightPanelTableViewCell *cell = (RightPanelTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//    if(clickCount == 1){
//        
//        clickCount = 0;
//    } else if(clickCount == 0) {
//        
//        clickCount = 1;
//    }

//    NSLog(@"cell is %@", cell);
    if(selectedIndex == indexPath.row){
        selectedIndex = -1;
        cell.loanArrow.layer.transform = CATransform3DMakeRotation(M_PI*1,1.0,0.0,0.0);
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    
    if(selectedIndex != -1){
        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationFade];
        cell.loanArrow.layer.transform = CATransform3DMakeRotation(M_PI*2
                                                                   ,1.0,0.0,0.0);
    }
    
    selectedIndex = indexPath.row;
    

    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    cell.loanArrow.layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 0);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)showLoanView:(id)sender {
////    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self.view layoutIfNeeded];
//
//    [UIView animateWithDuration:0.5 animations:^{
//        int size;
//        int animationCount;
//        if(clickCount == 1) {
//            size = -200.0;
//            clickCount = 0 ;
//            animationCount = 1;
//        } else if(clickCount == 0)
//        {
//            size = 200.0;
//            clickCount = 1;
//            animationCount = 2;
//        }
//
//        [self animateLoanDepositWindows:size animation:animationCount window:self.loanView image:self.loanImageArrow];
//        [self.view layoutIfNeeded];
//    }];
//}
//
//- (IBAction)showDepositView:(id)sender {
//    [self.view layoutIfNeeded];
////    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [UIView animateWithDuration:0.5 animations:^{
//        int size;
//        int animationCount;
//        if(clickCount == 0) {
//            size = -200.0;
//            clickCount = 1 ;
//            animationCount = 1;
//        } else if(clickCount == 1)
//        {
//            size = 200.0;
//            clickCount = 0;
//            animationCount = 2;
//        }
//        
//        [self animateLoanDepositWindows:size animation:animationCount window:self.depositView image:self.depositImageArrow ];
//        [self.view layoutIfNeeded];
//    }];
//
//}
//-(void) animateLoanDepositWindows: (int) size animation: (int) count window: (UIView *) view image: (UIImageView *) image{
//    image.layer.transform = CATransform3DMakeRotation(M_PI*count,1.0,0.0,0.0);
//    view.frame = CGRectMake(view.frame.origin.x , view.frame.origin.y, view.frame.size.width, view.frame.size.height + size);
//}
@end
