//
//  OtpViewController.m
//  ShappalityApp
//
//  Created by PossibillionTech on 5/31/17.
//  Copyright © 2017 possibilliontech. All rights reserved.
//

#import "OtpViewController.h"

#import "Constants.h"
#import "Utilities.h"
#import "ServiceManager.h"
#import "homeTabViewController.h"
#import "NSVBarController.h"

@interface OtpViewController ()<ServiceHandlerDelegate>

{
    BOOL isresendOTP;
    NSDictionary *requestDict;
    NSString *strotp ;


}


//array for 6 text fields for otp
@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation OtpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isresendOTP = NO;
    

    NSLog(@"thi is num %@",self.mobileNumberString);
    
    self.numberLabel.text =[NSString stringWithFormat:@"%@",[Utilities getPhoneno]];
    
//    self.lineLabel.backgroundColor = LabelBackgroundColor;
//    self.submitBtn.backgroundColor = ButtonsBgColor;
    
    // to display mobile number
//    SignupViewController * signupVC = [[SignupViewController alloc]init];
//
//    signupVC.mobileNumberText.text = self.numberLabel.text;
}

//action for otp cross button

- (IBAction)otpBackBtn:(id)sender
{
    
//    FirstViewController * firstview =[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"FirstViewController"];
//
//    [self.navigationController pushViewController:firstview animated:YES];

}

//action for submit button

- (IBAction)otpSubmitBtn:(id)sender
{
    [self.view endEditing:YES];
    
    if (isresendOTP == YES)
    {
        
        if ([Utilities isInternetConnectionExists])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [Utilities showLoading:self.view :FontColorHex and:@"#ffffff"];
            });
            
            NSString *urlStr = [NSString stringWithFormat:@"%@verifyOTP",BASEURL];

   strotp = [NSString stringWithFormat:@"%@%@%@%@%@%@",_txt1.text,_txt2.text,_txt3.text,_txt4.text,_txt5.text,_txt6.text];
    
if ([strotp length] == 6 )
    {
        requestDict = @{
                        @"mobilenumber": self.numberLabel.text,
                        @"otp":strotp
                        
                        };
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            ServiceManager *service = [ServiceManager sharedInstance];
            service.delegate = self;
            
            isresendOTP = NO;
            [service  handleRequestWithDelegates:urlStr info:requestDict];
        });

    }
    else
    {
         [Utilities displayCustemAlertViewWithOutImage:@"Please enter OTP" :self.view];

    }
   }
    else
    {
        [Utilities displayCustemAlertViewWithOutImage:@"Please Check Your Internet connection" :self.view];
        
    }
}


else{
    
    
    if ([Utilities isInternetConnectionExists]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utilities showLoading :self.view :FontColorHex and:@"#ffffff"];
        });

        NSString *urlStr = [NSString stringWithFormat:@"%@verifyOTP",BASEURL];
        
        strotp = [NSString stringWithFormat:@"%@%@%@%@%@%@",_txt1.text,_txt2.text,_txt3.text,_txt4.text,_txt5.text,_txt6.text];
        
        if ([strotp length] == 6 )
        {
            requestDict = @{
                            @"mobile_number": self.numberLabel.text,
                            @"otp":strotp
                            
                            };

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                ServiceManager *service = [ServiceManager sharedInstance];
                service.delegate = self;
            
                [service  handleRequestWithDelegates:urlStr info:requestDict];
                
            });
            
        }
        else
        {
            [Utilities displayCustemAlertViewWithOutImage:@"Please enter OTP" :self.view];
            NSLog(@"shjgdhjksdjhk ");
            dispatch_async(dispatch_get_main_queue(), ^{
                [Utilities removeLoading:self.view];
                // [Utilities displayCustemAlertViewWithOutImage:@"Failed to getting data" :self.view];
                
            });
        }
    }
        else
        {
            [Utilities displayCustemAlertViewWithOutImage:@"Please Check Your Internet connection" :self.view];
        }
}
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
                if (isresendOTP == YES)
                {
                    isresendOTP = NO;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *str = [NSString stringWithFormat:@"%@",@"successfully sent to your mobile"];
                        [Utilities displayCustemAlertViewWithOutImage:str :self.view];
                    });

                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utilities SaveAuthKey:[responseInfo valueForKey:@"aut_key"]];
                        [Utilities SaveUserID:[responseInfo valueForKey:@"id"]];
                       // [APPDELEGATE loginChecking];
                        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        
                        NSVBarController * home = [self.storyboard instantiateViewControllerWithIdentifier:@"homeTabViewController"];
                        
                        
                        
                        [home setSelectedIndex:0];
                        //[self.navigationController pushViewController:home animated:YES];
                        
                        [self presentViewController:home animated:YES completion:nil];
                    });
                }
                
            }
            else if ([[responseInfo valueForKey:@"status"] intValue] == 2)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                   // NSString *str = [NSString stringWithFormat:@"%@",[responseInfo valueForKey:@"result"]];
                    [Utilities displayCustemAlertViewWithOutImage:@"Wrong Code" :self.view];
                });

            }
            
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *str = [NSString stringWithFormat:@"%@",[responseInfo valueForKey:@"result"]];
                    [Utilities displayCustemAlertViewWithOutImage:str :self.view];
                });
                
            }
            
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




- (void)clientRequestFailed:(NSDictionary *)errorInfo
{
    
}
    
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//auto fill text fields
-(void)autoFillCodeIntoTextFields:(NSString*)code
{
    _array = [NSMutableArray array];
    
    for (int i = 0; i < [code length]; i++) {
        NSString *ch = [code substringWithRange:NSMakeRange(i, 1)];
        [_array addObject:ch];
    }
    
    for (int i = 0; i < _array.count; i++){
        switch (i) {
            case 0:
                _txt1.text = [_array objectAtIndex:i];
                break;
            case 1:
                _txt2.text = [_array objectAtIndex:i];
                break;
            case 2:
                _txt3.text = [_array objectAtIndex:i];
                break;
            case 3:
                _txt4.text = [_array objectAtIndex:i];
                break;
            case 4:
                _txt5.text = [_array objectAtIndex:i];
                break;
            case 5:
                _txt6.text = [_array objectAtIndex:i];
                break;
            default:
                break;
        }
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



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![string isEqualToString:@""]) {
        textField.text = string;
        if ([textField isEqual:self.txt1])
        {
            [self.txt2 becomeFirstResponder];
        }else if ([textField isEqual:self.txt2])
        {
            [self.txt3 becomeFirstResponder];
        }else if ([textField isEqual:self.txt3])
        {
            [self.txt4 becomeFirstResponder];
        }
        else if ([textField isEqual:self.txt4])
        {
            [self.txt5 becomeFirstResponder];
        }
        else if ([textField isEqual:self.txt5])
        {
            [self.txt6 becomeFirstResponder];
        }
        else{
            [textField resignFirstResponder];
        }
        return NO;
    }
    return YES;
}
//{
//    BOOL shouldProcess = NO; //default to reject
//    BOOL shouldMoveToNextField = NO; //default to remaining on the current field
//    int insertStringLength = [string length];
//
//    if(insertStringLength == 0)
//    {
//        //backspace
//        shouldProcess = YES; //Process if the backspace character was pressed
//    }
//
//    else {
//
//        if([[textField text] length] == 0) {
//
//            shouldProcess = YES; //Process if there is only 1 character right now
//        }
//    }
//    //here we deal with the UITextField on our own
//    if(shouldProcess){
//
//        //grab a mutable copy of what's currently in the UITextField
//
//        NSMutableString* mstring = [[textField text] mutableCopy];
//
//        if([mstring length] == 0){
//            //nothing in the field yet so append the replacement string
//            [mstring appendString:string];
//            shouldMoveToNextField = YES;
//        }
//        else{
//            //adding a char or deleting?
//            if(insertStringLength > 0){
//                [mstring insertString:string atIndex:range.location];
//            }
//            else {
//                [mstring deleteCharactersInRange:range];
//            }
//        }
//        [textField setText:mstring];
//        if (shouldMoveToNextField) {
//
//            NSInteger nextTag = textField.tag + 1;
//
//            UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
//
//            if (! nextResponder){
//                [textField resignFirstResponder];
//            }
//            if (nextResponder)
//            [nextResponder becomeFirstResponder];
//            return NO;
//        }
//    }
//    return NO;
//}


//action for resend otp

- (IBAction)resendOtp:(id)sender
{
    NSString *urlStr = [NSString stringWithFormat:@"%@resendOTP",BASEURL];
    
    NSDictionary *requestDict;
    
    requestDict = @{
                    @"mobilenumber":self.numberLabel.text
                    };
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ServiceManager *service = [ServiceManager sharedInstance];
        service.delegate = self;
        isresendOTP = YES;
        [service  handleRegistration :urlStr info:requestDict andMethod:@"POST"];
    });
}




@end
