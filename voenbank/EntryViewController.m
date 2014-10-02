//
//  EntryViewController.m
//  voenbank
//
//  Created by vsokoltsov on 27.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController ()

@end

@implementation EntryViewController

- (void)viewDidLoad {
    APIConnect *connection = [[APIConnect alloc] init];
    self.connection = connection;
    [super viewDidLoad];
    [self initSliderApperance];
    

    // Do any additional setup after loading the view.
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
-(void) initLittlePopup{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Пожалуйста, выберите роль:" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil otherButtonTitles:
                            @"Курсант",
                            @"В/С контрактной службы",
                            @"Офицер",
                            nil];
    popup.tag = 1;
    [popup showInView:self.sliderView];
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch(buttonIndex)
    {
        case 0:
            _userRole = @"Курсант";
            break;
        case 1:
            _userRole = @"Контракт";
            break;
        case 2:
            _userRole= @"Офицер";
            break;
    }
}
-(void) initSliderApperance{
    [self.sliderAmount setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderAmount setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                   forState:UIControlStateNormal];
    [self.sliderAmount setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                   forState:UIControlStateNormal];
    [self.sliderTime setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    [self.sliderTime setMinimumTrackImage:[UIImage imageNamed:@"slider_unfilled.jpg"]
                                 forState:UIControlStateNormal];
    [self.sliderTime setMaximumTrackImage:[UIImage imageNamed:@"slider_filled.jpg"]
                                 forState:UIControlStateNormal];

}
-(void) initViewWithSliders: (int) segmentValue{
    NSLog(@"segment value is %i", segmentValue);
    if(segmentValue == 1){
        //Займ
        self.sliderAmount.minimumValue = 15000;
        self.sliderAmount.maximumValue = 90000;
        self.sliderAmount.value = 21000;
        self.sliderTime.minimumValue = 3;
        self.sliderTime.maximumValue = 15;
        self.sliderTime.value = 3;
        self.sliderSumLabel.text = @"15000 р.";
        self.sliderTimeLabel.text = @"3 м";
        
    } else if(segmentValue == 2) {
        //Вклад
        _sliderAmount.minimumValue = 100000;
        _sliderAmount.maximumValue = 3000000;
        _sliderAmount.value = 300000;
        _sliderTime.minimumValue = 12;
        _sliderTime.maximumValue = 36;
        _sliderTime.value = 12;
        self.sliderSumLabel.text = @"300000 р.";
        self.sliderTimeLabel.text = @"12 м";
    }
    
}


-(void) switchView:(int) index{
    if(index == 0){
        [self.sliderView setHidden:YES];
        [self.loginView setHidden:NO];
    } else {
        [self initViewWithSliders:index];
        [self.sliderView setHidden:NO];
//        [self initSliderApperance];
//        [self initViewWithSliders];
        [self.loginView setHidden:YES];
        if(self.roleWindowShow != true){
            [self initLittlePopup];
            self.roleWindowShow = true;
        }

    }
}

- (IBAction)authButton:(id)sender {
    [self.connection getData:@"/users/login" params:[NSString stringWithFormat:@"login=%i&password=%i",3,3]
    success:complete];
    
}
void (^complete)(id) = ^(id json){
    NSLog(@"the result is %@", [json objectForKey:@"surname"]);
};
- (IBAction)viewSwitcher:(id)sender {
    [self switchView:self.segment.selectedSegmentIndex];
}
- (IBAction)changeTime:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    int val = slider.value;
    self.sliderTimeLabel.text = [NSString stringWithFormat:@"%i м.", val];
}
- (IBAction)changeAmount:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int val = slider.value;
    self.sliderSumLabel.text = [NSString stringWithFormat:@"%i р.", val];
}
@end
