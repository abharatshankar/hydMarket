//
//  profileViewController.m
//  hyderabadMarketApp
//
//  Created by Bharat shankar on 11/10/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import "profileViewController.h"
#import "Utilities.h"
#import "Constants.h"
#import "ServiceInitiater.h"
#import "ServiceManager.h"
#import "changePasswordViewController.h"

@interface profileViewController ()

@end

@implementation profileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pageSetUp];
    
    // Do any additional setup after loading the view.
}

-(void)pageSetUp
{
    self.title = @"PROFILE";
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2;    
    self.profileImage.clipsToBounds = YES;
    self.nameText.text = [Utilities getName];
    self.mobileText.text = [Utilities getMobileno];
    self.nameText.userInteractionEnabled = NO;
    self.mobileText.userInteractionEnabled = NO;
    
    // this is for navigation bar color set to black
    NSString *hexStr3 = @"#2A86DA";
    
    UIColor *color1 = [Utilities getUIColorObjectFromHexString:hexStr3 alpha:.9];
    
    self.navigationController.navigationBar.barTintColor = color1;
    
    // this is for navigation bar title color
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}


- (IBAction)editButtonAction:(id)sender {
    
}

- (IBAction)changePasswordAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    changePasswordViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"changePasswordViewController"];
    [self.navigationController pushViewController:login animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
