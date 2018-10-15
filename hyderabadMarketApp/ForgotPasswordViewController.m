//
//  ForgotPasswordViewController.m
//  Medley
//
//  Created by Bharat shankar on 10/4/16.
//  Copyright © 2017 athena. All rights reserved.
//


#import "ForgotPasswordViewController.h"
#import "LoginViewController.h"
#import "ServiceManager.h"
#import "Utilities.h"
#import "Constants.h"
#import "CustomAlertView.h"


#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 11



//#import "DGActivityIndicatorView.h"


@interface ForgotPasswordViewController ()<UITextFieldDelegate>
{
    IBOutlet UITextField *emailTextField;
    
    __weak IBOutlet UITextField *mobileNumberTextField;
    // DGActivityIndicatorView *activityIndicatorView ;
}

@end

@implementation ForgotPasswordViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    mobileNumberTextField.delegate = self;
   // [Utilities changeTextfieldTextColor:@[mobileNumberTextField] and:NO];
//    [Global changeTextfieldTextColor:@[emailTextField] and:NO];
    // Do any additional setup after loading the view.
    
    _reset_pwd.layer.cornerRadius = 10;
    //////////////////////////////////// to set cell color with hash values //////////////////////////////////
    NSString *hexStr4 = @"#C0C0C0";
    
    UIColor *color = [self getUIColorObjectFromHexString:hexStr4 alpha:.9];
    
    
    
    mobileNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{NSForegroundColorAttributeName: color}];
    
    
    

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


-(IBAction)Back_Clicked:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)Submit_Click:(id)sender
{
    
   // if ([emailTextField.text length] > 0)
   // {
   //     if ([Utilities validateMobileOREmail:mobileNumberTextField.text error:nil])
   //     {
   //             WS_Helper *objWebservice = [[WS_Helper alloc]init];
   //             objWebservice.target = self;
   //             NSDictionary *params = @{@"userName":emailTextField.text};
   //             [SVProgressHUD show];
   //             objWebservice.serviceName = @"diagnosticUserForgotPassword";
   //             [objWebservice sendRequestWithPostURL:[WS_Urls forgotPasswordUrl] andParametrers:params];
           
   //     }
        
   //     else
   //     {
   //         [Utilities getSharedAlertView:nil andMessage:EMAIL_ALERT_ERROR];
            
   //     }
        
   // }
   // else
   // {
//        [Global getSharedAlertView:nil andMessage:EMAIL_ALERT_EMPTY];
        
    //}
    
    
        [self.view endEditing:YES];
        if ([mobileNumberTextField.text length] > 0)
        {
            if ([Utilities validateMobileOREmail:mobileNumberTextField.text error:nil])
            {
                dispatch_async(dispatch_get_main_queue(),
                               ^{

                                   [Utilities showLoading:self.view :FontColorHex and:@"#ffffff"];
                               });
                
                NSDictionary *requestDict;
                NSString *urlStr = [NSString stringWithFormat:@"%@forgotpassword",BASEURL];
                
                requestDict = @{
                                @"mobilenumber":[Utilities null_ValidationString:mobileNumberTextField.text]
                                };
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                               ^{
                                   ServiceManager *service = [ServiceManager sharedInstance];
                                   service.delegate = self;
                                   [service  handleRegistration :urlStr info:requestDict andMethod:@"POST"];
                               });
                
                
            }
            else
            {
                [Utilities displayCustemAlertViewWithOutImage:@"Internet connection error" :self.view];
            }
            
        }
        else
        {
            
            [Utilities displayCustemAlertViewWithOutImage:@"Please enter your mobile number" :self.view];
        }
        
    
    
}

- (IBAction)BackAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    UINavigationController *rootNavigationController = [[UINavigationController alloc]initWithRootViewController:login];
    rootNavigationController.navigationBarHidden = YES;
    [APPDELEGATE window].rootViewController   = rootNavigationController;
}


# pragma mark - Webservice Delegates

//-(void)parserDidPostDataWithHelper:(WS_Helper *)helper andResponse:(NSDictionary *)response
//{
//    @try
//    {
//        if ([helper.serviceName isEqualToString:@"diagnosticUserForgotPassword"]) {
//            if ([[response objectForKey:@"st"]intValue]) {
//                NSLog(@"Response: %@",response );
//                
////                [USERDEFAULTS setBool:YES forKey:@"UserSignedIn"];
////                [USERDEFAULTS setBool:YES forKey:@"SlideSeen"];
////                
//               
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    LoginViewController *otpObject = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//                    [self.navigationController pushViewController:otpObject animated:YES];
//                
//                [SVProgressHUD dismiss];
//                
//                
//            }
//            else{
//                [Global getSharedAlertView:nil andMessage:[response valueForKey:@"msg"]];
//                [SVProgressHUD dismiss];
//                
//            }
//        }
//    }
//    @catch (NSException *exception) {
//        
//    }
//}

- (void)responseDic:(NSDictionary *)info
{
    [self handleResponse:info];
}
- (void)failResponse:(NSError*)error
{
    ////@"Error");
    dispatch_async(dispatch_get_main_queue(), ^{
       // [ activityIndicatorView stopAnimating];
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
           
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            UINavigationController *rootNavigationController = [[UINavigationController alloc]initWithRootViewController:login];
            rootNavigationController.navigationBarHidden = YES;
            [APPDELEGATE window].rootViewController   = rootNavigationController;
            
        }
        
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *str = [NSString stringWithFormat:@"%@",[responseInfo valueForKey:@"result"]];
                //[Utilities displayCustemAlertViewWithOutImage:str :self.view];
                [Utilities displayToastWithMessage:str];
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
        });
        [self.view endEditing:YES];
    }
    
}


#pragma mark - TextFiled delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField ==  mobileNumberTextField)
    {
        [self showDoneButtonOnNumberPad:textField];
    }
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
     [self.view endEditing:YES];
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    [backGroundScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y) animated:YES];
    
//    if (textField == PasswordTextField) {
//        PasswordTextField.clearsOnBeginEditing = NO;
//    }
//    
    return YES;
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
//write up to 10 numbers in mobile field
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //return true;
    if (textField == mobileNumberTextField) {
        NSUInteger newLength = [mobileNumberTextField.text length] + [string length] - range.length;
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        
        NSString *filtered =[[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        while (newLength < CHARACTER_LIMIT) {
            return [string isEqualToString:filtered];
        }
        
        /* Limits the no of characters to be enter in text field */
        
        return (newLength >CHARACTER_LIMIT ) ? YES : NO;
        return true;
        
    }
    return false;
}

// add done button on number keypad
-(void)showDoneButtonOnNumberPad :(UITextField *)txtField
{
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    
    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    done.tintColor = [UIColor blackColor];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexibleSpace,done, nil]];
    txtField.inputAccessoryView = keyboardDoneButtonView;
    
}
-(void)doneClicked:(id)sender
{
    [self.view endEditing:YES];
    
}
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)resetPassAction:(id)sender
{
    
    
    
    [self.view endEditing:YES];
    if ([mobileNumberTextField.text length] == 10)
    {
        if ([Utilities validateMobileOREmail:mobileNumberTextField.text error:nil])
        {
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               
                                [Utilities showLoading:self.view :FontColorHex and:@"#ffffff"];
                           });
            
            NSDictionary *requestDict;
            NSString *urlStr = [NSString stringWithFormat:@"%@forgotPassword",BASEURL];
            
            requestDict = @{
                            @"mobile_number":[Utilities null_ValidationString:mobileNumberTextField.text]
                            };
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
//                           ^{
//                               ServiceManager *service = [ServiceManager sharedInstance];
//                               service.delegate = self;
//                               [service  handleRegistration :urlStr info:requestDict andMethod:@"POST"];
//                           });
            
           // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
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
    else
    {
        
        [Utilities displayCustemAlertViewWithOutImage:@"Please enter your mobilenumber" :self.view];
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
