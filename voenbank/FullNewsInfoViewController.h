//
//  FullNewsInfoViewController.h
//  voenbank
//
//  Created by vsokoltsov on 07.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import "ViewController.h"
@class APIConnect;

@interface FullNewsInfoViewController : ViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *newsImage;
@property (strong, nonatomic) IBOutlet UILabel *newsLabel;
@property(nonatomic) NSDictionary *newsData;
@property (strong, nonatomic) IBOutlet UITextView *newsText;
@end
