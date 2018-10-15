//
//  CresteAnAccountViewController.m
//  hyderabadMarketApp
//
//  Created by ashwin challa on 10/10/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import "CresteAnAccountViewController.h"
#import "Utilities.h"
#import "Constants.h"
#import "ServiceManager.h"
#import "ServiceInitiater.h"
#import "SingleTon.h"
#import "LoginViewController.h"
#import "OtpViewController.h"

#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 11

@interface CresteAnAccountViewController ()

@end

@implementation CresteAnAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mobileText.delegate = self;
    

    // Do any additional setup after loading the view.
}





- (IBAction)signupAction:(id)sender {
    if (self.nameText.text.length<1) {
        [Utilities displayCustemAlertView:@"Please enter name" :self.view];
    }
    else if (self.mobileText.text.length<1)
    {
        [Utilities displayCustemAlertView:@"Please enter Mobile Number" :self.view];
    }
    else if (self.passwordText.text.length<1)
    {
        [Utilities displayCustemAlertView:@"Please enter Password" :self.view];
    }
    else
    {
        
        
        //        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        OTPViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"OTPViewController"];
        //        UINavigationController *rootNavigationController = [[UINavigationController alloc]initWithRootViewController:login];
        //        rootNavigationController.navigationBarHidden = YES;
        //        [APPDELEGATE window].rootViewController   = rootNavigationController;
        [self signUpServiceCall];
    }
    
    
}
- (IBAction)goBackToSignIn:(id)sender {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            UINavigationController *rootNavigationController = [[UINavigationController alloc]initWithRootViewController:login];
            rootNavigationController.navigationBarHidden = YES;
            [APPDELEGATE window].rootViewController   = rootNavigationController;
}




- (void)signUpServiceCall
{
    
    if (self.nameText.text.length == 0)
    {
        // [Utilities displayCustemAlertViewWithOutImage: [[Utilities gettingPlistUsingDictonary] valueForKey:@"signup_name_error_msg"] :self.view];
        [Utilities displayCustemAlertView:@"Please enter name" :self.view];
        //        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter all valid data" preferredStyle:UIAlertControllerStyleAlert];
        //        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertControllerStyleAlert handler:^(UIAlertAction * _Nonnull action) {
        //
        //        }];
        //        [alert addAction:okAction];
        //        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if (self.nameText.text.length <3)
    {
        [Utilities displayCustemAlertView:@"Please enter more than 3 char" :self.view];
       
        
    }
    
    else if (self.mobileText.text.length < 10 || self.mobileText.text.length == 0 || self.mobileText.text.length > 10)
    {
        [Utilities displayCustemAlertView:@"Please enter valid Mobile Number" :self.view];
        //[Utilities displayCustemAlertViewWithOutImage:[[Utilities gettingPlistUsingDictonary] valueForKey:@"signup_number_error_msg"] :self.view];
        //        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter valid data" preferredStyle:UIAlertControllerStyleAlert];
        //        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertControllerStyleAlert handler:^(UIAlertAction * _Nonnull action) {
        //        }];
        //        [alert addAction:okAction];
        //        [self presentViewController:alert animated:YES completion:nil];
        
    }
    //    else if (emailTextField.text.length == 0) {
    //        [Utilities displayCustemAlertViewWithOutImage:[[Utilities gettingPlistUsingDictonary] valueForKey:@"signup_email_error_msg"] :self.view];
    //    }
    //    else if (![Utilities emailCredibility:emailTextField.text]) {
    //        [Utilities displayCustemAlertViewWithOutImage:[[Utilities gettingPlistUsingDictonary] valueForKey:@"signup_invalid_email_error_msg"] :self.view];
    //    }
    else if (self.passwordText.text.length == 0)
    {
        [Utilities displayCustemAlertView:@"Please enter Password" :self.view];
        
        //[Utilities displayCustemAlertViewWithOutImage:[[Utilities gettingPlistUsingDictonary] valueForKey:@"signup_nopassword_error_msg"] :self.view];
        
        
    }
    
    
    
    
    else
    {
        
        
        NSDictionary *requestDict;
        NSString *urlStr = [NSString stringWithFormat:@"%@signup",BASEURL];
        
        requestDict = @{
                        
                        @"name":[Utilities null_ValidationString:self.nameText.text],
                        @"mobile_number":[Utilities null_ValidationString:self.mobileText.text],
                        @"device_token":@"123456",
                        @"password":[Utilities null_ValidationString:self.passwordText.text],
                        @"device_type":@"ios",
                        
                        @"type":@"direct",
                        @"facebook_id":@"",
                        
                        @"google_id":@""
                        
                        
                        };
        
        
        
        [Utilities savePhoneno:[Utilities null_ValidationString:self.mobileText.text]];
        
        if ([Utilities isInternetConnectionExists]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //                    activityIndicatorView  = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)DGActivityIndicatorAnimationTypeBallPulse tintColor:[UIColor redColor]];
                //
                //
                //                    activityIndicatorView.frame = self.view.frame ;
                //                    [self.view addSubview:activityIndicatorView];
                //                    [activityIndicatorView startAnimating];
                
                [Utilities showLoading:self.view :FontColorHex and:@"#ffffff"];
            });
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                ServiceManager *service = [ServiceManager sharedInstance];
                service.delegate = self;
                [service  handleRegistration :urlStr info:requestDict andMethod:@"POST"];
                
            });
        }
        else{
            [Utilities displayCustemAlertViewWithOutImage:[[Utilities gettingPlistUsingDictonary] valueForKey:@"internet_connection_error"] :self.view];
            
        }
        
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
-(void)animateTextField:(UITextField*)textField up:(BOOL)up withOffset:(CGFloat)offset
{
    const int movementDistance = -offset;
    const float movementDuration = 0.4f;
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //return true;
    if (textField == self.mobileText) {
        NSUInteger newLength = [self.mobileText.text length] + [string length] - range.length;
        
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
        // [Utilities displayCustemAlertViewWithOutImage:@"Failed to getting data" :self.view];
        
    });
}
-(void)handleResponse :(NSDictionary *)responseInfo
{
    
    
    NSLog(@"responseInfo :%@",responseInfo);
    @try {
        if([[responseInfo valueForKey:@"status"] intValue] == 1)
        {
            
            // to save user_id to use in further classes service calls
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                
                
                
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    OtpViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"OtpViewController"];
                    login.mobileNumberString = self.mobileText.text;
                    UINavigationController *rootNavigationController = [[UINavigationController alloc]initWithRootViewController:login];
                    rootNavigationController.navigationBarHidden = YES;
                    
                
                    
                    [Utilities saveMobileno:[responseInfo valueForKey:@"mobile_number"]];
                    
                    [Utilities saveName:[Utilities null_ValidationString:self.nameText.text]];
                    
//                    NSData* myuserData = [NSKeyedArchiver archivedDataWithRootObject:myMutableArray];
//
//                    [USERDEFAULTS setObject:myuserData forKey:@"invitedUserEventArray"];
//
//                    if ([[responseInfo valueForKey:@"invite_status"] intValue] == 1) {
//                        [USERDEFAULTS setBool:YES forKey:@"invite_status"];
//                    }
//                    else
//                    {
//
//                        [USERDEFAULTS setBool:NO forKey:@"invite_status"];
//                    }
                
                    
            
                    [APPDELEGATE window].rootViewController   = rootNavigationController;
                    
                
                
                
                
                
                
                //                [Utilities saveUserId:[responseInfo objectForKey:@"userid"]];
                //                OTPViewController * otpview = [self.storyboard instantiateViewControllerWithIdentifier:@"OTPViewController"];
                //                otpview.otpString = [responseInfo objectForKey:@"otp"];
                //                //[self presentViewController:otpview animated:YES completion:nil];
                //                [self.navigationController pushViewController:otpview animated:YES];
                
            });
            
            
        }
        
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *str = [NSString stringWithFormat:@"%@",[responseInfo valueForKey:@"result"]];
                // [Utilities displayCustemAlertViewWithOutImage:str :self.view];
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertControllerStyleAlert handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
