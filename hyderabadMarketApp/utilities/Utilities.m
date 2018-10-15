//
//  Utilities.m
//  Zaggle
//
//  Created by Zaggle Prepaid Ocean Services Private Limited on 11/05/16.
//  Copyright © 2016 Zaggle Prepaid Ocean Services Private Limited. All rights reserved.
//
/*!
 ->  Utilities used for.
 
 -> in this controller displaying all different method which or using commonly in app
 
 */

#define NoDataLabelTag 667

#import "Utilities.h"
#import "Constants.h"
#import "CustomAlertView.h"
#import "ADWTJCircularSpinner.h"
#import "Reachability.h"
#include <ifaddrs.h>
#include <arpa/inet.h>


#import <AdSupport/AdSupport.h>

#define MobileNumValidate @[@"0000000000",@"1111111111",@"2222222222",@"3333333333",@"4444444444",@"5555555555",@"6666666666",@"7777777777",@"8888888888",@"9999999999",@"0123456789",@"1234567890"]


NSMutableDictionary * globalDictionary;
NSMutableArray *cartArray;
NSUInteger totalZaggleCash = 1500;
NSUInteger totalZaggleCardCash = 800;
NSUInteger totalCartCount = 0;
NSDictionary *orderDictionary;
NSMutableArray *paymentsListArray;
NSDictionary *promocodeDictionary;
NSDictionary *tempOrderDictionary;

int peopletotalvalue ,slideminvalue;
NSMutableArray *paymentTransactionsArray;

@implementation Utilities

+ (ADWTJCircularSpinner *) sharedInstance
{
    static ADWTJCircularSpinner *_sharedInstance = nil;
    if (!_sharedInstance) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _sharedInstance = [[ADWTJCircularSpinner alloc] initWithSpinnerType:kTJSpinnerTypeCircular];
            //NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"first" withExtension:@"gif"];
            
        });
    }
    return _sharedInstance;
}
+(Utilities*)sharedManager
{
    static Utilities *sharedMyManager = nil;
    
    @synchronized(self) {
        if (sharedMyManager == nil)
        {
            sharedMyManager = [[self alloc] init];
        }
    }
    return sharedMyManager;
}
- (CGRect)screenRect
{
    return [[UIScreen mainScreen] bounds];
}
+ (CAShapeLayer *)customToggleButton
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(40, 40)];
    [path addLineToPoint:CGPointMake(60.0, 40.0)];
    [path moveToPoint:CGPointMake(40, 46)];
    [path addLineToPoint:CGPointMake(60.0, 46)];
    [path moveToPoint:CGPointMake(40, 52)];
    [path addLineToPoint:CGPointMake(60.0, 52)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.8;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    
    layer.position = CGPointMake(8, 18);
    return layer;
    
}

+(void)propblemForRemove
{
    [USERDEFAULTS removeObjectForKey:@"FilterCall"];
    [USERDEFAULTS removeObjectForKey:@"FilterAction"];
    [USERDEFAULTS removeObjectForKey:@"FilterClicked"];
    [USERDEFAULTS removeObjectForKey:@"OfferCAmpaingsServiceCall"];
    
   
    [USERDEFAULTS removeObjectForKey:@"GroupDealSelectionClicked"];
    [USERDEFAULTS removeObjectForKey:@"GroupDealClicked"];
    [USERDEFAULTS removeObjectForKey:@"CashBackSelected"];
    [USERDEFAULTS setBool:YES forKey:@"SortClicked"];
    
    [USERDEFAULTS removeObjectForKey:@"CashBackSelected"];
}
+(NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

+(NSDictionary*)savePlistUsingDictonary :(NSDictionary*)dataDict
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"myPlistFile.plist"];
    //    if (![[NSFileManager defaultManager] fileExistsAtPath: plistPath])
    //    {
    //        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"myPlistFile" ofType:@"plist"];
    //        [[NSFileManager defaultManager] copyItemAtPath:bundle toPath:plistPath error:&error];
    //    }
    [dataDict writeToFile:plistPath atomically: YES];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Success",@"savedData", nil];
}
+(NSDictionary*)gettingPlistUsingDictonary {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"myPlistFile.plist"];
    
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
}


+(NSDictionary*)saveLocationsPlistUsingDictonary :(NSDictionary*)dataDict
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"FilterLocations.plist"];
    //    if (![[NSFileManager defaultManager] fileExistsAtPath: plistPath])
    //    {
    //        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"myPlistFile" ofType:@"plist"];
    //        [[NSFileManager defaultManager] copyItemAtPath:bundle toPath:plistPath error:&error];
    //    }
    [dataDict writeToFile:plistPath atomically: YES];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Success",@"savedData", nil];
}

+(NSDictionary*)saveDealTypesPlistUsingDictonary :(NSDictionary*)dataDict
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"FilterDealTypes.plist"];
    //    if (![[NSFileManager defaultManager] fileExistsAtPath: plistPath])
    //    {
    //        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"myPlistFile" ofType:@"plist"];
    //        [[NSFileManager defaultManager] copyItemAtPath:bundle toPath:plistPath error:&error];
    //    }
    [dataDict writeToFile:plistPath atomically: YES];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Success",@"savedData", nil];
}

+(NSDictionary*)saveCusinesPlistUsingDictonary :(NSDictionary*)dataDict
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"FilterCusines.plist"];
    //    if (![[NSFileManager defaultManager] fileExistsAtPath: plistPath])
    //    {
    //        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"myPlistFile" ofType:@"plist"];
    //        [[NSFileManager defaultManager] copyItemAtPath:bundle toPath:plistPath error:&error];
    //    }
    [dataDict writeToFile:plistPath atomically: YES];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Success",@"savedData", nil];
}

+(NSDictionary*)saveCategoriesPlistUsingDictonary :(NSDictionary*)dataDict
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"FilterCategories.plist"];
    //    if (![[NSFileManager defaultManager] fileExistsAtPath: plistPath])
    //    {
    //        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"myPlistFile" ofType:@"plist"];
    //        [[NSFileManager defaultManager] copyItemAtPath:bundle toPath:plistPath error:&error];
    //    }
    [dataDict writeToFile:plistPath atomically: YES];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Success",@"savedData", nil];
}
+(NSArray*)filterArrayMethod : (NSMutableArray*)mainArr
{
    NSMutableArray *finalArray = [NSMutableArray array];
    NSMutableSet *mainSet = [NSMutableSet set];
    for (NSDictionary *item in mainArr) {
        //Extract the part of the dictionary that you want to be unique:
        NSDictionary *dict = [item dictionaryWithValuesForKeys:@[@"id"]];
        if ([mainSet containsObject:dict]) {
            continue;
        }
        [mainSet addObject:dict];
        [finalArray addObject:item];
    }
    
    return finalArray;
}
+ (void)callWithString:(NSString *)phoneString
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:phoneString];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];}
+ (void)callWithURL:(NSURL *)url
{
    static UIWebView *webView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webView = [UIWebView new];
    });
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}
+(void)addShadowtoButton :(UIButton*)senderBtn
{
    senderBtn.layer.shadowOffset = CGSizeMake(3, 3);
    senderBtn.layer.shadowRadius = 5.0;
    senderBtn.layer.shadowColor = LIGHTGRYCOLOR.CGColor;
    senderBtn.layer.shadowOpacity = 4.4;
    senderBtn.layer.masksToBounds = NO;
    
    
}
+(void)addShadowtoButtoncolor: (UIButton *)button :(NSString*)colorString
{
    button.layer.shadowOffset = CGSizeMake(3, 3);
    button.layer.shadowRadius = 5.0;
    button.layer.shadowColor = WHITECOLOR.CGColor;
    button.layer.shadowOpacity = 4.4;
    button.layer.masksToBounds = NO;
    
    
}
+(void)addShadowtoView1 :(UIView*)senderView :(NSString*)colorName
{
    if([colorName isEqualToString:@"side"])
    {
        senderView.layer.shadowColor = WHITECOLOR.CGColor;
        
    }
    else{
        senderView.layer.shadowColor = WHITECOLOR.CGColor;
        
    }
    senderView.layer.shadowOffset = CGSizeMake(3, 3);
    senderView.layer.shadowRadius = 5.0;
    senderView.layer.shadowOpacity = 0.4;
    senderView.layer.masksToBounds = NO;
    
    
}
+(void)addShadowtoView :(UIView*)senderView
{
    senderView.layer.shadowOffset = CGSizeMake(3, 3);
    senderView.layer.shadowRadius = 5.0;
    senderView.layer.shadowColor = LIGHTGRYCOLOR.CGColor;
    senderView.layer.shadowOpacity = 4.4;
    senderView.layer.masksToBounds = NO;
    
    
}
+(void)addShadowtoImage:(UIImageView*)senderimageview
{
    [senderimageview.layer setShadowColor:LIGHTGRYCOLOR.CGColor];
    [senderimageview.layer setShadowOpacity:0.6];
    [senderimageview.layer setShadowRadius:3.0];
    [senderimageview.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
}

+(void)addShadowtoImagea:(UIImageView*)senderimageview :(NSString*)ColorString
{
    [senderimageview.layer setShadowColor:WHITECOLOR.CGColor];
    [senderimageview.layer setShadowOpacity:0.6];
    [senderimageview.layer setShadowRadius:3.0];
    [senderimageview.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
}

+(void)animationParticularImageBlinking:(UIImageView*)blinkingImageView :(NSInteger)repetCountValue
{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=1.0;
    if(repetCountValue==0)
    {
        theAnimation.repeatCount = HUGE_VALF;
    }
    else
    {
        theAnimation.repeatCount=repetCountValue;
    }
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.0];
    [blinkingImageView.layer addAnimation:theAnimation forKey:@"animateOpacity"];
}
+(void)animationZoomZoomOutBtn : (UIButton*)button : (NSInteger)intvalueFOrRepet
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = .5;
    pulseAnimation.toValue = [NSNumber numberWithFloat:1.1];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = intvalueFOrRepet;
    [button.layer addAnimation:pulseAnimation forKey:nil];
}


+(NSDictionary*)saveCustomDealVenutypesPlistUsingDictonary :(NSDictionary*)dataDict
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"CustomDealVenues.plist"];
    //    if (![[NSFileManager defaultManager] fileExistsAtPath: plistPath])
    //    {
    //        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"myPlistFile" ofType:@"plist"];
    //        [[NSFileManager defaultManager] copyItemAtPath:bundle toPath:plistPath error:&error];
    //    }
    [dataDict writeToFile:plistPath atomically: YES];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Success",@"savedData", nil];
}
+(BOOL)convertStringToArray : (NSString *)sendingString :(NSString*)singleString
{
    
    NSArray *resultArray = [sendingString componentsSeparatedByString:@","];
    
    BOOL identicalStringFound = NO;
    for (int i =0 ;i < [resultArray count];i++)
    {
        NSString *currentString = [resultArray objectAtIndex:i];
        NSLog(@"CompareStrings =%@%@",currentString,singleString);
        singleString = [singleString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        currentString = [currentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        
        
        
        if([currentString isEqualToString:singleString])
        {
            identicalStringFound = YES;
            break;
        }
        else if (currentString == singleString)
        {
            identicalStringFound = YES;
            break;
        }
    }
    
    
    return identicalStringFound;
}
+(NSDictionary*)saveMainCitiesPlistUsingDictonary :(NSDictionary*)dataDict
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"MainCities.plist"];
    
    [dataDict writeToFile:plistPath atomically: YES];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Success",@"savedData", nil];
}
+(NSString*)appendStringToanotherString :(NSString*)currentString :(NSString*)sendingString
{
    NSString *mutableString = [[NSString alloc] init];
    mutableString =  currentString;
    if([[Utilities null_ValidationString:currentString] length]>0)
    {
        if(![self convertStringToArray:currentString :sendingString])
        {
            mutableString = [NSString stringWithFormat:@"%@ , %@",currentString,sendingString];
        }
    }
    else{
        mutableString =  sendingString;
        
    }
    
    return mutableString;
    
}
+(NSString*)OpenRestaurantBetweenTheseTimes : (NSString*)SelectedTime
{
    NSString *openTime = [NSString stringWithFormat:@"%@",[USERDEFAULTS valueForKey:@"OpenRestaruntTime"]];
    
    NSString *closeTime = [NSString stringWithFormat:@"%@",[USERDEFAULTS valueForKey:@"CloseRestaruntTime"]];
    
    
    
    
    
    NSString *startTimeString = openTime;
    NSString *endTimeString = closeTime;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    
    
    
    if([endTimeString isEqualToString:@"12:00 AM"])
    {
        endTimeString = @"11:49 PM";
    }
    
    NSString *nowTimeString = SelectedTime;//[formatter stringFromDate:[NSDate date]];
    
    int startTime   = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
    int endTime  = [self minutesSinceMidnight:[formatter dateFromString:endTimeString]];
    int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:nowTimeString]];;
    
    NSString *sendingFinalStr;
    if (startTime <= nowTime && nowTime <= endTime)
    {
        sendingFinalStr = @"Yes";
        NSLog(@"Time is between");
    }
    else {
        sendingFinalStr = @"No";
        
        NSLog(@"Time is not between");
    }
    return sendingFinalStr;
}
+(NSString *)percentEscapeString:(NSString *)string
{
    NSString *result = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, (CFStringRef)@" ", (CFStringRef)@":/?@!$&'()*+,;=", kCFStringEncodingUTF8));
    
    return [result stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}
+(int) minutesSinceMidnight:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    return 60 * (int)[components hour] + (int)[components minute];
}
+ (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));

    return size.height;
}

+(NSDictionary*)gettingPlistUsingDictonaryCustomDealVenutypes{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"CustomDealVenues.plist"];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
}

+(NSDictionary*)gettingPlistUsingDictonaryLocations{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"FilterLocations.plist"];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
}

+(NSDictionary*)gettingPlistUsingDictonaryDeals {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"FilterDealTypes.plist"];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
}


+(NSDictionary*)gettingPlistUsingDictonaryCusines {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"FilterCusines.plist"];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
}
+(NSDictionary*)gettingPlistUsingDictonaryCategories {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"FilterCategories.plist"];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
}
+(NSDictionary*)gettingPlistMainCitiesPlistUsingDictonary{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"MainCities.plist"];
    
    //@"%@",[NSMutableDictionary dictionaryWithContentsOfFile:plistPath]);
    
    return [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
}
+(NSData *)compressingImageData :(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return imageData;
}
+(NSAttributedString*)offersDetailWithImag :(NSString*)textData
{
    NSTextAttachment *attachment2 = [[NSTextAttachment alloc] init];
    attachment2.image = [UIImage imageNamed:@"icon-offer-2.png"];
    CGFloat offsetY2 = -5;
    attachment2.bounds = CGRectMake(0, offsetY2, attachment2.image.size.width, attachment2.image.size.height);
    NSAttributedString *attachmentString2 = [NSAttributedString attributedStringWithAttachment:attachment2];
    NSMutableAttributedString *myString2= [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *myString12= [[NSMutableAttributedString alloc] initWithString: textData];
    
    [myString2 appendAttributedString:attachmentString2];
    [myString2 appendAttributedString:myString12];
    //    cell.offerDescLbl.textAlignment=NSTextAlignmentLeft;
    //    cell.offerDescLbl.attributedText=myString2;
    
    return myString2;
    
}
+(NSData *)ChatImagecompressingImageData :(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 400;
    float maxWidth = 300;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.1;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return imageData;
}

//+(CustomImageShow *)addCustomLoadViewOn:(UIView *)superView
//{
//    
//    UINib *nib;
//    
//    nib = [UINib nibWithNibName:@"CustomImageShow" bundle:nil];
//    
//    CustomImageShow *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
//    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
//    
//    view.detailImageView.contentMode        =    UIViewContentModeScaleAspectFill;
//    view.detailImageView.clipsToBounds = YES;
//    
//    [superView addSubview:view];
//    return view;
//}
+(NSArray*)sortingAnArray :(NSArray*)sortArr :(NSString*)keyVAlueStr
{
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:keyVAlueStr  ascending:YES];
    //                NSSortDescriptor *givenDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lname"  ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    
    NSArray *ordered = [sortArr sortedArrayUsingDescriptors:sortDescriptors];
    
    
    return ordered;
}
+(NSArray*)sortingAnArrayDescending :(NSArray*)sortArr :(NSString*)keyVAlueStr
{
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:keyVAlueStr  ascending:NO];
    //                NSSortDescriptor *givenDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lname"  ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    
    NSArray *ordered = [sortArr sortedArrayUsingDescriptors:sortDescriptors];
    
    
    return ordered;
}

+(NSString*)convertJsonString : (NSArray*)dataArray
{
    NSData *jsonDataFilters = [NSJSONSerialization dataWithJSONObject:dataArray options:0 error:nil];
    NSString  *  filtersStr = [[NSString alloc] initWithData:jsonDataFilters encoding:NSUTF8StringEncoding];
    filtersStr = [filtersStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return filtersStr;
}
+(NSString *)convertDateFormatString:(NSString *)dateValueSTR
{
    NSDate *myDate;
    NSDateFormatter *out_df;
    //The input
    NSString *myDateAsAStringValue = dateValueSTR;
    //create the formatter for parsing
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"MMM-dd-yyyy"];
     [df setDateFormat:@"MMM d, yyyy"];
    
    //parsing the string and converting it to NSDate
    myDate = [df dateFromString: myDateAsAStringValue];
    //create the formatter for the output
    out_df = [[NSDateFormatter alloc] init];
    //  [out_df setDateFormat:@"hh:mm a, dd MMM yyyy"];
    
    [out_df setDateFormat:@"MM/dd/yyyy"];
    NSString *changedScheduledTime = [NSString stringWithFormat:@"%@",[[out_df stringFromDate:myDate] uppercaseString]];
    return changedScheduledTime;
}


+(NSString *)gettingCurrentDate
{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSString *sendingTime =[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    [USERDEFAULTS removeObjectForKey:@"SeningServerDate"];
    [USERDEFAULTS setValue:sendingTime forKey:@"SeningServerDate"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd MMM yyyy"];
    
    NSString *curretnDate =[NSString stringWithFormat:@"%@",[df stringFromDate:[NSDate date]]];
    return curretnDate;
    
}

//helper method for color hex values
+ (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

//helper method for color hex values
+ (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}


+(NSString *)gettingCurrentTime
{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    //@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    NSString *sendingTime =[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    [USERDEFAULTS removeObjectForKey:@"SeningServerTime"];
    [USERDEFAULTS setValue:sendingTime forKey:@"SeningServerTime"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"hh:mm a"];
    
    NSString *curretnTime =[NSString stringWithFormat:@"%@",[df stringFromDate:[NSDate date]]];
    
    
    return curretnTime;
}
+(NSString*)null_ValidationString :(NSString *)checkstring
{
    if (checkstring == nil || checkstring == ((id)[NSNull null]) ||  [checkstring isEqualToString:@"(null)"] || checkstring.length == 0 || [checkstring isEqualToString:@"<null>"])
    {
        checkstring = @"";
    }
    
    
    return checkstring;
}
+(NSString*)trimBlankCharactersFromBeginningOfString:(NSString*)originalString
{
    //we are only trimming the characters on the left side of the string
    NSInteger count = [originalString length];
    NSString *trimmedNewText = originalString;
    for (int i = 0; i < count; i++) {
        if([[originalString substringWithRange:NSMakeRange(i, 1)] rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]].location == NSNotFound)
        {
            trimmedNewText = [originalString substringFromIndex:i];
            break;
        }
        else
        {
            if(i+1 < count)
            {
                trimmedNewText = [originalString substringFromIndex:i+1];
            }
            //since we are exiting the loop as soon as a non blank space character is found
            //then this is just really checking to see if we are on the last character of an
            //all whitespace string. can't say i+1 here because that would give an index out
            //of bound exception
            else
            {
                trimmedNewText = @"";
            }
        }
    }
    return trimmedNewText;
}


+(void)circleImage :(UIView*)imageViewCurrent
{
    float height = MAX(imageViewCurrent.frame.size.width, imageViewCurrent.frame.size.height);
    CGRect frame = imageViewCurrent.frame;
    // frame.origin.x = (SCREEN_WIDTH-height)/2;
    frame.size.width = height;
    frame.size.height = height;
    imageViewCurrent.frame = frame;
    imageViewCurrent.layer.cornerRadius = height/2;
    imageViewCurrent.layer.masksToBounds = YES;
    imageViewCurrent.clipsToBounds = YES;
    imageViewCurrent.layer.borderColor = GRAYBUTTONBGCOLOR.CGColor;
    
    /*
     imageViewCurrent.layer.borderWidth = 1;
     imageViewCurrent.layer.borderColor = WHITECOLOR.CGColor;
     imageViewCurrent.layer.cornerRadius = imageViewCurrent.frame.size.width / 2;
     imageViewCurrent.clipsToBounds = true;
     */
    
}
+(void)editProfilecircleImage :(UIImageView*)imageViewCurrent
{
    float height = MAX(imageViewCurrent.frame.size.width, imageViewCurrent.frame.size.height);
    CGRect frame = imageViewCurrent.frame;
    frame.origin.x = (SCREEN_WIDTH-height)/2;
    frame.size.width = height;
    frame.size.height = height;
    imageViewCurrent.frame = frame;
    imageViewCurrent.layer.cornerRadius = height/2;
    imageViewCurrent.layer.masksToBounds = YES;
    imageViewCurrent.clipsToBounds = YES;
    imageViewCurrent.layer.borderColor = GRAYBUTTONBGCOLOR.CGColor;
    
    /*
     imageViewCurrent.layer.borderWidth = 1;
     imageViewCurrent.layer.borderColor = WHITECOLOR.CGColor;
     imageViewCurrent.layer.cornerRadius = imageViewCurrent.frame.size.width / 2;
     imageViewCurrent.clipsToBounds = true;
     */
    
}
-(NSString*)convertingArraytoString :(NSString*)data
{
    NSString *resultMessage = data;
    
    NSData *jsonData = [resultMessage dataUsingEncoding:NSUTF8StringEncoding];
    
    // you can skip this step by just using the NSData that you get from the http request instead of converting it to a string.
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:nil];
    //@"%@", jsonObject);
    NSMutableString * result = [[NSMutableString alloc] init];
    for (NSObject * obj in jsonObject)
    {
        [result appendString:[obj description]];
        [result appendString:@" ,"];
        
    }
    NSString  *food = [result substringToIndex:[result length] - 1];
    return food;
}

+(float)lablewidth:(NSString*)text andFontSize:(CGFloat)size andFont:(NSString *)font

{
    CGSize fontSize = [text sizeWithAttributes:
                       @{NSFontAttributeName:
                             [UIFont fontWithName:font size:size]}];
    return fontSize.width;
}

+(float)reviewLableHeiight:(NSString*)text :(NSString*)fontName :(float)fontSize
{
    CGSize fontSize1 = [text sizeWithAttributes:
                        @{NSFontAttributeName:
                              [UIFont fontWithName:fontName size:fontSize]}];
    return fontSize1.height;
}

+(float)commentlableHeiight:(NSString*)text

{
    CGSize fontSize = [text sizeWithAttributes:
                       @{NSFontAttributeName:
                             [UIFont fontWithName:PROXIMANOVAREGULAR size:20]}];
    return fontSize.height;
}
+(float)lableHeight:(NSString*)text andFontSize:(CGFloat)size andFont:(NSString *)font andWidth:(CGFloat)labelwidth
{
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont fontWithName:font size:size]}];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){labelwidth, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    return ceil(rect.size.height);
}


+(NSString *)dateTochangeFormate:(NSString *)dateStr {
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"dd MM yyyy"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    
    return convertedString;
    
    
}


+(NSString *)dateTochangeSlashNotifications:(NSString *)dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //// here set format of date which is in your output date (means above str with format)
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init] ;
    [dateFormatter1 setDateFormat:@"dd/MM/yyyy"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter1 stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    return convertedString;
    
    
}
+(NSString *)dateTochangeSlashDOB:(NSString *)dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"]; //// here set format of date which is in your output date (means above str with format)
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init] ;
    [dateFormatter1 setDateFormat:@"dd/MM/yyyy"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter1 stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    return convertedString;
    
    
}


+(NSString *)dateTochangeComareCheck:(NSString *)dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"]; //// here set format of date which is in your output date (means above str with format)
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init] ;
    [dateFormatter1 setDateFormat:@"dd MM yyyy"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter1 stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    return convertedString;
    
    
}



+(NSString *)dateTochangeServerFormate:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    
    return convertedString;
}
+(NSString *)dateTochangeServerFormateToDisplay:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    // here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    
    return convertedString;
}

+(NSString *)dateTochangeFormateToDate:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd MMM yyyy"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    
    return convertedString;
}
+(NSString *)dateTochangeFormateToTime:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"hh:mm a"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    
    return convertedString;
}


// save values/////

+(void)SaveAuthKey:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveAuthKey"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getAuthKey{
    return [USERDEFAULTS objectForKey:@"SaveAuthKey"];
}

+(void)SaveUserID:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveUserID"];
    [USERDEFAULTS synchronize];
}
//+(void)saveUserId :(NSString *)user_id{
//    [USERDEFAULTS setObject:user_id forKey:@"UserId"];
//    [USERDEFAULTS synchronize];
//}
+(NSString *)getUserID
{
    return [USERDEFAULTS objectForKey:@"SaveUserID"];
}



+(void)SaveUserType:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"user_type"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getUserType{
    return [USERDEFAULTS objectForKey:@"user_type"];
}
+(void)SaveTax:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveTax"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getTax{
    return [USERDEFAULTS objectForKey:@"SaveTax"];
}
+(void)SaveOpentime:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveOpentime"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getopenTime
{
    return [USERDEFAULTS objectForKey:@"SaveOpentime"];
}
+(void)SaveCloseTime:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveCloseTime"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getCloseTime
{
    return [USERDEFAULTS objectForKey:@"SaveCloseTime"];
}
+(void)Savedelivery_slot_duration:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"delivery_slot_duration"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getdelivery_slot_duration
{
    return [USERDEFAULTS objectForKey:@"delivery_slot_duration"];
}
+(void)SaveGranTotal:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveGranTotal"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getSaveGranTotal
{
    return [USERDEFAULTS objectForKey:@"SaveGranTotal"];
}
+(void)SaveDeliveryTime:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveDeliveryTime"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getDeliveryTime
{
    return [USERDEFAULTS objectForKey:@"SaveDeliveryTime"];
}


/******************************/
+(BOOL)isInternetConnectionExists
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    [Reachability reachabilityWithHostName:@"www.apple.com"];    // set your host name here
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}
+(UITextField*) setBorderTextFieldWithColorPass: (UITextField*)textField :(float)cornerRadiseValue : (UIColor*)color
{
    [[textField layer] setCornerRadius:cornerRadiseValue];
    [[textField layer] setMasksToBounds:YES];
    textField.layer.borderColor = color.CGColor;
    textField.layer.borderWidth = 1.0;
    return  textField;
}
+(UITextField*) setBorderTextField: (UITextField*)textField :(float)cornerRadiseValue
{
    [[textField layer] setCornerRadius:cornerRadiseValue];
    [[textField layer] setMasksToBounds:YES];
    textField.layer.borderColor = LIGHTGRYCOLOR.CGColor;
    textField.layer.borderWidth = 1.0;
    return  textField;
}
+(UIView*) setBorderView: (UIView*)viewOfCurrent :(float)cornerRadiseValue :(UIColor*)color
{
    [[viewOfCurrent layer] setCornerRadius:cornerRadiseValue];
    [[viewOfCurrent layer] setMasksToBounds:YES];
    viewOfCurrent.layer.borderColor = color.CGColor;
    viewOfCurrent.layer.borderWidth = 1.0;
    return  viewOfCurrent;
}

+(UIView*) setBorderViewLessAlpha: (UIView*)viewOfCurrent :(float)cornerRadiseValue :(UIColor*)color
{
    [[viewOfCurrent layer] setCornerRadius:cornerRadiseValue];
    [[viewOfCurrent layer] setMasksToBounds:YES];
    viewOfCurrent.layer.borderColor = color.CGColor;
    viewOfCurrent.layer.borderWidth = 0.4;
    return  viewOfCurrent;
}

+(void)displayCustemAlertViewCAll :(NSString*)message :(UIView*)currentView
{
    CustomAlertView *alert = [[CustomAlertView alloc]initWithAlertType:ImageWithSingleButtonType andMessage:message andImageName:CallImage andCancelTitle:nil andOtherTitle:@"OK" andDisplayOn:currentView];
    [currentView addSubview:alert];
    
}
+(void)displayCustemAlertViewWithimage :(NSString*)message :(UIView*)currentView :(NSString*)imagename
{
    CustomAlertView *alert = [[CustomAlertView alloc]initWithAlertType:ImageWithSingleButtonType andMessage:message andImageName:imagename andCancelTitle:nil andOtherTitle:@"OK" andDisplayOn:currentView];
    [currentView addSubview:alert];
    
}
+(void)displayCustemAlertViewWithOutImage :(NSString*)message :(UIView*)currentView
{
    CustomAlertView *alert = [[CustomAlertView alloc]initWithAlertType:ImageWithSingleButtonType andMessage:message andImageName:nil andCancelTitle:nil andOtherTitle:@"OK" andDisplayOn:currentView];
    [currentView addSubview:alert];
    
}
+(void)displayCustemAlertView :(NSString*)message :(UIView*)currentView
{
    CustomAlertView *alert = [[CustomAlertView alloc]initWithAlertType:ImageWithSingleButtonType andMessage:message andImageName:AlertVpanicImage andCancelTitle:nil andOtherTitle:@"OK" andDisplayOn:currentView];
    [currentView addSubview:alert];
    
}
//image name chage
+(void)displayCustemAlertView :(NSString*)message :(UIView*)currentView :(NSString*)imageName
{
    CustomAlertView *alert = [[CustomAlertView alloc]initWithAlertType:ImageWithSingleButtonType andMessage:message andImageName:imageName andCancelTitle:nil andOtherTitle:@"OK" andDisplayOn:currentView];
    [currentView addSubview:alert];
    
}

+(void)displayCustemAlertView2Buttons :(NSString*)message :(UIView*)currentView
{
    CustomAlertView *alert = [[CustomAlertView alloc]initWithAlertType:ImageWithSingleButtonType andMessage:message andImageName:AlertVpanicImage andCancelTitle:@"Login" andOtherTitle:@"Contact us" andDisplayOn:currentView];
    [currentView addSubview:alert];
    
}
+(UIButton*) setBorderBtn: (UIButton*)currentBtn :(float)cornerRadiseValue :(UIColor*)color
{
    [[currentBtn layer] setCornerRadius:cornerRadiseValue];
    [[currentBtn layer] setMasksToBounds:YES];
    currentBtn.layer.borderColor = color.CGColor;
    currentBtn.layer.borderWidth = 1.0;
    return  currentBtn;
}
+(UIImageView*) setBorderImage: (UIView*)currentImageView :(float)cornerRadiseValue
{
    [[currentImageView layer] setCornerRadius:cornerRadiseValue];
    [[currentImageView layer] setMasksToBounds:YES];
    currentImageView.layer.borderColor = CLEARCOLOR.CGColor;
    currentImageView.layer.borderWidth = cornerRadiseValue;
    currentImageView.layer.cornerRadius = 5;
    
    return  currentImageView;
}
+ (void) savelatitude:(NSString *)latitude and:(NSString *)longitude{
    if(![latitude isEqualToString:@"0.000000"] || ![longitude isEqualToString:@"0.000000"])
    {
        
        [USERDEFAULTS setObject:latitude forKey:@"latitude"];
        [USERDEFAULTS setObject:longitude forKey:@"longitude"];
        
        [USERDEFAULTS synchronize];
    }
}
+(UITextField*) setPaddingTextField: (UITextField*)textField
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

+(BOOL)emailCredibility:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(NSString*)gettingNumberString :(int)value
{
    //    int someInt = [value intValue];
    NSString *numberWord;
    
    NSNumber *numberValue = [NSNumber numberWithInt:value];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    numberWord = [numberFormatter stringFromNumber:numberValue];
    return numberWord;
}


+(NSAttributedString *)insertZImageInLabelAtLastPosition:(UILabel *)label withImageName:(NSString *)imageName withFont:(UIFont *)font andTextColor:(UIColor *)textColor and:(NSString *)text andAlignment:(NSTextAlignment)alignment :(int )width :(int)height

{    if([[Utilities null_ValidationString:text]length ]>0){
    
    
    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",text] attributes:@{ NSFontAttributeName : font ,NSForegroundColorAttributeName : textColor}];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    attachment.image = image;
    
    attachment.bounds = CGRectMake(0, 0, width, height);
    
    int mid = font.descender + font.capHeight;
    
    attachment.bounds = CGRectIntegral(CGRectMake(0, font.descender - width / 2 + mid + 2,  width, height));
    
    
    
    NSMutableAttributedString *attachmentString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
    [myString appendAttributedString:attachmentString];
    
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setAlignment:alignment];
    
    [myString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [myString length])];
    
    
    
    return myString;
}
    return [NSAttributedString new];
}
+(NSAttributedString *)insertZImageInLabelAtLastPosition:(UILabel *)label withImageName:(NSString *)imageName withFont:(UIFont *)font andTextColor:(UIColor *)textColor and:(NSString *)text andAlignment:(NSTextAlignment)alignment

{
    if([[Utilities null_ValidationString:text]length ]>0){
        
        NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",text] attributes:@{ NSFontAttributeName : font ,NSForegroundColorAttributeName : textColor}];
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        
        UIImage *image = [UIImage imageNamed:imageName];
        
        attachment.image = image;
        
        attachment.bounds = CGRectMake(0, 0, 13, 13);
        
        int mid = font.descender + font.capHeight;
        
        attachment.bounds = CGRectIntegral(CGRectMake(0, font.descender - 13 / 2 + mid + 2,  13, 13));
        
        
        
        NSMutableAttributedString *attachmentString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
        
        [myString appendAttributedString:attachmentString];
        
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setAlignment:alignment];
        
        [myString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [myString length])];
        
        
        
        return myString;
    }
    return [NSAttributedString new];
}


+(NSAttributedString *)insertZImageInLabelAtLastPositionLeft:(UILabel *)label withImageName:(NSString *)imageName withFont:(UIFont *)font andTextColor:(UIColor *)textColor and:(NSString *)text andAlignment:(NSTextAlignment)alignment : (NSString *)classType

{
    //Token token=591c72cd0aed8f214c55ffd4e2ac2141;device_id=543D4C2D-7BED-4B9A-9D72-B9E26875A922
    //
    
    if([[Utilities null_ValidationString:text]length ]>0){
        NSMutableAttributedString *myString;
        if([classType isEqualToString:@"ChangeBooking"])
        {
            myString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ ",text] attributes:@{ NSFontAttributeName : font ,NSForegroundColorAttributeName : textColor}];
            
        }
        else {
            if([imageName isEqualToString:@"star-ligth.png"]||[imageName isEqualToString:@"orange-star.png"]||[imageName isEqualToString:@"deal-active-full.png"] ||[imageName isEqualToString:@"192-pencil-icon.png"]  ||[imageName isEqualToString:@"192-star-icon.png"]  )
            {
                myString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",text] attributes:@{ NSFontAttributeName : font ,NSForegroundColorAttributeName : textColor}];
                
            }
            
            else if ([imageName isEqualToString:@"trophy-outline.png"]){
                myString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",text] attributes:@{ NSFontAttributeName : font ,NSForegroundColorAttributeName : textColor}];
                
            }
            
            else{
                myString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"   %@ ",text] attributes:@{ NSFontAttributeName : font ,NSForegroundColorAttributeName : textColor}];
                
            }
        }
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        
        UIImage *image = [UIImage imageNamed:imageName];
        
        attachment.image = image;
        if([imageName isEqualToString:@"star-ligth.png"]||[imageName isEqualToString:@"orange-star.png"]||[imageName isEqualToString:@"deal-active-full.png"]  )
        {
            attachment.bounds = CGRectMake(0, 0, 18, 18);
            
            int mid = font.descender + font.capHeight;
            
            attachment.bounds = CGRectIntegral(CGRectMake(0, font.descender - 18 / 2 + mid + 2,  18, 18));
        }
        else if ([imageName isEqualToString:@"trophy-outline.png"])
        {
            attachment.bounds = CGRectMake(0, 10, 22, 31);
            
            int mid = font.descender + font.capHeight;
            
            attachment.bounds = CGRectIntegral(CGRectMake(0, font.descender - 32 / 2 + mid ,  22, 31));
        }
        else{
            attachment.bounds = CGRectMake(0, 0, 20, 20);
            
            int mid = font.descender + font.capHeight;
            
            attachment.bounds = CGRectIntegral(CGRectMake(0, font.descender - 20 / 2 + mid + 2,  20, 20));
        }
        
        
        
        NSMutableAttributedString *attachmentStringfinal = [[NSMutableAttributedString alloc] init];
        NSMutableAttributedString *attachmentString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
        
        
        [attachmentStringfinal appendAttributedString:attachmentString];
        [attachmentStringfinal appendAttributedString:myString];
        
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setAlignment:alignment];
        
        [attachmentStringfinal addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attachmentStringfinal length])];
        
        
        
        return attachmentStringfinal;
    }
    return [NSAttributedString new];
}

+(NSString*)roundtheValue : (NSString*)roundedString
{
    float roundedValue;
    //    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    //    if ([roundedString rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    //    {
    roundedValue = round(2.0f * [roundedString floatValue]) / 2.0f;
    //    }
    //    else{
    //         roundedValue = round(2.0f * [[Utilities null_ValidationString:roundedString] floatValue]) / 2.0f;
    //
    //    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];
    
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
    return numberString;
    
}
+(void) removeaAllUseerDefaults
{
    NSString *lat =[USERDEFAULTS valueForKey:@"latitude"];
    NSString *longitd =[USERDEFAULTS valueForKey:@"longitude"];
  
    
    NSString *deviceToken = [USERDEFAULTS valueForKey:@"devicetoken"];
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    [USERDEFAULTS setValue:deviceToken forKey:@"devicetoken"];
    [USERDEFAULTS setBool:YES forKey:@"SlideSeen"];
    [USERDEFAULTS setValue:lat forKey:@"latitude"];
    [USERDEFAULTS setValue:longitd forKey:@"longitude"];
    
}

+(NSString*)URLQueryAllowedCharacterSet :(NSString*)urlstring
{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *resultUrl = [urlstring stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    return resultUrl;
    
}
+(void)showLoading:(UIView *)onView :(NSString *)fillColor and:(NSString *)pathColor
{
    
    if(onView){
        @try {
                        [onView setUserInteractionEnabled:YES];
            [[self sharedInstance] stopAnimating];
            ADWTJCircularSpinner *spinner = [self sharedInstance];
            [spinner setCenter:onView.center];
            spinner.radius = 15;
            spinner.fillColor = [Utilities colorFromHexString:fillColor];
            spinner.pathColor = [Utilities colorFromHexString:pathColor];
            spinner.thickness = 3;
            spinner.center = onView.center;
            [onView addSubview:spinner];
            [onView bringSubviewToFront:spinner];
            [onView setUserInteractionEnabled:NO];
            [spinner startAnimating];
        }
        @catch (NSException *exception) {
            //@"Exception:%@",exception);
        }
        @finally {
            //Display Alternative
        }
        
    }
    
}

+(void)removeLoading:(UIView *)onView
{
    if(onView){
        @try {
            [onView setUserInteractionEnabled:YES];
            [[self sharedInstance] stopAnimating];
        }
        @catch (NSException *exception) {
            //@"Exception:%@",exception);
        }
        @finally {
            //Display Alternative
        }
        
    }
}

+ (UIColor *) colorFromHexString:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3)
    {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@", [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)], [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)], [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6)
    {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue; [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue]; float red = ((baseValue >> 24) & 0xFF)/255.0f;
    
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark Table view data source

+(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder
{
    UITextField *tf = [[UITextField alloc] init];
    
    if(text.length == 0)
        tf.placeholder = placeholder ;
    else
        tf.text = text ;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    
    tf.leftView = paddingView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.backgroundColor = [UIColor whiteColor];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.textAlignment = NSTextAlignmentCenter;
    tf.autocorrectionType = UITextAutocorrectionTypeNo ;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.adjustsFontSizeToFitWidth = YES;
    tf.font = [UIFont fontWithName:@"" size:15.0];
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    return tf ;
}
+(void) changeTextfieldTextColor:(NSArray *)textFieldsArray and:(BOOL)isRegister
{
    for (int i=0; i<textFieldsArray.count; i++)
    {
        UITextField * textField = (UITextField *) [textFieldsArray objectAtIndex:i];
        //        [textField setValue:[UIColor colorWithRed:9.0/255.0 green:69.0/255.0 blue:103.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        //        textField.textColor = [UIColor colorWithRed:9.0/255.0 green:69.0/255.0 blue:103.0/255.0 alpha:1.0];
        
        if (isRegister) {
            [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
            textField.textColor = [UIColor blackColor];
            
        }
        else{
            [textField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
            textField.textColor = [UIColor blackColor];
            
        }
    }
}
+(void) changeTextfieldTextColorChangePassword:(NSArray *)textFieldsArray and:(BOOL)isRegister
{
    for (int i=0; i<textFieldsArray.count; i++)
    {
        UITextField * textField = (UITextField *) [textFieldsArray objectAtIndex:i];
        //        [textField setValue:[UIColor colorWithRed:9.0/255.0 green:69.0/255.0 blue:103.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        //        textField.textColor = [UIColor colorWithRed:9.0/255.0 green:69.0/255.0 blue:103.0/255.0 alpha:1.0];
        
        if (isRegister) {
            [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
            textField.textColor = [UIColor colorWithRed:50.0/255.0 green:66.0/255.0 blue:92.0/255.0 alpha:1.0];;
            
        }
        else{
            [textField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
            textField.textColor = [UIColor colorWithRed:50.0/255.0 green:66.0/255.0 blue:92.0/255.0 alpha:1.0];;
            
        }
    }
}



+(float)lablHeight:(NSString*)text :(CGFloat)labelwidth andFont:(float)fontSize
{
    //    CGSize fontSize = [text sizeWithAttributes:
    //                       @{NSFontAttributeName:
    //                             [UIFont fontWithName:HELVETICANEUE_LIGHT size:15]}];
    //
    //    //@"fontSize=%f",fontSize.height);
    //    return fontSize.height;
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont fontWithName:PROXIMANOVAREGULAR size:fontSize]}];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){labelwidth, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    ////@"label heigt = %f",rect.size.height);
    
    return ceil(rect.size.height);
}
+(void)saveUserProfilePic:(NSString *)imageUrlString
{
    NSData *imageData = nil;
    NSURL *imageURL = [NSURL URLWithString:imageUrlString];
    imageData = [NSData dataWithContentsOfURL:imageURL];
    NSString *dataPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProfilePic"];
    [imageData writeToFile:dataPath atomically:YES];
}

+(void)resizeSubViewSizes :(UIImageView *)imageView
{
    float height = MAX(imageView.frame.size.width, imageView.frame.size.height);
    CGRect frame = imageView.frame;
    frame.size.width = height;
    frame.size.height = height;
    imageView.frame = frame;
    imageView.layer.cornerRadius = height/2;
    imageView.layer.masksToBounds = YES;
    
}

#pragma Keyboard Methods

+(void)keyboardWillShow:(NSNotification *)notification :(UIView*)currentView
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardFrame = [kbFrame CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    ////@"Updating constraints.");
    [UIView animateWithDuration:animationDuration animations:^{
        currentView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].origin.y - (height - 115), CGRectGetWidth(currentView.frame), CGRectGetHeight(currentView.frame));
        
        [currentView layoutIfNeeded];
    }];
}

+(void)keyboardWillHide:(NSNotification *)notification :(UIView*)currentView
{
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        currentView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].origin.y, CGRectGetWidth(currentView.frame), CGRectGetHeight(currentView.frame));
        
        [currentView layoutIfNeeded];
    }];
}

+(void)roundCornerImageView:(UIImageView *)imageView{
    float logoPlusHeight = MAX(imageView.frame.size.width, imageView.frame.size.height);
    CGRect logoPlusFrame = imageView.frame;
    logoPlusFrame.size.width = logoPlusHeight;
    logoPlusFrame.size.height = logoPlusHeight;
    imageView.frame = logoPlusFrame;
    imageView.layer.cornerRadius = logoPlusHeight/2;
    imageView.layer.masksToBounds = YES;
    imageView.clipsToBounds = YES;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth = 1;
    
}

+ (void)addLinearGradientToView:(UIView *)theView withColor:(UIColor *)theColor
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    //the gradient layer must be positioned at the origin of the view
    CGRect gradientFrame = theView.frame;
    gradientFrame.origin.x = 0;
    gradientFrame.origin.y = 0;
    gradientFrame.size.width = SCREEN_WIDTH;
    gradient.frame = gradientFrame;
    
    //build the colors array for the gradient
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[[UIColor clearColor] CGColor],
                       (id)[[UIColor clearColor] CGColor],
                       (id)[[UIColor clearColor] CGColor],
                       (id)[[UIColor clearColor] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.3f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.6f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.9f] CGColor],
                       nil];
    
    //apply the colors and the gradient to the view
    gradient.colors = colors;
    [theView.layer insertSublayer:gradient atIndex:0];
}
+ (BOOL)isTimeOfDate:(NSDate *)targetDate betweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate
{
    if (!targetDate || !startDate || !endDate) {
        return NO;
    }
    
    // Make sure all the dates have the same date component.
    NSDate *newStartDate = [self dateByNeutralizingDateComponentsOfDate:startDate];
    NSDate *newEndDate = [self dateByNeutralizingDateComponentsOfDate:endDate];
    NSDate *newTargetDate = [self dateByNeutralizingDateComponentsOfDate:targetDate];
    
    // Compare the target with the start and end dates
    NSComparisonResult compareTargetToStart = [newTargetDate compare:newStartDate];
    NSComparisonResult compareTargetToEnd = [newTargetDate compare:newEndDate];
    
    return (compareTargetToStart == NSOrderedDescending && compareTargetToEnd == NSOrderedAscending);
}
+ (NSDate *)dateByNeutralizingDateComponentsOfDate:(NSDate *)originalDate {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    // Get the components for this date
    NSDateComponents *components = [gregorian components:  (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate: originalDate];
    
    // Set the year, month and day to some values (the values are arbitrary)
    [components setYear:2000];
    [components setMonth:1];
    [components setDay:1];
    
    return [gregorian dateFromComponents:components];
}

+(void)buttonLeft_corners :(UIButton *)buttonName
{
    
    CAShapeLayer * positiveCorner = [CAShapeLayer layer];
    positiveCorner.path = [UIBezierPath bezierPathWithRoundedRect: buttonName.bounds
                                                byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                      cornerRadii: (CGSize){5, 5}].CGPath;
    
    buttonName.layer.mask = positiveCorner;
    buttonName.layer.masksToBounds = YES;
    
}
+(void)buttonRight_corners :(UIButton *)buttonName
{
    
    CAShapeLayer * positiveCorner = [CAShapeLayer layer];
    positiveCorner.path = [UIBezierPath bezierPathWithRoundedRect: buttonName.bounds
                                                byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight
                                                      cornerRadii: (CGSize){5, 5}].CGPath;
    
    buttonName.layer.mask = positiveCorner;
    buttonName.layer.masksToBounds = YES;
    
}
+(void)imageLeft_corners :(UIImageView *)imageName
{
    
    CAShapeLayer * positiveCorner = [CAShapeLayer layer];
    positiveCorner.path = [UIBezierPath bezierPathWithRoundedRect: imageName.bounds
                                                byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                      cornerRadii: (CGSize){5, 5}].CGPath;
    
    imageName.layer.mask = positiveCorner;
    imageName.layer.masksToBounds = YES;
    
}
+(void)imageRight_corners :(UIImageView *)imageName
{
    
    CAShapeLayer * positiveCorner = [CAShapeLayer layer];
    positiveCorner.path = [UIBezierPath bezierPathWithRoundedRect: imageName.bounds
                                                byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight
                                                      cornerRadii: (CGSize){5, 5}].CGPath;
    
    imageName.layer.mask = positiveCorner;
    imageName.layer.masksToBounds = YES;
}

+ (NSDictionary *) dictionaryByReplacingNullsWithStrings:(NSDictionary *)currentDict {
    NSMutableDictionary * const replaced = [NSMutableDictionary dictionaryWithDictionary: currentDict];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in currentDict) {
        const id object = [currentDict objectForKey: key];
        if (object == nul) {
            [replaced setObject: blank forKey: key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:replaced];
}
+(void)showNoDataLabel:(UIView *)view andText:(NSString *)text
{
    UILabel *noLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    noLabel.center = [view center];
    noLabel.textAlignment = NSTextAlignmentCenter;
    noLabel.textColor = [UIColor darkGrayColor];
    noLabel.tag = NoDataLabelTag;
    noLabel.numberOfLines = 0;
    noLabel.font = [UIFont fontWithName:PROXIMANOVASEMIBOLD size:14];
    noLabel.text = text;
    [UIView animateWithDuration:0.2
                     animations:^{
                     }
                     completion:^(BOOL finished){
                         [view addSubview:noLabel];
                         [view bringSubviewToFront:noLabel];
                     }];
    
}

+(void)removeNodataLabel:(UIView *)view{
    [view viewWithTag:NoDataLabelTag].hidden = YES;
    [[view viewWithTag:NoDataLabelTag] removeFromSuperview];
}

+(NSString *)dateFormate:(NSString *)dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //// here set format of date which is in your output date (means above str with format)
    
    //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    // here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    
    return convertedString;
}



+(void)saveName:(NSString *)Name{
    [USERDEFAULTS setObject:Name forKey:@"saveName"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getName{
    return [USERDEFAULTS objectForKey:@"saveName"];
}

+(void)saveEmail:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"saveemail"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getEmail{
    return [USERDEFAULTS objectForKey:@"saveemail"];
}



+(void)savePhoneno:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"savephone"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getPhoneno{
    return [USERDEFAULTS objectForKey:@"savephone"];
}




+(void)saveMobileno:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"savemobile"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getMobileno{
    return [USERDEFAULTS objectForKey:@"savemobile"];
}



+(void)saveDeviceTokenData:(NSData *)tokenData{
    [USERDEFAULTS setObject:tokenData forKey:@"DeviceTokenData"];
    [USERDEFAULTS synchronize];
}

+(NSData *)getDeviceTokenData{
    return [USERDEFAULTS objectForKey:@"DeviceTokenData"];
}

+(NSAttributedString *)insertZImageInLabelAtLastPositionWithTwoStrings:(UILabel *)label withImageName:(NSString *)imageName withFont:(UIFont *)font andTextColor:(UIColor *)textColor andto:(NSString *)to and:(NSString *)text withImageName:(NSString *)imageName2 withFont:(UIFont *)font2  and:(NSString *)text2 andAlignment:(NSTextAlignment)alignment :(int )width :(int)height

{
    
    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",text] attributes:@{ NSFontAttributeName : font ,NSForegroundColorAttributeName : textColor}];
    
    NSMutableAttributedString *myString2= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",text2] attributes:@{ NSFontAttributeName : font ,NSForegroundColorAttributeName : textColor}];
    
    NSMutableAttributedString *myString3= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",@"   to  "] attributes:@{ NSFontAttributeName : [UIFont fontWithName:PROXIMANOVASEMIBOLD size:14] ,NSForegroundColorAttributeName : GrayColor}];
    
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    attachment.image = image;
    
    attachment.bounds = CGRectMake(0, 0, width, height);
    
    int mid = font.descender + font.capHeight;
    
    attachment.bounds = CGRectIntegral(CGRectMake(0, font.descender - width / 2 + mid + 2,  width, height));
    
    
    //image 2
    
    NSTextAttachment *attachment2 = [[NSTextAttachment alloc] init];
    
    UIImage *image2 = [UIImage imageNamed:imageName2];
    
    attachment2.image = image2;
    
    attachment2.bounds = CGRectMake(0, 0, width, height);
    
    int mid2 = font2.descender + font2.capHeight;
    
    attachment2.bounds = CGRectIntegral(CGRectMake(0, font2.descender - width / 2 + mid2 + 2,  width, height));
    
    
    ////////////
    
    
    NSMutableAttributedString *attachmentString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
    NSMutableAttributedString *attachmentString2 = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment2]];
    
    //    NSAttributedString *attrBeforeStr=[[NSAttributedString alloc]initWithString:@" to "];
    
    
    
    [myString appendAttributedString:attachmentString];
    
    [myString appendAttributedString:myString3];
    
    [myString2 appendAttributedString:attachmentString2];
    
    
    
    [myString appendAttributedString:myString2];
    
    NSMutableAttributedString *newString = [[NSMutableAttributedString alloc]initWithAttributedString:myString];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setAlignment:alignment];
    
    [newString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [newString length])];
    
    
    
    return myString;
    
}
+(NSString *) flattenHTML:(NSString *)html

{
    /*Converting Html to Plain Text*/
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
        
        //        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"&nbsp;"] withString:@""];
        
    }
    
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
    
}

+(NSString *)dateFormateforepire:(NSString *)dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //// here set format of date which is in your output date (means above str with format)
    
    //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    //    [dateFormatter setDateFormat:@"dd-MM-yyyyTHH:mm:ssZ"];
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    
    // here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    
    return convertedString;
}

+(NSString *)dateFormateforCashback:(NSString *)dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //// here set format of date which is in your output date (means above str with format)
    
    //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    // here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    
    return convertedString;
}
+(void)saveDeviceToken:(NSString *)deviceToken
{
    [USERDEFAULTS setValue:deviceToken forKey:@"DeviceToken"];
    [USERDEFAULTS synchronize];
}
+(NSString *)getDeviceToken
{
    return [USERDEFAULTS valueForKey:@"DeviceToken"];
}

+(NSString *)dateFormatefordispached:(NSString *)dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ssz"];
    
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //// here set format of date which is in your output date (means above str with format)
    
    //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    
    // here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    //@"Converted String : %@",convertedString);
    
    return convertedString;
}

+(NSString *)getExpiryDateFormatString:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //// here set format of date which is in your output date (means above str with format)
    
    //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    // here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    
    return convertedString;
}

+(NSString *)convertDateFormate:(NSString *)dateStr{
    
    
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
//    [dateFormatter setDateFormat: @"yyyyMMddhhmm"];
//    
   
    NSDate *lastUpdate = [[NSDate alloc] initWithTimeIntervalSince1970:[dateStr intValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSLog(@"date time: %@", [dateFormatter stringFromDate:lastUpdate]);
    
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //// here set format of date which is in your output date (means above str with format)
    
    //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: [dateFormatter stringFromDate:lastUpdate]]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MM-dd-yyyy hh:mm a"];
    // here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    
    return convertedString;
}


+(NSString *)getDateFormatStringToTime:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //// here set format of date which is in your output date (means above str with format)
    
    //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"hh:mm a"];
    // here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    
    return convertedString;
}


#define addressbook

#define This methods encript decript

+(BOOL)archive:(NSDictionary *)dict withKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = nil;
    if (dict) {
        data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    }
    [defaults setObject:data forKey:key];
    return [defaults synchronize];
}

+ (NSDictionary *)unarchiveForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:key];
    NSDictionary *userDict = nil;
    if (data) {
        userDict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return userDict;
}

#pragma mark - Render image from view
#pragma mark - Render image from view



+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}



+(NSDate *)getDateFromMilliseconds:(NSString *)timeStamp{
    double unixTimeStamp = [timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(unixTimeStamp / 1000)];
    return date;
}

+(NSDate *)getChatTimeFromString:(NSString *)dateStr{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSZ";
    NSDate *yourDate = [dateFormatter dateFromString:dateStr];
    return yourDate;
}

+(NSString *)getChatTimeFromDate{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSZ";
    NSString *stringFromDate = [dateFormatter stringFromDate:[NSDate date]];
    return stringFromDate;
}

+(NSString *)getErrorMessageForStatus:(NSInteger)status
{
    
    NSString *errorMsg = nil;
    switch (status) {
        case 200:
            errorMsg = @"No items found";
            break;
            
        case 400:
            errorMsg = @"Oops! Something went wrong! Why don't you try after some time?";
            break;
            
        case 401:
            errorMsg = @"Invalid API Key";
            break;
            
        case 403:
            errorMsg = @"Request timeout";
            break;
            
        case 500:
            errorMsg = @"Oops! Something went wrong! Why don't you try after some time?";
            break;
        case 412:
            errorMsg = @"No network available";
            break;
            
        default:
            errorMsg = @"Oops! Something went wrong! Why don't you try after some time?";
            break;
    }
    return errorMsg;
}

+(NSString*)compareStringChecking : (NSString*)sendingString
{
    NSString *finalString;
    if ([sendingString isEqualToString:@"confirmed"])
    {
        finalString = @"Pending";
        
    }
    
    else if ([sendingString isEqualToString:@"partial"])
        
    {
        
        finalString = @"Partial Dispatch";
        
    }
    
    else if ([sendingString isEqualToString:@"complete"])
        
    {
        
        finalString = @"Dispatched";
        
    }
    
    else if ([sendingString isEqualToString:@"Fail"])
        
    {
        
        finalString = @"Failed";
        
    }
    else if ([sendingString isEqualToString:@"cancelled"])
    {
        
        finalString = @"Cancelled";
        
    }
    
    else if ([sendingString isEqualToString:@"cart"])
        
    {
        
        finalString = @"Failed";
        
    }
    return finalString;
    
}

+(void)displayToastWithMessage:(NSString *)toastMessage
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
        UILabel *toastView = [[UILabel alloc] init];
        toastView.text = toastMessage;
        toastView.font = [UIFont fontWithName:PROXIMANOVAREGULAR size:14];
        toastView.textColor = WHITECOLOR;
        toastView.backgroundColor = BLACKCOLOR;
        toastView.textAlignment = NSTextAlignmentCenter;
        toastView.frame = CGRectMake(0.0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
        //        toastView.layer.cornerRadius = 10;
        toastView.layer.masksToBounds = YES;
        //        toastView.frame = toastView.frame;
        toastView.numberOfLines  = 0;
        [keyWindow addSubview:toastView];
        
        [UIView animateWithDuration: 3.0f
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations: ^{
                             toastView.alpha = 0.0;
                         }
                         completion: ^(BOOL finished) {
                             [toastView removeFromSuperview];
                         }
         ];
    }];
}


+(void)displayNotificationToast :(NSString *)title andMessage :(NSString *)message{
    
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView  *_notifView = [[UIView alloc] initWithFrame:CGRectMake(0, -70, keyWindow.frame.size.width, 80)];
    _notifView.tag = 777;
    [_notifView setBackgroundColor:[UIColor blackColor]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,15,15,15)];
    imageView.image = [UIImage imageNamed:@"greenZ.png"];
    
    UILabel *titleLabel =  [[UILabel alloc] initWithFrame:CGRectMake(32, 13, 100 , 21)];
    titleLabel.font = [UIFont fontWithName:PROXIMANOVASEMIBOLD size:15.0];
    titleLabel.textColor = WHITECOLOR;
    //titleLabel.text = title;
    
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 33, keyWindow.frame.size.width - 100 , 21)];
    myLabel.lineBreakMode = NSLineBreakByWordWrapping;
    myLabel.font = [UIFont fontWithName:PROXIMANOVAREGULAR size:13.0];
    myLabel.text = message;
    
    [myLabel setTextColor:WHITECOLOR];
    [myLabel setNumberOfLines:0];
    
    [_notifView setAlpha:0.85];
    
    //The Icon
    [_notifView addSubview:imageView];
    
    //The Text
    [_notifView addSubview:myLabel];
    
    //The Title
    [_notifView addSubview:titleLabel];
    
    //The View
    [keyWindow addSubview:_notifView];
    
    UITapGestureRecognizer *tapToDismissNotif = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(dismissNotifFromScreen)];
    tapToDismissNotif.numberOfTapsRequired = 1;
    tapToDismissNotif.numberOfTouchesRequired = 1;
    
    [_notifView addGestureRecognizer:tapToDismissNotif];
    
    
    [UIView animateWithDuration:1.0 delay:.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [_notifView setFrame:CGRectMake(0, 0, keyWindow.frame.size.width, 60)];
        
    } completion:^(BOOL finished) {
        
    }];
    
    //Remove from top view after 5 seconds
    [self performSelector:@selector(dismissNotifFromScreen) withObject:nil afterDelay:2.0];
}

+(void)dismissNotifFromScreen{
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *notifyView = [keyWindow viewWithTag:777];
    [UIView animateWithDuration:1.0 delay:.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [notifyView setFrame:CGRectMake(0, -70, keyWindow.frame.size.width, 60)];
        
    } completion:^(BOOL finished) {
        [notifyView removeFromSuperview];
    }];
    
}

+(NSString*)stringByTrimmingLeadingWhitespace :(NSString *)string {
    NSInteger i = 0;
    
    while ((i < [string length])
           && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[string characterAtIndex:i]]) {
        i++;
    }
    return [string substringFromIndex:i];
}

+(NSAttributedString *)convertBoldOneWorddifferentColor :(NSString *)sendingStr :(NSString*)changeStr{
    NSString *yourString = sendingStr;
    NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
    NSString *boldString = changeStr;
    NSRange boldRange = [yourString rangeOfString:boldString];
    [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:boldRange];
    
    NSString *string = changeStr; // the string to colorize
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:sendingStr];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:string options:kNilOptions error:nil]; // Matches 'God' case SENSITIVE
    NSRange range = NSMakeRange(0 ,sendingStr.length);
    
    // Change all words that are equal to 'God' to red color in the attributed string
    [regex enumerateMatchesInString:sendingStr options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSRange subStringRange = [result rangeAtIndex:0];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:subStringRange];
    }];
    //    if(![changeStr isEqualToString:@"four corners"]){
    [mutableAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:boldRange];
    //    }
    
    
    
    return mutableAttributedString;
}
+(void)saveVenueTypeArray:(NSMutableArray *)type{
    [USERDEFAULTS setObject:type forKey:@"VenueTypeArray"];
    [USERDEFAULTS synchronize];
}

+(NSMutableArray *)getVenueTypeArray{
    return [USERDEFAULTS objectForKey:@"VenueTypeArray"];
}
+(BOOL)isNumeric:(NSString*)inputString{
    BOOL isValid = NO;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:inputString];
    isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
    return isValid;
}

+ (UIImage *)image:(UIImage *)image withBottomHalfOverlayColor:(UIColor *)color andRatingDecimal:(float)fraction
{
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width, image.size.height);
    
    if (&UIGraphicsBeginImageContextWithOptions) {
        CGFloat imageScale = 1.f;
        if ([self respondsToSelector:@selector(scale)])
            imageScale = image.scale;
        UIGraphicsBeginImageContextWithOptions(image.size, NO, imageScale);
    }
    else
    {
        UIGraphicsBeginImageContext(image.size);
    }
    
    [image drawInRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGRect rectToFill = CGRectMake(0.f, 0, image.size.width*fraction, image.size.height);
    CGContextFillRect(context, rectToFill);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(void)saveContactsUpdateStatus:(BOOL)status{
    [USERDEFAULTS setBool:status forKey:@"ContactsUpdated"];
    [USERDEFAULTS synchronize];
}

+(BOOL)getContactsUpdateStatus{
    return [USERDEFAULTS boolForKey:@"ContactsUpdated"];
}

+(BOOL)validateMobileOREmail:(NSString *)text error:(NSString **)error{
    BOOL isValid = YES;
    //  *error = @"";
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([text rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        if (!text.length) {
            // *error = MOBILE_ALERT_EMPTY;
            isValid = NO;
        }
        else if (text.length <=10) {
            // *error = MOBILE_ALERT_ERROR;
            isValid = YES;
        }
        else{
            if ([MobileNumValidate containsObject:text]) {
                //   *error = MOBILE_ALERT_ERROR;
                isValid = NO;
            }
        }
    }
    else{
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if (![emailTest evaluateWithObject:text])
        {
            //*error = EMAIL_ALERT_ERROR;
            isValid = NO;
        }
        else
        {
            isValid = YES;
            // *error = @"";
        }
    }
    return isValid;
}


+(NSString *)advertiserID{
    Class   advertisingManagerClass     = nil;
    id      advertisingManager         = nil;
    
    NSString *advertiserID = nil;
    
    advertisingManagerClass = NSClassFromString(@"ASIdentifierManager");
    
    if (advertisingManagerClass != NULL){
        advertisingManager = [[advertisingManagerClass alloc] init];
        
        if ([advertisingManager isAdvertisingTrackingEnabled]){
            advertiserID = [[advertisingManager advertisingIdentifier] UUIDString];
        }else {
            NSLog(@"Limited ad tracking. Can't track advertising identifier");
        }
    }else {
        NSLog(@"ADSupport Framework unavailable");
    }
    return advertiserID;
}
+(NSString *)locationNameWith :(NSDictionary *)locationObj
{
    if ([locationObj valueForKey:@"terms"]!= nil) {
        NSArray *termsArray = (NSArray *)[locationObj valueForKey:@"terms"];
        if (termsArray.count > 2) {
            if (termsArray.count == 3) {
                return [NSString stringWithFormat:@"%@",[[termsArray objectAtIndex:0] valueForKey:@"value"]];
            }
            else if(termsArray.count == 4){
                return [NSString stringWithFormat:@"%@",[[termsArray objectAtIndex:1] valueForKey:@"value"]];
            }
            else{
                return [NSString stringWithFormat:@"%@",[[termsArray objectAtIndex:termsArray.count-3] valueForKey:@"value"]];
            }
        }
        
        else{
            return [NSString stringWithFormat:@"%@",[[termsArray objectAtIndex:0] valueForKey:@"value"]];
        }
        
    }
    
    return @"";
    
}



#pragma mark - Update Recruiter Details in DB
+ (void) deleteALLEntityInDB
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:@"CartModel" inManagedObjectContext:context]];
    NSArray * result = [context executeFetchRequest:fetch error:nil];
    for (id basket in result)
        [context deleteObject:basket];
}
+ (NSManagedObjectContext *)managedObjectContext
{
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

//marchant methods

///////// SAVING OPEN TIME //////////
+(void)Saveimageurl:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveOpenTime"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getimageurl{
    return [USERDEFAULTS objectForKey:@"SaveOpenTime"];
}

///////// SAVING CLOSE TIME //////////
+(void)SaveCloseTime_machant:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveCloseTime_machant"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getCloseTime_merchant{
    return [USERDEFAULTS objectForKey:@"SaveCloseTime_machant"];
}


/////// SAVE ITEM CATEGORY  ID ////////

+(void)SaveItemCategoryID:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveItemCategoryID"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getItemCategoryID{
    return [USERDEFAULTS objectForKey:@"SaveItemCategoryID"];
}


/////// SAVE DELIVERY COMPANY ID ////////
+(void)SaveDeliveryCompanyID:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveDeliveryCompanyID"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getDeliveryCompanyID{
    return [USERDEFAULTS objectForKey:@"SaveDeliveryCompanyID"];
}


//////////////// SAVING CMS ID //////////////////

+(void)SaveCmsID:(NSString *)type{
    [USERDEFAULTS setObject:type forKey:@"SaveCmsID"];
    [USERDEFAULTS synchronize];
}

+(NSString *)getCmsID
{
    return [USERDEFAULTS objectForKey:@"SaveCmsID"];
}

///////// SAVING code mealshack //////

+(void)SaveCode:(NSString *)type
{
    [USERDEFAULTS setObject:type forKey:@"SaveCode"];
    [USERDEFAULTS synchronize];
}
+(NSString *)getCode
{
    return [USERDEFAULTS objectForKey:@"SaveCode"];
}




+(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude
{
    NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%f,%f&output=csv",pdblLatitude, pdblLongitude];
    NSError* error;
    NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error];
    locationString = [locationString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return [locationString substringFromIndex:6];
}

@end
