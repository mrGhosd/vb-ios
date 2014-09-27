//
//  RegViewController.m
//  voenbank
//
//  Created by vsokoltsov on 27.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "RegViewController.h"

@interface RegViewController ()

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _sliderRegAmount.minimumValue = 15000;
    _sliderRegAmount.maximumValue = 90000;
    
    [self.sliderRegAmount setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderRegAmount setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                   forState:UIControlStateNormal];
    [self.sliderRegAmount setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                   forState:UIControlStateNormal];
    [self.sliderRegTime setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderRegTime setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                 forState:UIControlStateNormal];
    [self.sliderRegTime setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                 forState:UIControlStateNormal];
    
    _sliderRegTime.minimumValue = 3;
    _sliderRegTime.maximumValue = 15;

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

- (IBAction)sliderAmountChange:(id)sender {
}
@end
