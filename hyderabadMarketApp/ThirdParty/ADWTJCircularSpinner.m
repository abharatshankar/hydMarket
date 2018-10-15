//
//  ADWTJCircularSpinner.m
//  EmployeeServiceApp
//
//  Created by Adwitech on 19/06/14.
//  Copyright (c) 2014 Adwitech. All rights reserved.
//

/*!
 ->  ADWTJCircularSpinner used for.
 
 -> in this controller displaying loding indicator
 
 */
#import "ADWTJCircularSpinner.h"

NSString *const kTJSpinnerTypeCircular = @"TJCircularSpinner";

#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))


@implementation ADWTJCircularSpinner

//Synthesizer common for all types of spinners
//@synthesize hidesWhenStopped = _hidesWhenStopped;

@synthesize speed = _speed;

//Synthesizer specific to kTJSpinnerTypeCircular
@synthesize fillColor = _fillColor;
@synthesize pathColor = _pathColor;
@synthesize thickness = _thickness;

#pragma mark -
#pragma mark Initialization Methods

- (ADWTJCircularSpinner *)initWithSpinnerType:(NSString *) spinnerType
{
    self = [super init];
    if (self)
    {
        self = [[NSClassFromString(spinnerType) alloc]init];
       // self.hidden = _hidesWhenStopped;
    }
    return self;
}


//+ (ADWTJCircularSpinner *) spinnerWithType:(NSString *) spinnerType
//{
//    return [[[self class] alloc] initWithSpinnerType:spinnerType];
//}

#pragma mark -
#pragma mark Animation Methods
- (void) startAnimating
{
       // //@"Start Animation");
    self.hidden = NO;
    
}

- (void) stopAnimating
{
     //  //@"Stop Animation");
    //self.hidden = _hidesWhenStopped;
    self.hidden = YES;
}

//- (void)setHidesWhenStopped:(BOOL)hidesWhenAnimationStopped
//{
//    _hidesWhenStopped = hidesWhenAnimationStopped;
//    self.hidden = hidesWhenAnimationStopped;
//    [self setNeedsDisplay];
//}

@end

@interface TJCircularSpinner : ADWTJCircularSpinner
{
    CGFloat _angle;
    CGFloat _rotationAngle;
}
@end

@implementation TJCircularSpinner

#pragma mark Timer Fire methods

- (void) timerFired:(NSTimer *)timer
{
    _angle = _angle+_rotationAngle;
    if (_angle>360)
    {
        _angle = 00.00;
    }
    [self setNeedsDisplay];
    
}
#pragma mark View LifeCycle Methods


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        self.pathColor = [UIColor whiteColor];
        self.fillColor = [UIColor colorWithRed:17/255.00 green:181/255.00 blue:255.00/255.00 alpha:1.0];//Sky blue color
        _rotationAngle = 3.00; //Angle to rotate
        _angle = 180.00;
        self.radius = 5;
        self.thickness = 3.00;
        _speed = 1.50/(360/_rotationAngle);
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectZero];
}
#pragma mark View Drawing Method

- (void)drawRect:(CGRect)rect
{
    
    CGFloat startAngle;
    //    CGFloat endAngle;
    
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Draw the arc only once if it is not drawn
    CGPoint arcCenter = centerPoint;//CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    CGFloat arcRadius = self.radius+(self.thickness/2.00);
    UIBezierPath *arc = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:arcRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:NO];
    CGPathRef shape = CGPathCreateCopyByStrokingPath(arc.CGPath, NULL, self.thickness, kCGLineCapRound, kCGLineJoinRound, 0.0f);
    
    CGContextBeginPath(context);
    CGContextAddPath(context, shape);
    CGContextSetFillColorWithColor(context, self.pathColor.CGColor);
    CGContextFillPath(context);
    
    CGPathRelease(shape);
    
    startAngle = _angle;
    CGFloat currentAngle = startAngle;
    CGFloat newAlphaValue = 0.0f;
    CGFloat numberOfSteps = 360.00/_rotationAngle;
    for(float i=0;i<numberOfSteps;i++)
    {
        newAlphaValue = (newAlphaValue+(1.0/numberOfSteps));
        if (newAlphaValue>1.0)
        {
            newAlphaValue = 0.0f;
        }
        CGFloat arcEndAngle = currentAngle+_rotationAngle;
        CGFloat arStartAngle = currentAngle;
        
        CGContextAddArc(context, centerPoint.x, centerPoint.y, self.radius+(self.thickness/2.0), DEGREES_TO_RADIANS(arStartAngle), DEGREES_TO_RADIANS(arcEndAngle), 0);
        CGContextSetLineWidth(context, self.thickness);
        UIColor *newColor = nil;
        CGColorRef colorRef = CGColorCreateCopyWithAlpha(self.fillColor.CGColor, newAlphaValue);
        newColor = [UIColor colorWithCGColor:colorRef];
        CGColorRelease(colorRef);
        
        
        CGContextSetStrokeColorWithColor(context,newColor.CGColor);
        //        CGContextSetLineCap(context, kCGLineCapRound);
        if(i==numberOfSteps-1)
        {
            CGContextSetLineCap(context, kCGLineCapRound);
        }
        CGContextStrokePath(context);
        
        CGContextSetFillColorWithColor(context, newColor.CGColor);
        CGContextFillPath(context);
        
        currentAngle = currentAngle+_rotationAngle;
    }
    
}
#pragma mark - Spinner animation methods
- (void)startAnimating
{
   // //@"Start radial spinner animation");
    [super startAnimating];
    _angle = 180;
    [_animationTimer invalidate];
    _animationTimer = [NSTimer timerWithTimeInterval:_speed target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_animationTimer forMode:NSDefaultRunLoopMode];
}
- (void)stopAnimating
{
    //    //@"Stop radial spinner animation");
    [super stopAnimating];
    //Invalidate the timer to stop the animation
 
    [_animationTimer invalidate];
    _animationTimer = nil;
    _angle = 180;

    [self setNeedsDisplay];
}
- (void) setRadius:(CGFloat)radius
{
    super.radius = radius;
    CGRect newFrameRect = self.frame;
    CGFloat newHeight = self.radius*2.00+self.thickness*2.00;
    CGFloat newWidth = newHeight;
    
    if (self.frame.size.height<newHeight)
    {
        newFrameRect.size.height = newHeight;
    }
    if (self.frame.size.height<newWidth)
    {
        newFrameRect.size.width = newWidth;
    }
    self.frame = newFrameRect;
    [self setNeedsDisplay];
}

- (void) setThickness:(CGFloat)thickness
{
    super.thickness = thickness;
    
    CGRect newFrameRect = self.frame;
    CGFloat newHeight = self.radius*2.00+thickness*2.00;
    CGFloat newWidth = newHeight;
    
    if (self.frame.size.height<newHeight)
    {
        newFrameRect.size.height = newHeight;
    }
    if (self.frame.size.height<newWidth)
    {
        newFrameRect.size.width = newWidth;
        
    }
    self.frame = newFrameRect;
    
    [self setNeedsDisplay];
    
}
@end
