//
//  RightPanelTableViewCell.m
//  voenbank
//
//  Created by vsokoltsov on 16.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "RightPanelTableViewCell.h"

@implementation RightPanelTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self initUser];
    clickCount = 1;
    if(user.loans.count != 0){
        [self initLoanCell];
    }
    if(user.deposits.count != 0){
        [self initDepositCell];
    }
    
}
-(void) logImageCellName: (RightPanelTableViewCell *) cell{
   }
- (void)setArrowDown:(BOOL)down{
    if(down) {
        self.loanArrow.image = [UIImage imageNamed:@"faq_arrow_up.png"];
    }
}

-(void) initUser{
    user = [[User sharedManager] parseUserData];
}
- (void) initLoanCell{
    NSDictionary *currentUserLoan = user.loans.lastObject;
    self.loanSumLabel.text = [NSString stringWithFormat:@"%@ р.", [currentUserLoan objectForKey:@"loan_sum"]];
    self.loanTimeLabel.text = [NSString stringWithFormat:@"%@ месяца(ев)", [currentUserLoan objectForKey:@"date_in_months"]];
    self.loanBeginDateLabel.text = [NSString stringWithFormat:@"%@",
                                    [currentUserLoan objectForKey:@"begin_date"]];;
    NSString *status = [currentUserLoan objectForKey:@"status"];
    if(status.boolValue == true){
        status = @"Оплачен";
    } else {
        status = @"В процессе выплаты";
    }
    self.loanStatusLabel.text = [NSString stringWithFormat:@"%@", status];
    self.loanEverymonthPayLabel.text = [currentUserLoan objectForKey:@"payed_sum"];
    self.loanDayInHistoryLabel.text = [NSString stringWithFormat:@"%@ день", [currentUserLoan objectForKey:@"current_day_in_loan_history"]];
    [self initLoanSlider:currentUserLoan];
}
-(void) initLoanSlider:(NSDictionary *) userLoanData{
    NSNumber *currentDayInLoanHistory = [userLoanData objectForKey:@"current_day_in_loan_history"];
    NSNumber *maximum = [userLoanData objectForKey:@"date_in_days"];
    self.sliderOfTime.minimumValue = 0;
    self.sliderOfTime.maximumValue = maximum.intValue;
    self.sliderOfTime.value = currentDayInLoanHistory.intValue;
    self.sliderOfTime.enabled = false;
    [self.sliderOfTime setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderOfTime setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                   forState:UIControlStateNormal];
    [self.sliderOfTime setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                   forState:UIControlStateNormal];

}
- (void) initDepositCell{
    NSDictionary *currentUserDeposit = user.deposits.lastObject;
    self.depositIdLabel.text = [NSString stringWithFormat:@"%@", [currentUserDeposit objectForKey:@"id"]];
    self.depositCurrentSumLabel.text = [NSString stringWithFormat:@"%@", [currentUserDeposit objectForKey:@"deposit_current_summ"]];
    NSString *response = [currentUserDeposit objectForKey:@"response"];
    if([response boolValue] == true){
        response = @"Одобрен";
    } else {
        response = @"Не просмотрен";
    }
    self.depositStatusLabel.text = response;
    self.depositCreatedAtLabel.text = [NSString stringWithFormat:@"%@", [currentUserDeposit objectForKey:@"created_at"]];
    
}
-(void) setViewForCell:(BOOL) type{
    if(type == true){
        self.emptyLoanView.hidden = NO;
    } else {
        self.emptyDepositView.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
