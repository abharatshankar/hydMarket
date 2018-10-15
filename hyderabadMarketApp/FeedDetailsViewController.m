//
//  FeedDetailsViewController.m
//  hyderabadMarketApp
//
//  Created by Bharat shankar on 12/10/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import "FeedDetailsViewController.h"
#import "Utilities.h"
#import "Constants.h"
#import "ServiceManager.h"
#import "ServiceInitiater.h"
#import "ServiceInitiater.h"
#import "UIImageView+WebCache.h"

@interface FeedDetailsViewController ()

{
}
@end

@implementation FeedDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self FeedDetailsServiceCall];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)FeedDetailsServiceCall
{
    [self.view endEditing:YES];
    
    if ([Utilities isInternetConnectionExists]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utilities showLoading:self.view :FontColorHex and:@"#ffffff"];
        });
        NSDictionary * requestDict;
        NSString *urlStr = [NSString stringWithFormat:@"%@feedview",BASEURL];
        requestDict = @{
                        
                        @"feed_id": self.feedIdStr
                        
                        };
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            ServiceManager *service = [ServiceManager sharedInstance];
            service.delegate = self;
            
            [service  handleRequestWithDelegates:urlStr info:requestDict];
        });
    }
    else
    {
        [Utilities displayCustemAlertViewWithOutImage:@"Internet connection error" :self.view];
    }
}

# pragma mark - Webservice Delegates

- (void)responseDic:(NSDictionary *)info
{
    [self handleResponse:info];
}
- (void)failResponse:(NSError*)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [Utilities removeLoading:self.view];
    });
}
-(void)handleResponse :(NSDictionary *)responseInfo
{
    NSLog(@"responseInfo :%@",responseInfo);
    
    if([[responseInfo valueForKey:@"status"] intValue] == 1)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.merchantNameLbl.text =  [[responseInfo objectForKey:@"feedinfo"] objectForKey:@"merchant_name"];
            self.merchantTitleLbl.text = [[responseInfo objectForKey:@"feedinfo"] objectForKey:@"title"];
            self.descriptionLbl.text =[[responseInfo objectForKey:@"feedinfo"] objectForKey:@"description"];
            //
            NSString * featuredimages = [[responseInfo objectForKey:@"feedinfo"]  objectForKey:@"photo"];
            
            NSString *  imageString = [NSString stringWithFormat:@"http://testingmadesimple.org/hydmarket/uploads/feed/%@",featuredimages];
            
            NSLog(@"===image url  == %@",imageString);
            
            NSURL *url = [NSURL URLWithString:imageString];
            [self.detailBannerImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"photo-icon.png"]];
            
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *str = [NSString stringWithFormat:@"%@",[responseInfo valueForKey:@"result"]];
            [Utilities displayCustemAlertViewWithOutImage:str :self.view];
        });
        
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Utilities removeLoading:self.view];
    });
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
