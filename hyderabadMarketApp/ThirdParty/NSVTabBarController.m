//
//  NSTabBarController.m
//  NSTabbar
//
//  Created by srinivas on 12/31/15.
//  Copyright © 2015 Microexcel. All rights reserved.
//

#import "NSVTabBarController.h"
#import "NSVBarController.h"

@interface NSVTabBarController ()
@end

@implementation NSVTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.delegate = self ;
    // Do any additional setup after loading the view.
    
    
    //*****// TabBar Icons Customization //*****//
    
    // To Create the TabBar icons as NSArray for selection time
    NSArray *selectedimgArray = [NSArray arrayWithObjects:@"aroundme-white.png",@"upload-white.png",@"feed-white.png",@"offer-white.png",@"profile-white.png", nil];
    
    // To Create the TabBar icons as NSArray
    NSArray *imagesArray = [NSArray arrayWithObjects:@"aroundme-black.png",@"upload-black.png",@"feed-black.png",@"offer-black.png",@"profile-black.png",nil];
    
     // Customize the tabBar images
    [NSVBarController settabBar:self.tabBar andImages:imagesArray andSelectedImages:selectedimgArray] ;
    
    //*****//*****//*****//*****//*****//*****//*****//*****//
    
     //****// TabBar Title Customization //*****//
    
    // To Create the attribute dictionary for title for color and font
    NSDictionary *Attribute =  [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    // Customize the tabBar title
    [NSVBarController setTabBarTitleColor:Attribute] ;
    
    //*****//*****//*****//*****//*****//*****//*****//*****//
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    @try {
         //****// TabBar Images Animations //*****//
        [NSVBarController setAnimation:tabBarController andAnimationType:NSAnimation_CurlDown];
         //*****//*****//*****//*****//*****//*****//*****//*****//
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
