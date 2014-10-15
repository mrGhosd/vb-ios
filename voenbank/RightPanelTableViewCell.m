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
    [self.sliderOfTime setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderOfTime setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                     forState:UIControlStateNormal];
    [self.sliderOfTime setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                     forState:UIControlStateNormal];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
