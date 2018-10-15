//
//  aroundMeViewController.m
//  hyderabadMarketApp
//
//  Created by Bharat shankar on 11/10/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import "aroundMeViewController.h"
#import "Utilities.h"
#import "Constants.h"
#import "ServiceManager.h"
#import "ServiceInitiater.h"
#import "SingleTon.h"
#import "aroundMeTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface aroundMeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * StoreType;
    NSMutableArray * dataArray;
}
@end

@implementation aroundMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSetUp];
    
    dataArray = [[NSMutableArray alloc]init];
    
    StoreType = @"7";
    [self categoriesService];
    
    self.title = @"STORE";
    
    
    // Do any additional setup after loading the view.
}

-(void)pageSetUp
{
    self.electronicsBtn.backgroundColor = [UIColor whiteColor];
    [self.electronicsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.electronicsBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.electronicsBtn.layer.borderWidth = 0.5;
    
    self.stationaryBtn.backgroundColor = [UIColor whiteColor];
    [self.stationaryBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.stationaryBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.stationaryBtn.layer.borderWidth = 0.5;
    
    // this is for navigation bar color set to black
    NSString *hexStr3 = @"#2A86DA";
    
    UIColor *color1 = [self getUIColorObjectFromHexString:hexStr3 alpha:.9];
    
    self.navigationController.navigationBar.barTintColor = color1;
    
    // this is for navigation bar title color
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

//helper method for color hex values
- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

//helper method for color hex values
- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}
- (IBAction)fashionAction:(id)sender {
    self.electronicsBtn.backgroundColor = [UIColor whiteColor];
    [self.electronicsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.electronicsBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.electronicsBtn.layer.borderWidth = 0.5;
    
    self.stationaryBtn.backgroundColor = [UIColor whiteColor];
    [self.stationaryBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.stationaryBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.stationaryBtn.layer.borderWidth = 0.5;
    
    self.fashionBtn.backgroundColor = [UIColor orangeColor];
    [self.fashionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.fashionBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.fashionBtn.layer.borderWidth = 0.5;
    
    StoreType = @"7";
    [self categoriesService];
    
}

- (IBAction)electronicsAction:(id)sender {
    self.fashionBtn.backgroundColor = [UIColor whiteColor];
    [self.fashionBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.fashionBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.fashionBtn.layer.borderWidth = 0.5;
    
    self.stationaryBtn.backgroundColor = [UIColor whiteColor];
    [self.stationaryBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.stationaryBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.stationaryBtn.layer.borderWidth = 0.5;
    
    self.electronicsBtn.backgroundColor = [UIColor orangeColor];
    [self.electronicsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.electronicsBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.electronicsBtn.layer.borderWidth = 0.5;
    
    StoreType = @"8";
    [self categoriesService];
    
}
- (IBAction)stationaryAction:(id)sender {
    self.fashionBtn.backgroundColor = [UIColor whiteColor];
    [self.fashionBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.fashionBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.fashionBtn.layer.borderWidth = 0.5;
    
    self.electronicsBtn.backgroundColor = [UIColor whiteColor];
    [self.electronicsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.electronicsBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.electronicsBtn.layer.borderWidth = 0.5;
    
    
    self.stationaryBtn.backgroundColor = [UIColor orangeColor];
    [self.stationaryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.stationaryBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.stationaryBtn.layer.borderWidth = 0.5;
    
    StoreType = @"9";
    [self categoriesService];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"aroundMeTableViewCell";
    
    aroundMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[aroundMeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.merchantName.text = [Utilities null_ValidationString:[[dataArray objectAtIndex:indexPath.row]objectForKey:@"merchant_name"]];
    
    NSString * distanceString = [NSString stringWithFormat:@"%@ KMS",[Utilities null_ValidationString:[[dataArray objectAtIndex:indexPath.row]objectForKey:@"distance"]]];
    
    cell.distanceLbl.text = distanceString;
    
    cell.stateNameLbl.text = [Utilities null_ValidationString:[[dataArray objectAtIndex:indexPath.row]objectForKey:@"state"]];
    
    
    NSString * featuredimages = [[dataArray objectAtIndex:indexPath.row ] objectForKey:@"merchant_banner"];
    
    NSString *  imageString = [NSString stringWithFormat:@"http://testingmadesimple.org/hydmarket/uploads/merchant_banners/%@",featuredimages];
    
    NSLog(@"===image url  == %@",imageString);
    
    NSURL *url = [NSURL URLWithString:imageString];
    [cell.merchantBannerImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"photo-icon.png"]];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 252;
}



# pragma mark - Webservices


-(void)categoriesService
{
    if ([Utilities isInternetConnectionExists])
    {
        
        
        //loading UI Starting on mainThread
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utilities showLoading:self.view :FontColorHex and:@"#ffffff"];
        });
        
        NSDictionary *requestDict;
        
        //Request URL
        NSString *urlStr = [NSString stringWithFormat:@"%@categorystores",BASEURL];
        requestDict = @{
                        @"type_of_store":StoreType,
                        @"latitude":@"17.3933",
                        @"longitude":@"75.5334"
                        };
        
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            ServiceManager *service = [ServiceManager sharedInstance];
            service.delegate = self;
            
            
            
            [service  handleRequestWithDelegates:urlStr info:requestDict];
            
        });
        
    }
    else
    {
        [Utilities displayCustemAlertViewWithOutImage:@"Please Check Your Internet connection" :self.view];
    }
}


# pragma mark - Webservice Delegates

- (void)responseDic:(NSDictionary *)info
{
    [self handleResponse:info];
}
- (void)failResponse:(NSError*)error
{
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [Utilities removeLoading:self.view];
                   });
}
-(void)handleResponse :(NSDictionary *)responseInfo
{
    NSLog(@"responseInfo ::::%@",responseInfo);
    @try {
        if([[responseInfo valueForKey:@"status"] intValue] == 1)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
               
                dataArray = [responseInfo objectForKey:@"categorystores"];
                
                [self.aroundMeTableView reloadData];
                
            });
            
        }
        else if ([[responseInfo valueForKey:@"status"] intValue] == 2)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (dataArray.count) {
                    [dataArray removeAllObjects];
                }
                
                [self.aroundMeTableView reloadData];
                [Utilities displayToastWithMessage:@"No data found"];
                
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
    
    @catch (NSException *exception) {
        
    }
    @finally {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utilities removeLoading:self.view];
            [self.view endEditing:YES];
        });
        
    }
    
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
