//
//  CommonClassViewController.m
//  Zaggle
//
//  Created by Zaggle Prepaid Ocean Services Private Limited on 6/17/16.
//  Copyright © 2016 Zaggle Prepaid Ocean Services Private Limited. All rights reserved.
//

/*!
 ->  CommonClassViewController used for.
 
 -> In this controller removing the status bar
 
 
 */


#import "CommonClassViewController.h"

@interface CommonClassViewController ()

@end

@implementation CommonClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight){
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]){
            [self prefersStatusBarHidden];
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        }
        else{
            // iOS 6
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        }
        
    }
    else if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown){
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]){
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        }
        else{
            // iOS 6
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        }
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
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
