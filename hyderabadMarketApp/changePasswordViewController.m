//
//  changePasswordViewController.m
//  buzzedApp
//
//  Created by ashwin challa on 8/18/17.
//  Copyright © 2017 adroitent.com. All rights reserved.
//

#import "changePasswordViewController.h"
#import "Utilities.h"
#import "Constants.h"
#import "profileViewController.h"
#import "ServiceManager.h"
#import "ServiceInitiater.h"
#import "homeTabViewController.h"


//#import "DGActivityIndicatorView.h"


@interface changePasswordViewController ()
{
   // DGActivityIndicatorView *activityIndicatorView ;

}
@end

@implementation changePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.changePasswordBut.layer.cornerRadius = 4;
    // this is for navigation bar color set to black
    NSString *hexStr3 = @"#2A86DA";
    
    UIColor *color1 = [Utilities getUIColorObjectFromHexString:hexStr3 alpha:.9];
    
    self.navigationController.navigationBar.barTintColor = color1;
    
    // this is for navigation bar title color
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //////////////////////////////////////////////////////////////////////////
    ////////////////  this is to set title in navigation bar  ////////////////
    NSMutableArray *arrLeftBarItems = [[NSMutableArray alloc] init];
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    

    
    
    UIButton *btnLib1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLib1.frame = CGRectMake(0, 0, 22, 22);
    btnLib1.showsTouchWhenHighlighted=YES;
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib1];
    [arrLeftBarItems addObject:barButtonItem2];
    [btnLib1 addTarget:self action:@selector(Back_Click) forControlEvents:UIControlEventTouchUpInside];
    [btnLib1 setImage:[UIImage imageNamed:@"icons8-left-24.png"] forState:UIControlStateNormal ];
    
    
    //for right bar buttons
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(275, 5, 28, 25);
    [menuButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    menuButton.showsTouchWhenHighlighted=YES;
    
    
    //--right buttons--//
    UIButton *btntitle = [UIButton buttonWithType:UIButtonTypeCustom];
    btntitle.frame = CGRectMake(30, 0, 150, 30);
    [btntitle setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    btntitle.showsTouchWhenHighlighted=YES;
    UIBarButtonItem *barButtonItem3 = [[UIBarButtonItem alloc] initWithCustomView:btntitle];
    [arrLeftBarItems addObject:barButtonItem3];
    btntitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btntitle setTitle:@"Change Password" forState:UIControlStateNormal];
    [btntitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItems = arrLeftBarItems;
    self.navigationItem.rightBarButtonItems = arrRightBarItems;
    //////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////
    

    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)Back_Click
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changePass:(id)sender
{
    
    if ([self.oldPassTxt.text isEqualToString:[USERDEFAULTS objectForKey:@"UserPassword"]])
    {
        
    
    
    if ([self.confirmPasswordTxtFld.text isEqualToString:self.PassTextfld.text])
    {
        if ([Utilities isInternetConnectionExists])
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{


                [Utilities showLoading:self.view :FontColorHex and:@"#ffffff"];
            });
            NSDictionary *requestDict;
            NSString *urlStr = [NSString stringWithFormat:@"%@changePassword",BASEURL];
            requestDict = @{
                            @"oldpassword":[USERDEFAULTS objectForKey:@"UserPassword"],
                            @"newpassword":self.confirmPasswordTxtFld.text,
                            @"user_id":[Utilities getUserID]
                            
                            };
            
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                ServiceManager *service = [ServiceManager sharedInstance];
                service.delegate = self;
                
                [service  handleRequestWithDelegates:urlStr info:requestDict];
                
            });
            
            
            
        }
        else
        {
            [Utilities displayCustemAlertViewWithOutImage:[[Utilities gettingPlistUsingDictonary] valueForKey:@"internet_connection_error"] :self.navigationController.view];
            [Utilities displayCustemAlertViewWithOutImage:@"Please check your connection" :self.view];
            
        }
    }
    else
    {
     [Utilities displayCustemAlertViewWithOutImage:@"New password and confirm password must be same" :self.view];
    }
    }
    else
    {
    [Utilities displayCustemAlertViewWithOutImage:@"Check your Old password " :self.view];
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
       // [ activityIndicatorView stopAnimating];
        [Utilities removeLoading:self.view];
         [Utilities displayCustemAlertViewWithOutImage:@"Failed to getting data" :self.view];
        
    });
}
-(void)handleResponse :(NSDictionary *)responseInfo
{
    NSLog(@"responseInfo %@",responseInfo);
    @try {
        if([[responseInfo valueForKey:@"status"] intValue] == 1)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                homeTabViewController * home = [self.storyboard instantiateViewControllerWithIdentifier:@"homeTabViewController"];
                
                
                [home setSelectedIndex:0];
                
                [self presentViewController:home animated:YES completion:nil];

                
                
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
            //[ activityIndicatorView stopAnimating];
            [Utilities removeLoading:self.view];
        });
        
    }
    
    @catch (NSException *exception) {
        
    }
    @finally {
        dispatch_async(dispatch_get_main_queue(), ^{
            //[ activityIndicatorView stopAnimating];
            [Utilities removeLoading:self.view];
        });
        [self.view endEditing:YES];
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
