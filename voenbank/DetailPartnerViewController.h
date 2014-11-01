//
//  DetailPartnerViewController.h
//  voenbank
//
//  Created by vsokoltsov on 31.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPartnerViewController : UIViewController
@property(nonatomic, strong) NSDictionary *detailPartner;
@property (strong, nonatomic) IBOutlet UILabel *partnerTitle;
@property (strong, nonatomic) IBOutlet UILabel *partnerURL;
@property (strong, nonatomic) IBOutlet UIImageView *partnerImage;
@property (strong, nonatomic) IBOutlet UITextView *partnerDescription;

@end
