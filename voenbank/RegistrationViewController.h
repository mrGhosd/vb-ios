//
//  RegistrationViewController.h
//  voenbank
//
//  Created by vsokoltsov on 01.09.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController <UITextFieldDelegate>{
    IBOutlet UIScrollView *scroll;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) IBOutlet UITextField *surnameField;

@end
