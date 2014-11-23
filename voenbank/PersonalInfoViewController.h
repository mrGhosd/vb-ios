//
//  PersonalInfoViewController.h
//  voenbank
//
//  Created by vsokoltsov on 01.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@class APIConnect;

@interface PersonalInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *infoSurname;
@property (strong, nonatomic) IBOutlet UILabel *infoName;
@property (strong, nonatomic) IBOutlet UILabel *infoSecondName;
@property (strong, nonatomic) IBOutlet UILabel *infoDateOfBirth;
@property (strong, nonatomic) IBOutlet UILabel *infoPlaceOfBirth;
@property (strong, nonatomic) IBOutlet UILabel *infoCreatedAt;
@property (strong, nonatomic) IBOutlet UILabel *infoRole;
@property (strong, nonatomic) IBOutlet UILabel *infoSex;
@property (strong, nonatomic) IBOutlet UILabel *infoPhone;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
