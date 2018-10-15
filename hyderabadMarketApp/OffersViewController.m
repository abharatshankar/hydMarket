//
//  OffersViewController.m
//  hyderabadMarketApp
//
//  Created by ashwin challa on 10/11/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import "OffersViewController.h"
#import "offersTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import "Utilities.h"
#import "Constants.h"
#import "ServiceManager.h"
#import "ServiceInitiater.h"
#import "UIImageView+WebCache.h"


@interface OffersViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * totalResponse;
    
//    Icons change
//    
//    In login page :
//    Forgot password screen
//    In login page fb and gmail buttons
//
//    In home page :
//    Tableview data and search implementation
//
//
//    In offers page and feeds page
//    On click data to set
//
//    In profile page
//    Edit profile Page creation and services
}
@end

@implementation OffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //offers
   
    totalResponse = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.hidden = YES;

    if ([Utilities isInternetConnectionExists])
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [Utilities showLoading:self.view :FontColorHex and:@"#ffffff"];
        });
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"http://testingmadesimple.org/hydmarket/api/services/offers" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            [Utilities removeLoading:self.view];

            totalResponse = [responseObject objectForKey:@"offers"];
            
            self.offersTable.frame = CGRectMake(self.offersTable.frame.origin.x, self.offersTable.frame.origin.y, self.offersTable.frame.size.width, totalResponse.count * 211);
            
            self.scrollViw.contentSize = CGSizeMake(0, self.offersTable.frame.size.height +140);
            
            [self.offersTable reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        
        
    }
    else
    {
        
        [Utilities displayCustemAlertViewWithOutImage:@"Please check your connection" :self.view];
        
        
    }
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return totalResponse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"offersTableViewCell";
    
    offersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[offersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.offerTitle.text = [[totalResponse objectAtIndex:indexPath.row] objectForKey:@"offer_name"];
    
    cell.merchantName.text = [[totalResponse objectAtIndex:indexPath.row] objectForKey:@"merchant_name"];
    
    NSString * offerText=  [NSString stringWithFormat:@"%d",[[[totalResponse objectAtIndex:indexPath.row] objectForKey:@"discount"] intValue]];
    
    cell.offerPercentace.text = [NSString stringWithFormat:@"%@ %%",offerText];
    cell.offerPrice.text =  [[totalResponse objectAtIndex:indexPath.row] objectForKey:@"offer_price"];
    cell.discountPrice.text =  [[totalResponse objectAtIndex:indexPath.row] objectForKey:@"price"];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[[totalResponse objectAtIndex:indexPath.row] objectForKey:@"price"]];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    cell.discountPrice.attributedText = attributeString;
    
    NSString *  imageString = [NSString stringWithFormat:@"http://testingmadesimple.org/hydmarket/uploads/offers/%@", [[totalResponse objectAtIndex:indexPath.row] objectForKey:@"image"]];
    
    NSLog(@"===image url  == %@",imageString);
    
    NSURL *url = [NSURL URLWithString:imageString];
    [cell.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"product-banner.png"]];
    
    
    [Utilities addShadowtoView:cell.offerView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 211;
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
