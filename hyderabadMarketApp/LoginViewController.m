//
//  LoginViewController.m
//  hyderabadMarketApp
//
//  Created by Bharat shankar on 10/10/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import "LoginViewController.h"
#import "CresteAnAccountViewController.h"

#import "ForgotPasswordViewController.h"
#import "Constants.h"
#import "Utilities.h"
#import "ServiceManager.h"
#import "ServiceInitiater.h"
#import "AFHTTPSessionManager.h"
//#import "signUpViewController.h"
//#import <GoogleSignIn/GoogleSignIn.h>
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "homeTabViewController.h"
#import "SingleTon.h"
//#import "frontViewController.h"
//#import "FBVerifyNumberViewController.h"
#import "AppDelegate.h"

#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 11

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSetUp];
    // Do any additional setup after loading the view.
}

-(void)createSetUp
{
    self.logoImg.layer.cornerRadius = self.logoImg.frame.size.width/2;
    self.fbBtn.layer.borderWidth = 0.5;
    self.fbBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.gmBtn.layer.borderWidth = 0.5;
    self.gmBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [self.createAnAccountBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    self.createAnAccountBtn.titleLabel.numberOfLines = 2;
    [self.forgotPassBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    self.forgotPassBtn.titleLabel.numberOfLines = 0;
    self.numberText.delegate = self;
    self.numberText.text = @"0000000001";
    self.passwordText.text = @"123456";
    
}

- (IBAction)forgotPasswordAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ForgotPasswordViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    UINavigationController *rootNavigationController = [[UINavigationController alloc]initWithRootViewController:login];
    rootNavigationController.navigationBarHidden = YES;
    [APPDELEGATE window].rootViewController   = rootNavigationController;
}

- (IBAction)signupPage:(id)sender {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CresteAnAccountViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"CresteAnAccountViewController"];
            UINavigationController *rootNavigationController = [[UINavigationController alloc]initWithRootViewController:login];
            rootNavigationController.navigationBarHidden = YES;
            [APPDELEGATE window].rootViewController   = rootNavigationController;
}


-(IBAction)LoginClicked:(id)sender
{
    
    
    [self.view endEditing:YES];
    
    
    if ([Utilities isInternetConnectionExists])
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [Utilities showLoading:self.view :FontColorHex and:@"#ffffff"];
        });
        
        
        if (_numberText.text.length<10 || _numberText.text.length>10 || _numberText.text.length == 0) {
            [Utilities displayCustemAlertView:@"please enter mobile number" :self.view];
            dispatch_async(dispatch_get_main_queue(), ^{
                //[ activityIndicatorView stopAnimating];
                [Utilities removeLoading:self.view];
                
                
            });
        }
        else if (self.passwordText.text.length ==0)
        {
            [Utilities displayCustemAlertView:@"please Enter Password" :self.view];
            dispatch_async(dispatch_get_main_queue(), ^{
                //[ activityIndicatorView stopAnimating];
                [Utilities removeLoading:self.view];
                
                
            });
        }
        
        else{
            
            
            NSDictionary *requestDict;
            NSString *urlStr = [NSString stringWithFormat:@"%@login",BASEURL];
            
            if ([Utilities validateMobileOREmail:self.numberText.text error:nil])
            {
                
                NSLog(@"mobile %@ \n password %@ \n device_token %@",self.numberText.text,_passwordText.text,[Utilities getDeviceToken]);
                
                requestDict = @{
                                @"mobile_number":self.numberText.text ,   //test with @"1234567890"
                                @"password":self.passwordText.text,    //test with @"123456"
                                @"device_token":/*[Utilities getDeviceToken]*/@"123456",
                                @"device_type":@"ios"
                                };
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    ServiceManager *service = [ServiceManager sharedInstance];
                    service.delegate = self;
                    
                    [service  handleRequestWithDelegates:urlStr info:requestDict];
                    
                });
            }
            
        }
    }
    else
    {

        [Utilities displayCustemAlertViewWithOutImage:@"Please check your connection" :self.view];
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



# pragma mark - Webservice Delegates

- (void)responseDic:(NSDictionary *)info
{
    [self handleResponse:info];
}
- (void)failResponse:(NSError*)error
{
    ////@"Error");
    dispatch_async(dispatch_get_main_queue(), ^{
        //[ activityIndicatorView stopAnimating];
        [Utilities removeLoading:self.view];
        [Utilities displayCustemAlertViewWithOutImage:@"Failed to getting data" :self.view];
        
    });
}
-(void)handleResponse :(NSDictionary *)responseInfo
{
    NSLog(@"responseInfo :=::%@",responseInfo);
    @try {
        if([[responseInfo valueForKey:@"status"] intValue] == 1)
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // save password in userDefaults to use in cahnge Password Service call
                [Utilities saveName:self.numberText.text];
                [USERDEFAULTS setObject:self.passwordText.text forKey:@"UserPassword"];
                
                // saved userId to use in further future classes
                [USERDEFAULTS setObject:[[responseInfo objectForKey:@"data"] objectForKey:@"user_id"] forKey:@"user_id"];
                
                [Utilities SaveUserID:[[responseInfo objectForKey:@"data"] objectForKey:@"user_id"] ];
                
                [Utilities saveMobileno:[[responseInfo objectForKey:@"data"] objectForKey:@"mobile_number"]];
                
                [Utilities saveName:[[responseInfo objectForKey:@"data"] objectForKey:@"name"]];
                
                NSString * proPic = [Utilities null_ValidationString:[[responseInfo objectForKey:@"data"] objectForKey:@"profile_image"]];
                
                if (proPic.length) {
                    
                    [USERDEFAULTS setObject:[[responseInfo objectForKey:@"data"] objectForKey:@"profile_image"] forKey:@"profile_image"];
                    
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseInfo];
                    
                    [USERDEFAULTS setObject:data forKey:@"data"];
                    
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                    
                    NSData *dictionaryData = [USERDEFAULTS objectForKey:@"data"];
                    
                    dic = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
                    
                    
                }
                
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                homeTabViewController * home = [self.storyboard instantiateViewControllerWithIdentifier:@"homeTabViewController"];
                
                
                
                [home setSelectedIndex:0];
                //[self.navigationController pushViewController:home animated:YES];
                
                [self presentViewController:home animated:YES completion:nil];
                
                //                animationViewController * tabs = [storyboard instantiateViewControllerWithIdentifier:@"animationViewController"];
                //                [self.navigationController pushViewController:tabs animated:YES];
                
            });
            
            
        }
        
        else if ([[responseInfo valueForKey:@"status"] intValue] == 3)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [Utilities displayCustemAlertViewWithOutImage:@"Number does not exist" :self.view];
                NSLog(@"===status 3===");
                
            });
        }
        else if ([[responseInfo valueForKey:@"status"] intValue] == 2)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [Utilities displayCustemAlertViewWithOutImage:@"Wrong Password" :self.view];
                NSLog(@"===status 2===");
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *str = [NSString stringWithFormat:@"%@",[responseInfo valueForKey:@"result"]];
                [Utilities displayCustemAlertViewWithOutImage:@"check your connection" :self.view];
                NSLog(@"===status other than 1===");
                
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
            [self.view endEditing:YES];
        });
        
    }
    
}


#pragma mark - TextFiled delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //    [backGroundScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    [backGroundScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y) animated:YES];
    
    if (textField == self.passwordText) {
        self.passwordText.clearsOnBeginEditing = NO;
    }
    
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //return true;
    if (textField == self.numberText) {
        NSUInteger newLength = [self.numberText.text length] + [string length] - range.length;
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        
        NSString *filtered =[[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        while (newLength < CHARACTER_LIMIT) {
            return [string isEqualToString:filtered];
        }
        
        /* Limits the no of characters to be enter in text field */
        
        return (newLength >CHARACTER_LIMIT ) ? YES : NO;
        return true;
        
    }
    if (textField == self.passwordText)
    {
        return true;
    }
    return false;
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
