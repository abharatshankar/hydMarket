//
//  OtpViewController.h
//  ShappalityApp
//
//  Created by PossibillionTech on 5/31/17.
//  Copyright © 2017 possibilliontech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonClassViewController.h"


@interface OtpViewController : CommonClassViewController
@property NSString * mobileNumberString;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@property (strong, nonatomic) IBOutlet UITextField *txt1;
@property (strong, nonatomic) IBOutlet UITextField *txt2;
@property (strong, nonatomic) IBOutlet UITextField *txt3;
@property (strong, nonatomic) IBOutlet UITextField *txt4;
@property (strong, nonatomic) IBOutlet UITextField *txt5;
@property (strong, nonatomic) IBOutlet UITextField *txt6;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


@end
