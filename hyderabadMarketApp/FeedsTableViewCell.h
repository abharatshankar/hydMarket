//
//  FeedsTableViewCell.h
//  hyderabadMarketApp
//
//  Created by ashwin challa on 10/11/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FeedsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bgview;

@property (strong, nonatomic) IBOutlet UIImageView *feedImgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *merchantName;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

