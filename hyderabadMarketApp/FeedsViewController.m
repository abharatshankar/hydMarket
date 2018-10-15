//
//  FeedsViewController.m
//  hyderabadMarketApp
//
//  Created by ashwin challa on 10/11/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import "FeedsViewController.h"
#import "Utilities.h"
#import "FeedDetailsViewController.h"
#import "Constants.h"
#import "ServiceManager.h"
#import "FeedsTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"


@interface FeedsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *totalFeedArray;
    NSMutableArray * feedImages;
    NSString *imageString;


}
@end

@implementation FeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    totalFeedArray = [[NSMutableArray alloc]init];
    feedImages = [[NSMutableArray alloc]init];

    self.feedTblView.delegate = self;
    self.feedTblView.dataSource = self;
    
    self.title = @"FEEDS";
    
    [self feedServiceCall];
}

-(void)feedServiceCall
{
    
    [self.view endEditing:YES];
    
    if ([Utilities isInternetConnectionExists]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utilities showLoading:self.view :FontColorHex and:@"#ffffff"];
        });
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"http://testingmadesimple.org/hydmarket/api/services/feed" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
//            [Utilities SaveFeedID:[[responseObject objectForKey:@"feed"] objectForKey:@"feed_id"] ];
            totalFeedArray = [responseObject objectForKey:@"feed"];
            [self.feedTblView reloadData];
            
             
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else
    {
        [Utilities displayCustemAlertViewWithOutImage:@"Internet connection error" :self.view];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Utilities removeLoading:self.view];
    });
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 137;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return totalFeedArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    
    static NSString *CellIdentifier = @"FeedsTableViewCell";
    
    FeedsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FeedsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    cell.titleLabel.text  =[NSString stringWithFormat:@"%@", [[totalFeedArray objectAtIndex:indexPath.row]objectForKey:@"title"]];
    
    
    cell.merchantName.text = [NSString stringWithFormat:@"%@",[[totalFeedArray objectAtIndex:indexPath.row]objectForKey:@"merchant_name"]];
    cell.descriptionLabel.text = [NSString stringWithFormat:@"%@",[[totalFeedArray objectAtIndex:indexPath.row]objectForKey:@"description"]];
    
    NSString *  imageString = [NSString stringWithFormat:@"http://testingmadesimple.org/hydmarket/uploads/feed/%@", [[totalFeedArray objectAtIndex:indexPath.row] objectForKey:@"photo"]];
    
    NSLog(@"===image url  == %@",imageString);
    
    NSURL *url = [NSURL URLWithString:imageString];
    [cell.feedImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"product-banner.png"]];
    
    
    [Utilities addShadowtoView:cell.bgview];
    
    return cell;
}

        


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedDetailsViewController * feed = [storyboard instantiateViewControllerWithIdentifier:@"FeedDetailsViewController"];
    NSString * feedStr = [NSString stringWithFormat:@"%d",[[[totalFeedArray objectAtIndex:indexPath.row] objectForKey:@"feed_id"] intValue]];
    feed.feedIdStr = feedStr;

    [self.navigationController pushViewController:feed animated:YES];
    
}


@end
