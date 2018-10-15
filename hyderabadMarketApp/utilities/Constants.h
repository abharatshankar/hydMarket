//
//  Constants.h
//  Zaggle
//
//  Created by Zaggle Prepaid Ocean Services Private Limited on 11/05/16.
//  Copyright © 2016 Zaggle Prepaid Ocean Services Private Limited. All rights reserved.

/*!
 ->  Constants used for.
 
 -> in this controller displaying all declaring variables
 
 */


#ifndef Constants_h
#define Constants_h
#import "AppDelegate.h"

/***********changes ***********/
//before ashwin // https://mobile-api.zaggle.in/
// replace // https://staging-mobile-api.zaggle.in/

/*!

 @discussion    base url 
 @return        nill
 */



#define APPVERTION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


/******************** dev end *****/
/*=========================================*/
         //IOS 10 VERSON CHECK
/*=========================================*/
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

/*=========================================*/
    //BASE URLS FOR API CALLS AND IMAGES
/*=========================================*/

// STAGING
//#define establishment_id @"90" //testing

//#define establishment_id @"592e63255428a" //jivati

#define establishment_id @"59426ba256ddf" //brown beaar

#define BASEURL_changepassword @"https://demo.adroitent.com:2001/api/user/"
#define BASEURLUploadMedicalRecord @"https://demo.adroitent.com:2001/"
#define BASEURLRegistration @"https://demo.adroitent.com:2001/api/users"
#define BASEURL2 @"https://demo.adroitent.com:2001/api/"
#define BASEURL @"http://testingmadesimple.org/hydmarket/api/services/"
//#define BASEURL @"http://http://35.232.130.59/api/services/"

//http://35.232.130.59/api/services

#define RESTAURENTS_IMAGE_URL @"http://www.testingmadesimple.org/mealShack/uploads/establishment/"
#define BASEURLImages @"http://www.testingmadesimple.org/mealShack/uploads/profile/"
#define BASEURLBanner @"http://www.testingmadesimple.org/mealShack/uploads/banners/"


#define BASEURLImages_upload @"https://demo.adroitent.com:2002/"
#define BASEURL_socket @"https://demo.adroitent.com:2001/"


#define LatoRegular @"DinC"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad


#define GOOGLEKEY @"AIzaSyD2LTocPuJdu2UZpaoE_AbRYeeoEJmaRA4"


/*=========================================*/
                   //KEYS
/*=========================================*/
#define GClientID @"785108629967-pmvr6kmbfsk5j8q357i2r4sr1d5ao3e6.apps.googleusercontent.com"
#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define GOOGLEAPIKEY @"AIzaSyDDvwup5L1YqK9Loku7hZwn4p64wI_E3bw"
#define ChatPublishKey @"pub-c-5be23e69-2a0d-42fd-9ffb-8f5cbef18420"
#define ChatsubscribeKey @"sub-c-36b58c8c-702a-11e6-a014-0619f8945a4f"

/*=========================================*/
         //ALL MOBILES SCREENS SIZES
/*=========================================*/
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 568.0) && ((IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale) || !IS_OS_8_OR_LATER))
#define IS_IPHONE_5S (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 568.0) && ((IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale) || !IS_OS_8_OR_LATER))
#define IS_IPHONE_5C (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 568.0) && ((IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale) || !IS_OS_8_OR_LATER))
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6S (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_ZOOMED_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale > [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_ZOOMED_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale < [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6S_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)

#define IS_STANDARD_IPHONE_7 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_7_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define IS_IPHONE_4 [[UIScreen mainScreen] bounds].size.height == 480.0
#define NOTIFICATIONCENTER [NSNotificationCenter defaultCenter]

/*=========================================*/
                 //COLOR NAEMS
/*=========================================*/
#define FontColorHex @"#f27f25"
#define VariationTypeButtonBackgroundColor @"#E8E9E8"
#define DARKGrayColor [UIColor darkGrayColor]
#define WHITECOLOR [UIColor whiteColor]
#define CLEARCOLOR [UIColor clearColor]
#define GrayColor [UIColor grayColor]
#define BLACKCOLOR  [UIColor blackColor]

//#define REDCOLOR [UIColor colorWithRed:253.0/255.0 green:78.0/255.0 blue:78.0/255.0 alpha:1.0]
#define REDCOLOR [UIColor colorWithRed:0.79 green:0.11 blue:0.19 alpha:1.0]

#define LIGHTGRYCOLOR [UIColor lightGrayColor]
#define DARKGRAYCOLOR [UIColor darkGrayColor]


#define SIDEMENUBGCOLOR [UIColor colorWithRed:44.0f/255.0f green:42.0f/255.0f blue:42.0f/255.0f alpha:1.0]
#define SIDEMENUFONTCOLOR [UIColor colorWithRed:251.0f/255.0f green:251.0f/255.0f blue:251.0f/255.0f alpha:1.0]

#define GREEN_COLOR_RBGVALUE [UIColor colorWithRed:251.0f/255.0f green:251.0f/255.0f blue:251.0f/255.0f alpha:1.0]
#define YELLOW_COLOR_RBGVALUE [UIColor colorWithRed:254.0f/255.0f green:235.0f/255.0f blue:52.0f/255.0f alpha:1.0]
#define WHITE_COLOR_RBGVALUE  [UIColor whiteColor]
#define PLACEORDERColor [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]

#define Backgroundcolor [UIColor colorWithRed:253.0/255.0 green:78.0/255.0 blue:78.0/255.0 alpha:1.0]
#define ViewBagroundColor [UIColor colorWithRed:23.0/255.0 green:32.0/255.0 blue:49.0/255.0 alpha:1.0]
#define SIGNUPBGCOLOR [UIColor colorWithRed:66.0/255.0 green:246.0/255.0 blue:206.0/255.0 alpha:1.0]





#define ButtonsBgColor [UIColor colorWithRed:57.0/255.0 green:100.0/255.0 blue:195.0/255.0 alpha:1.0]
#define OrangeColor [UIColor colorWithRed:243.0/255.0 green:92.0/255.0 blue:58.0/255.0 alpha:1.0]

#define FontColor [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1.0]
#define YELLOW [UIColor colorWithRed:255.0/255.0 green:184.0/255.0 blue:20.0/255.0 alpha:1.0]
#define BGNavigationCOLOR [UIColor colorWithRed:242.0/255.0 green:127.0/255.0 blue:37.0/255.0 alpha:1.0]
#define StripColor [UIColor colorWithRed:50.0/255.0 green:66.0/255.0 blue:92.0/255.0 alpha:1.0]

#define StatusBarColor [UIColor colorWithRed:16.0/255.0 green:31.0/255.0 blue:56.0/255.0 alpha:1.0]


#define GRAYBUTTONBGCOLOR [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0]
#define Cellbordercolour [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1.0]
#define FiltersTextColor [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0]
#define editprofilebgColor [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]
#define ButtonSideColor [UIColor colorWithRed:75.0/255.0 green:156.0/255.0 blue:152.0/255.0 alpha:1.0]
#define checkboxTextcolor [UIColor colorWithRed:123.0/255.0 green:123.0/255.0 blue:123.0/255.0 alpha:1.0]

/*=========================================*/
              //PRODUCT TYPES
/*=========================================*/

#define PHYSICAL_VOUCHER_PRODUCT_TYPE @"physical_voucher"
#define E_VOUCHER_PRODUCT_TYPE @"evoucher"
#define MERCHANDISE_PRODUCT_TYPE @"merchandise"

/*=========================================*/
 //These files for all Messges in entire app
/*=========================================*/
/////////****custom deal alerts********///////
#define DeleteAllNotifications    @"Are you sure do you want to delete all these notifications."
#define BlockMessageBeforeLogin @"Your account is temporarily blocked. Please contact customer care at 1860 500 3748 (10:00 AM to 7:00 PM, Monday to Friday)."
#define BlockMessageAfterLogin @"Uh Oh! There seems to be a problem. Please login again."
#define PromocodeEmptyMsg @"Please enter valid promo code."
#define alcoholEmptyMsg @"Please select alcohol."
#define  logoutMessage @"Do you really want to logout?"
#define AllFieldsEmptyMsg @"Please enter all fields."
#define NameEmptyMsg @"Please enter your name"
#define MobileValidyMsg @"Please enter valid mobile number"
#define MobileEmptyMsg @"Please enter mobile number"
#define EmailValidMsg @"Please enter valid email id"
#define EmailEmptyMsg @"Please enter your email id"
#define PasswordEmptyMsg @"Please enter new password."
#define reenterPasswordEmptyMsg @"Please enter re-enter password."
#define OldPasswordEmptyMsg @"Please enter valid old password."
#define NeworLodPasswordFieldsEmptyMsg @"Old password and new password should not same."
#define NewPasswordFieldsEmptyMsg @"New password and re enter password must be same."
#define OldPasswordLengthyMsg @"Please enter old password length minimum 4 and maximum 12"
#define NewPasswordLengthyMsg @"Please enter new password length minimum 4 and maximum 12"
#define RePasswordLengthyMsg @"Please enter re-enter password length Minimum 4 and maximum 12"
#define filterSelect @"bluecheck.png"
#define SignupTwoMessge "You have already signed up with given mobilenumber and email."
#define OtpEmptyMsg @"Please enter OTP."
#define PasswordtextRangeMsg @"Password should contains atleast 5 characters"
#define PasswordLengthyMsg @"Please enter password length minimum 4 and maximum 12"
#define NameLengthyMsg @"Please enter name length minimum 3 letters"
#define NoInternetConnectionMsg @"Please check your internet connection"
#define  Status2Message1 @"MobileNumber is already exist"
#define  Status2Message2 @"Email is already exist"
#define  Status0Message @"Required Field Missing"
#define  Status5Message @"The mobile number you have entered is already present in Zaggle. Please login using the mobile number entered or Contact our services execuite to create an account"
#define  PointsGetMessage @"Hurray You Just Won Zaggle Cash"
#define  PasswordSentMessage @"Your password has been sent to your mobile number"
#define  LoginSocialMessage @"You are not existing with us please click Sign up Or Cancel"
#define  SigiUpSocialMessage @"This account already registered please use another account"
#define  ExploreLoginAlert @"Please login to access this feature. Login now?"
#define  ReviewSuccessMsg @"Thank you for the review. We will publish it post verification."

/*=========================================*/
 //IMAGE NAMES && TABBAR ICON IMAGE NAMES
/*=========================================*/
#define BagroundImage @"bg-login.png"
#define EyeDisplayImage @"eye_disabled.png"
#define FacebookIcon @"fb.png"
#define GoogleIcon @"google.png"
#define ZaggleLogo @"logo-login.png"
#define AlertVpanicImage @"smile-icon.png"
#define CallImage @"cal-icon.png"
#define glassImage @"glasses-icon.png"
#define smileIcon @"smilee.png"
#define DeleteWhiteIcon @"White-trash-delete.png"
#define AlertSmileImage @"smilke.png"
#define HomeActive @"home-active.png"
#define HomeINActive @"home.png"
#define UploadActive @"bill-active.png"
#define UploadINActive @"bill.png"
#define ChatActive @"chat-active.png"
#define ChatINActive @"chat.png"
#define RedeemActive @"redeem-active.png"
#define RedeemINActive @"redeem.png"
#define MoreActive @"more-active.png"
#define MoreINActive @"more.png"
#define LoveIconImage @"love-icon.png"
#define RedLoveIconImage @"Red-love.png"
#define  UncheckedImg @"uncheck.png"
#define  checkedImg @"checked.png"
#define  GREENZ @"greenZ.png"
#define  GRAYZ @"z-icon-gary.png"
#define  MINUSHIGHLITED @"minus-active.png"
#define  MINUSDULL @"minus-icon.png"
#define  EYEHIDE @"eye_disabled.png"
#define  EYESHOW @"eye_enabled.png"
#define CATEGORIESWHITE @"categories-white.png"
#define CATEGORIESGRAY @"categories-gray.png"
#define CUSINEWHITE @"cuisine-white.png"
#define CUSINEGRAY @"cuisine-gray.png"
#define DEALWHITE @"deal-white.png"
#define DEALGRAY @"deal-gray.png"
#define LOCATINWHITE @"location-white.png"
#define LOCATIONGRAY @"location-gray.png"
#define TopSortWhite @"white-short.png"
#define TopSortGray @"gray-sort.png"
#define TopFilterWhite @"filter-icon.png"
#define TopFilterGray @"gray-filter-icon.png"
#define YellowCheckMArk @"yellow-right.png"
#define GrayCheckMArk @"gray-right.png"
#define FiletrDropYellow  @"drop-yellow.png"
#define FiletrTopYellow  @"top-yellow.png"
#define CashBackCheck  @"CashBackcheck.png"
#define CashBackUNCheck  @"CashBackuncheck.png"
#define starligth @"star-ligth.png"
#define starYellow @"orange-star.png"
#define UserIcon @"Usergrey_round.png"
#define RightArrowIcon @"192-right-arrow.png"
#define RECHABILITYCHECK_NOTIFY_NOTIFY   @"RECHABILITYCHECK_NOTIFY"

/*=========================================*/
         //Font names for entire app
/*=========================================*/
//#define PROXIMANOVAREGULAR  @"roboto_regular"
//#define PROXIMANOVASEMIBOLD  @"roboto_bold"
#define PROXIMANOVAREGULAR  @"HelveticaNeue"
#define PROXIMANOVASEMIBOLD  @"HelveticaNeue"

/*=========================================*/
       //LANDING PAGE TABLE HEIGHT
/*=========================================*/
#define TOPSCROLLVIEW_HEIGHT (SCREEN_HEIGHT * 46.5)/100
#define RESTAURENTVIEW_HEIGHT (SCREEN_HEIGHT * 37.5)/100

/*=========================================*/
  // Chat Read Receipient Call back types
/*=========================================*/
#define READ_SEEEN @"SEEN"
#define READ_UNSEEN @"UNSEEN"
#define READ_DELIVERED @"DELIVERED"
#define READRECEPT_TYPE @"ReadRecepient"
#define ONLINE_STATUS @"ONLINE"


#endif /* Constants_h */
