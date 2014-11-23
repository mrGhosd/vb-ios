//
//  PasportInfoViewController.h
//  voenbank
//
//  Created by vsokoltsov on 01.11.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface PasportInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *InfoPasportSeria;
@property (strong, nonatomic) IBOutlet UILabel *infoPasportNumber;
@property (strong, nonatomic) IBOutlet UILabel *infoPasportWhere;
@property (strong, nonatomic) IBOutlet UILabel *infoPasportWhen;
@property (strong, nonatomic) IBOutlet UILabel *infoPasportDefinitionAddress;
@property (strong, nonatomic) IBOutlet UILabel *infoPasportCode;
@property (strong, nonatomic) IBOutlet UILabel *infoPasportOldSeria;
@property (strong, nonatomic) IBOutlet UILabel *infoPasportOldNumber;

@end
