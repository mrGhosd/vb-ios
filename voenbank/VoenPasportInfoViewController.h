//
//  VoenPasportInfoViewController.h
//  voenbank
//
//  Created by vsokoltsov on 01.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface VoenPasportInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *infoVoenPasportSeria;
@property (strong, nonatomic) IBOutlet UILabel *infoVoenPasportNumber;
@property (strong, nonatomic) IBOutlet UILabel *infoVoenPasportWhere;
@property (strong, nonatomic) IBOutlet UILabel *infoVoenPasportWhen;
@property (strong, nonatomic) IBOutlet UILabel *infoVoenPasportNationality;
@property (strong, nonatomic) IBOutlet UILabel *infoVoenPasportEducation;
@property (strong, nonatomic) IBOutlet UILabel *infoVoenPasportRelationship;
@property (strong, nonatomic) IBOutlet UILabel *infoVoenPasportSpecialization;
@property (strong, nonatomic) IBOutlet UILabel *infoVoenPasportSportMastery;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
