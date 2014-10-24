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
    clickCount = 1;
    [self.sliderOfTime setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderOfTime setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                     forState:UIControlStateNormal];
    [self.sliderOfTime setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                     forState:UIControlStateNormal];

}
-(void) logImageCellName: (RightPanelTableViewCell *) cell{
//    NSLog(@"%@", [cell i]);
   }
- (void)setArrowDown:(BOOL)down{
    if(down) {
        self.loanArrow.image = [UIImage imageNamed:@"faq_arrow_up.png"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
