//
//  RightPanelTableViewCell.h
//  voenbank
//
//  Created by vsokoltsov on 16.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface RightPanelTableViewCell : UITableViewCell{
    int clickCount;
    User *user;
}
@property (strong, nonatomic) IBOutlet UISlider *sliderOfTime;
@property (strong, nonatomic) IBOutlet UIView *loanView;
@property (strong, nonatomic) IBOutlet UIImageView *loanArrow;
@property (strong, nonatomic) IBOutlet UIView *depositView;
@property (strong, nonatomic) IBOutlet UIImageView *depositArrow;
-(void) logImageCellName: (RightPanelTableViewCell *) cell;
@property (strong, nonatomic) IBOutlet UIView *emptyLoanView;
@property (strong, nonatomic) IBOutlet UIView *emptyDepositView;

@property (strong, nonatomic) IBOutlet UILabel *loanSumLabel;
@property (strong, nonatomic) IBOutlet UILabel *loanTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *loanBeginDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *loanStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *loanEverymonthPayLabel;
@property (strong, nonatomic) IBOutlet UILabel *loanDayInHistoryLabel;


@property (strong, nonatomic) IBOutlet UILabel *depositIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *depositCurrentSumLabel;
@property (strong, nonatomic) IBOutlet UILabel *depositStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *depositCreatedAtLabel;

- (void)setArrowDown:(BOOL)down;
-(void) setViewForCell:(BOOL) type;
@end
