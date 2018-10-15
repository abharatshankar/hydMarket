//
//  offersTableViewCell.h
//  hyderabadMarketApp
//
//  Created by Bharat shankar on 11/10/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface offersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *offerTitle;
@property (weak, nonatomic) IBOutlet UILabel *offerPrice;
@property (weak, nonatomic) IBOutlet UILabel *discountPrice;
@property (weak, nonatomic) IBOutlet UILabel *offerPercentace;
@property (weak, nonatomic) IBOutlet UILabel *merchantName;
@property (weak, nonatomic) IBOutlet UIView *offerView;

@end
