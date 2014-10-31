//
//  PartnersViewController.h
//  voenbank
//
//  Created by vsokoltsov on 31.10.14.
//  Copyright (c) 2014 vsokoltsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIConnect.h"

@interface PartnersViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) APIConnect *connection;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
