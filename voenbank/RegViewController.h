//
//  RegViewController.h
//  voenbank
//
//  Created by vsokoltsov on 27.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISlider *sliderRegAmount;

@property (strong, nonatomic) IBOutlet UISlider *sliderRegTime;
- (IBAction)sliderAmountChange:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *sliderTimeChange;

@end
