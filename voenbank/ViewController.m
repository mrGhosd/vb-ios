//
//  ViewController.m
//  voenbank
//
//  Created by vsokoltsov on 22.06.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_creditView setHidden:YES];
    [_depositView setHidden:YES];
    _sliderAmount.minimumValue = 15000;
    _sliderAmount.maximumValue = 90000;
    [self.sliderAmount setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderAmount setMinimumTrackImage:[UIImage imageNamed:@"sliderFilledArea.png"]
                               forState:UIControlStateNormal];
    [self.sliderAmount setMaximumTrackImage:[UIImage imageNamed:@"sliderUnfilledArea.png"]
                                   forState:UIControlStateNormal];
    [self.sliderTime setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderTime setMinimumTrackImage:[UIImage imageNamed:@"sliderFilledArea.png"]
                                   forState:UIControlStateNormal];
    [self.sliderTime setMaximumTrackImage:[UIImage imageNamed:@"sliderUnfilledArea.png"]
                                   forState:UIControlStateNormal];

    
    
    _sliderTime.minimumValue = 3;
    _sliderTime.maximumValue = 15;
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)segment:(id)sender {
    switch (self.segmentControl.selectedSegmentIndex)
    {
        case 0:
            [_creditView setHidden:YES];
            [_depositView setHidden:YES];
            break;
        case 1:
            [_creditView setHidden:NO];
            [_depositView setHidden:YES];
            break;
        case 2:
            [_creditView setHidden:NO];
            [_depositView setHidden:NO];
        default: 
            break; 
    }
}
- (IBAction)sliderAmount:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    int val = slider.value;
    
    if (val >= 30000)
    {
        _sliderTime.value = 6;
    }
    if (val >= 45000)
    {
        _sliderTime.value = 9;
    }
    if (val >= 72000)
    {
        _sliderTime.value = 12;
    }
    
    self.creditAmount.text = [NSString stringWithFormat:@"%i р.", val];
    
    
}

- (IBAction)sliderTime:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    int val = slider.value;
    
    self.creditTime.text = [NSString stringWithFormat:@"%i м.", val];

}
@end
