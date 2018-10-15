//
//  profileViewController.h
//  hyderabadMarketApp
//
//  Created by Bharat shankar on 11/10/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface profileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *mobileText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;

@end
