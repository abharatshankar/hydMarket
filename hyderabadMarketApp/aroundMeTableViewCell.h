//
//  aroundMeTableViewCell.h
//  hyderabadMarketApp
//
//  Created by Bharat shankar on 12/10/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aroundMeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *merchantBannerImage;
@property (weak, nonatomic) IBOutlet UILabel *merchantName;
@property (weak, nonatomic) IBOutlet UILabel *stateNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *ratingNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *distanceLbl;

@end
