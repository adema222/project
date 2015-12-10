//
//  FirstViewController.h
//  NewsList
//
//  Created by Student on 12/10/15.
//  Copyright (c) 2015 Adema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <NSURLConnectionDelegate, UITableViewDataSource, NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}

@property NSDictionary *dict;
@property NSMutableArray *images;

@end
