//
//  ADWTJCircularSpinner.h
//  EmployeeServiceApp
//
//  Created by Adwitech on 19/06/14.
//  Copyright (c) 2014 Adwitech. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kTJSpinnerTypeCircular;

@interface ADWTJCircularSpinner : UIView
{
    NSTimer *_animationTimer;
    //BOOL _hidesWhenStopped;
    double _speed;
}

@property(nonatomic,readonly,assign) BOOL isAnimating;/*Indicates whether spinner is animating or not*/
//@property(nonatomic, assign) BOOL hidesWhenStopped;/*Hides the spinner when spinner is not animating*/
@property(nonatomic,assign) double speed;/*Speed of the animation*/
@property(nonatomic,assign) CGFloat radius; /*Radius of the spinner. By deafult readius is set to 5 for kTJSpinnerTypeCircular */

@property(nonatomic,retain) UIColor *fillColor;/*Color to be used to fill the circular path. By default white is used */
@property(nonatomic,retain) UIColor *pathColor;/*Color to be set to the circular path. By default sky blue is the color of the circular path*/
@property (nonatomic, assign)CGFloat thickness;/*By default thickness is set to 3.00*/

//Spinner animation methods
/*!
 @abstract      loding indicator
 @param         nil
 @discussion    start the indicator
 @return        nill
 */

- (void)startAnimating;

/*!
 @abstract      stop indicator
 @param         nil
 @discussion    stop the indicator
 @return        nill
 */



- (void)stopAnimating;
//Spinner initialization method. It is recommended to use this method to create the spinners of your choice.
- (ADWTJCircularSpinner *)initWithSpinnerType:(NSString *) spinnerType;
//+ (ADWTJCircularSpinner *) spinnerWithType:(NSString *) spinnerType;

@end
