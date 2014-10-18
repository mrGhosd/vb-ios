//
//  RightPanelTableViewCell.h
//  voenbank
//
//  Created by vsokoltsov on 16.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightPanelTableViewCell : UITableViewCell{
    int clickCount;
}
@property (strong, nonatomic) IBOutlet UISlider *sliderOfTime;
@property (strong, nonatomic) IBOutlet UIView *loanView;
@property (strong, nonatomic) IBOutlet UIImageView *loanArrow;
@property (strong, nonatomic) IBOutlet UIView *depositView;
@property (strong, nonatomic) IBOutlet UIImageView *depositArrow;
-(void) logImageCellName: (RightPanelTableViewCell *) cell;
@end
