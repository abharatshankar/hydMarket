//
//  CustomAlertView.m
//  ZaggleDemo
//
//  Created by Zaggle Prepaid Ocean Services Private Limited on 04/05/16.
//  Copyright © 2016 . All rights reserved.
//

/*!
 ->  CustomAlertView used for.
 
 -> in this controller displaying alert popups
 
 */

#define AlertViewWidth (SCREEN_WIDTH * 87.5)/100
#define AlertViewHeight 220

#import "CustomAlertView.h"
#import "Constants.h"


@interface CustomAlertView()
{
    NSString *messageText,*imageName,*firstBtnTitle,*secondBtnTitle;
    UIImageView *alertImageView;
    UIButton *firstButton, *secondButton;
    UILabel *messageLabel;
    UIView *backGroundView;
}

@end

@implementation CustomAlertView
@synthesize AlertType;
@synthesize delegate;

-(id)initWithAlertType:(Type)typeOfAlert andMessage:(NSString *)message andImageName:(NSString *)alertImage andCancelTitle:(NSString *)firstButtonTitle andOtherTitle:(NSString *)secondButtonTitle andDisplayOn:(UIView *)superView;
{
    self = [super init];
    if (self) {
        messageText = message;
        firstBtnTitle = firstButtonTitle;
        secondBtnTitle = secondButtonTitle;
        imageName = alertImage;
        AlertType = typeOfAlert;
        [self initializeSubViews];
        
        backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        backGroundView.backgroundColor = [UIColor whiteColor];
        backGroundView.alpha = 0.7;
        [superView addSubview:backGroundView];
        //[superView addSubview:self];
    }
    return self;
}

-(void)initializeSubViews{
    messageLabel = [[UILabel alloc]init];
    CGFloat alertViewHeight = 35.0f;

    switch (AlertType) {
        case ImageWithTwoButtonsType:{
            alertViewHeight = 0.0f;
        }
            break;
            
        case ImageWithSingleButtonType :{
            
        }
            break;
            
        case SingleButtonType:{
    
        }
            break;
            
        case DoubleButtonsType:{
            alertViewHeight = 0.0f;
        }
            break;
            
        default:
            break;
    }
    
    if (imageName == nil) {
        self.frame = CGRectMake((SCREEN_WIDTH - AlertViewWidth)/2, 0, AlertViewWidth, AlertViewHeight - 70);
        messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 15, (AlertViewWidth - 60), [self labelHeight:messageText :(AlertViewWidth - 60) andFont:17])];
        
    }
    else{
        self.frame = CGRectMake((SCREEN_WIDTH - AlertViewWidth)/2, 0, AlertViewWidth, AlertViewHeight);
        alertImageView = [[UIImageView alloc]initWithFrame:CGRectMake((AlertViewWidth-35)/2, 15, 35, 35)];
        messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, (alertImageView.frame.origin.y + 35) + 10, (AlertViewWidth - 60), [self labelHeight:messageText :(AlertViewWidth - 60) andFont:17])];
    }
   // self.backgroundColor = [UIColor colorWithRed:107.0/255.0 green:201.0/255.0 blue:200.0/255.0 alpha:1];
    self.backgroundColor = REDCOLOR;
    alertImageView.image = [UIImage imageNamed:imageName];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:PROXIMANOVAREGULAR size:17];
    messageLabel.text = messageText;
    messageLabel.numberOfLines = 0;
    [self addSubview:alertImageView];
    [self addSubview:messageLabel];
    
    if (firstBtnTitle == nil && secondBtnTitle == nil) {
        firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        firstButton.frame = CGRectMake((AlertViewWidth - 100)/2, messageLabel.frame.origin.y+CGRectGetHeight(messageLabel.frame)+17, 100, 35);
        [firstButton setTitle:@"OK" forState:UIControlStateNormal];
        firstButton.tag = 0;
        [firstButton addTarget:self action:@selector(alertButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(firstBtnTitle == nil && secondBtnTitle != nil){
        firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        firstButton.frame = CGRectMake((AlertViewWidth - 100)/2, messageLabel.frame.origin.y+CGRectGetHeight(messageLabel.frame)+17, 100, 35);
        [firstButton setTitle:secondBtnTitle forState:UIControlStateNormal];
        firstButton.tag = 0;
        [firstButton addTarget:self action:@selector(alertButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (secondBtnTitle == nil && firstBtnTitle != nil){
        firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        firstButton.frame = CGRectMake((AlertViewWidth - 100)/2, messageLabel.frame.origin.y+CGRectGetHeight(messageLabel.frame)+17, 100, 35);
        [firstButton setTitle:firstBtnTitle forState:UIControlStateNormal];
        firstButton.tag = 0;
        [firstButton addTarget:self action:@selector(alertButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (firstBtnTitle != nil && secondBtnTitle != nil){
        firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        firstButton.frame = CGRectMake(30, messageLabel.frame.origin.y+CGRectGetHeight(messageLabel.frame)+15, 100, 35);
        [firstButton setTitle:firstBtnTitle forState:UIControlStateNormal];
        firstButton.tag = 0;
        [firstButton addTarget:self action:@selector(alertButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        secondButton.frame = CGRectMake(AlertViewWidth - 130, messageLabel.frame.origin.y+CGRectGetHeight(messageLabel.frame)+17, 100, 35);
        [secondButton setTitle:secondBtnTitle forState:UIControlStateNormal];
        secondButton.tag = 1;
        [secondButton addTarget:self action:@selector(alertButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //[firstButton setTitleColor:[UIColor colorWithRed:107.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1] forState:UIControlStateNormal];
    [firstButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [secondButton setTitleColor:[UIColor colorWithRed:107.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1] forState:UIControlStateNormal];
    [firstButton setBackgroundColor:[UIColor whiteColor]];
    [secondButton setBackgroundColor:[UIColor whiteColor]];
    firstButton.titleLabel.font = [UIFont fontWithName:PROXIMANOVAREGULAR size:15];
    secondButton.titleLabel.font = [UIFont fontWithName:PROXIMANOVAREGULAR size:15];
    firstButton.layer.cornerRadius = 16;
    secondButton.layer.cornerRadius = 16;
    [self addSubview:firstButton];
    [self addSubview:secondButton];
    self.layer.cornerRadius = 3.0;
    self.layer.masksToBounds = NO;
    
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.4;
    
    
    for (UIView* view in self.subviews)
    {
        alertViewHeight += view.frame.size.height+5;
    }
    
    CGRect frame = self.frame;
    frame.origin.x = (SCREEN_WIDTH - AlertViewWidth)/2;
    frame.origin.y = (SCREEN_HEIGHT - alertViewHeight)/2;
    frame.size.height = alertViewHeight;

    if([messageLabel.text isEqualToString:@"Do you really want to logout?"])
     {
         frame.size.height = alertViewHeight-30;
  
     }
    self.frame = frame;
    
}

-(void)alertButtonClicked:(UIButton *)sender
{
    [UIView animateWithDuration:0.25 animations:^{
        backGroundView.alpha = 0.0;
        self.alpha = 0.0;
    }completion:^(BOOL finished){
        [backGroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
    if([self.delegate respondsToSelector:@selector(customAlertView:clickedButtonAtIndex:)])
    {
        [self.delegate customAlertView:self clickedButtonAtIndex:sender.tag];
    }

}

-(float)labelHeight:(NSString*)text :(CGFloat)labelwidth andFont:(float)fontSize
{
    NSAttributedString *attributedText;
    CGRect rect ;
    if(text != nil){
   
        attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont fontWithName:@"helvetica" size:fontSize]}];
    
     rect = [attributedText boundingRectWithSize:(CGSize){labelwidth, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    }
    return ceil(rect.size.height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
