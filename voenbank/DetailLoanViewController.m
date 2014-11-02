//
//  DetailLoanViewController.m
//  voenbank
//
//  Created by vsokoltsov on 02.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "DetailLoanViewController.h"

@interface DetailLoanViewController ()

@end

@implementation DetailLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLoanData];
    // Do any additional setup after loading the view.
}
- (void) initLoanData{
    NSString *title = [NSString stringWithFormat:@"Займ №%@", [self.loanInfo objectForKey:@"id"]];
    self.loanTitle.text = title;
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
