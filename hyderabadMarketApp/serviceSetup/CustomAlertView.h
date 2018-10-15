//
//  CustomAlertView.h
//  ZaggleDemo
//
//  Created by Zaggle Prepaid Ocean Services Private Limited on 04/05/16.
//  Copyright © 2016 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Type)
{
    ImageWithSingleButtonType = 1,
    ImageWithTwoButtonsType,
    SingleButtonType,
    DoubleButtonsType
};

@protocol CustomAlertViewDelegate;

@interface CustomAlertView : UIView

@property(nonatomic) Type AlertType;
@property(nonatomic, weak) id <CustomAlertViewDelegate> delegate;

-(id)initWithAlertType:(Type)typeOfAlert andMessage:(NSString *)message andImageName:(NSString *)alertImage andCancelTitle:(NSString *)firstButtonTitle andOtherTitle:(NSString *)secondButtonTitle andDisplayOn:(UIView *)superView;

@end

@protocol CustomAlertViewDelegate <NSObject>

@required
/*!
 @abstract      custom alert
 @param         nsinteger
 @discussion    customalert delegate method
 @return        nill
 */

-(void)customAlertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

