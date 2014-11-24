//
//  ContactInformationInfoViewController.h
//  voenbank
//
//  Created by vsokoltsov on 01.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface ContactInformationInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *infoContactAddress;
@property (strong, nonatomic) IBOutlet UILabel *infoContactPhone;
@property (strong, nonatomic) IBOutlet UILabel *infoContactEmail;
@property (strong, nonatomic) IBOutlet UILabel *infoContactPersonSurname;
@property (strong, nonatomic) IBOutlet UILabel *infoContactPersonName;
@property (strong, nonatomic) IBOutlet UILabel *infoContactPersonSecondName;
@property (strong, nonatomic) IBOutlet UILabel *infoContactPersonPhone;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
