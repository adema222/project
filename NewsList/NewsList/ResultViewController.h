//
//  ResultViewController.h
//  NewsList
//
//  Created by Student on 12/11/15.
//  Copyright (c) 2015 Adema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;


@property NSMutableDictionary *second;


@end
