//
//  ResultViewController.m
//  NewsList
//
//  Created by Student on 12/11/15.
//  Copyright (c) 2015 Adema. All rights reserved.
//

#import "ResultViewController.h"
#import "News.h"


@interface ResultViewController ()

@property News *news;
@end

@implementation ResultViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *hash = [self.second objectForKey:@"news_image_file"];
    NSString *url = [@"http://fs.royal.kz/640x480xc/" stringByAppendingString:hash];
    
    NSURL *imageURL = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];

    
    self.descriptionLabel.text = [self.second objectForKey:@"news_cat"];
    self.authorLabel.text = [self.second objectForKey:@"account_fullname"];
    self.imageView.image = image;
    
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

@end
