//
//  FeedsViewController.h
//  hyderabadMarketApp
//
//  Created by ashwin challa on 10/11/18.
//  Copyright © 2018 Bharat shankar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonClassViewController.h"



@interface FeedsViewController : CommonClassViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *feedTblView;

@end

