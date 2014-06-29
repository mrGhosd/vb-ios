//
//  ViewController.h
//  voenbank
//
//  Created by vsokoltsov on 22.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//segmentControl
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)segment:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *loginView;
- (IBAction)sliderAmount:(id)sender;
- (IBAction)sliderTime:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *creditAmount;
@property (weak, nonatomic) IBOutlet UILabel *creditTime;
@property (weak, nonatomic) IBOutlet UISlider *sliderAmount;
@property (weak, nonatomic) IBOutlet UISlider *sliderTime;

@property (weak, nonatomic) IBOutlet UIView *creditView;
@property (weak, nonatomic) IBOutlet UIView *depositView;
@end
