//
//  RightPanelViewController.h
//  voenbank
//
//  Created by vsokoltsov on 15.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightPanelViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *loanView;
@property (strong, nonatomic) IBOutlet UIView *depositView;
@property (strong, nonatomic) IBOutlet UIImageView *loanImageArrow;
@property (strong, nonatomic) IBOutlet UIImageView *depositImageArrow;
- (IBAction)showLoanView:(id)sender;
- (IBAction)showDepositView:(id)sender;

@end
