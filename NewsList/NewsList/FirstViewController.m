//
//  FirstViewController.m
//  NewsList
//
//  Created by Student on 12/10/15.
//  Copyright (c) 2015 Adema. All rights reserved.
//

#import "FirstViewController.h"
#import "TableViewCell.h"
#import "News.h"
#import "ResultViewController.h"


@interface FirstViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property News *news;

@property NSString *news_title;
@property NSString *news_cat;
@property NSString *news_created_date;



@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.images = [NSMutableArray new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        [self makeGetRequest];
        
        for(int i=0; i<[[self.dict objectForKey:@"models"]count]; i++)
            [self.images addObject:[NSString stringWithFormat:@"%@%@", @"http://fs.royal.kz/640x480xc/", [[[self.dict objectForKey:@"models"] objectAtIndex:i]objectForKey:@"new_image_file"]]];
        
        
        dispatch_async(dispatch_get_main_queue(),  ^(void) {
            
            [self.tableView reloadData];
            
        });
    });

}


-(void) makeGetRequest{
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.royal.kz/soc/news"]];
    NSURLResponse * response = nil;
    
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    self.dict = [NSMutableDictionary new];
    
    if(error == nil){
        
    self.dict = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
    
    NSLog(@"result: %lu", self.dict.count);
    NSLog(@"%@", self.dict);
        
        
        request = [[NSMutableURLRequest alloc] init];
        
        
        return;

    }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
        
        NSString *hash = [[[self.dict objectForKey:@"models"] objectAtIndex:indexPath.row]objectForKey: @"news_image_file"];
        NSString *url = [@"http://fs.royal.kz/640x480xc/" stringByAppendingString:hash];
        
        NSURL *imageURL = [NSURL URLWithString:url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
    
        cell.imageView.image = image;
    
    
    cell.titleLabel.text = [[[self.dict objectForKey:@"models"] objectAtIndex:indexPath.row]objectForKey: @"news_title"];
    cell.viewsLabel.text = [[[self.dict objectForKey:@"models"] objectAtIndex:indexPath.row]objectForKey: @"news_cat"];
    cell.dateLabel.text = [[[self.dict objectForKey:@"models"] objectAtIndex:indexPath.row]objectForKey: @"news_created_date"];
   

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"goTesting" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    ResultViewController *vc = (ResultViewController *)[segue destinationViewController];
    vc.second = [[self.dict objectForKey:@"models"] objectAtIndex:indexPath.row];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dict objectForKey:@"models"]count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
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
