//
//  FeedDetailsViewController.h
//  hyderabadMarketApp
//
//  Created by Bharat shankar on 12/10/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedDetailsViewController : UIViewController

@property NSString * feedIdStr;
@property (weak, nonatomic) IBOutlet UIImageView *detailBannerImage;
@property (weak, nonatomic) IBOutlet UILabel *merchantTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;

@end
