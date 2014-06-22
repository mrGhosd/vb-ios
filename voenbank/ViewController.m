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
@end
