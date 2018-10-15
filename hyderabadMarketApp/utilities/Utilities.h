//
//  Utilities.h
//  Zaggle
//
//  Created by Zaggle Prepaid Ocean Services Private Limited on 11/05/16.
//  Copyright © 2016 Zaggle Prepaid Ocean Services Private Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "CustomAlertView.h"
#import <CommonCrypto/CommonCryptor.h>

extern NSMutableDictionary * globalDictionary;
extern NSMutableArray *cartArray;
extern NSUInteger totalZaggleCash;
extern NSUInteger totalZaggleCardCash,totalCartCount;

extern int peopletotalvalue ,slideminvalue;

extern NSDictionary *orderDictionary;
extern NSDictionary *tempOrderDictionary;
extern NSDictionary *promocodeDictionary;
extern NSMutableArray *paymentsListArray;

@interface Utilities : NSObject

@property (nonatomic, strong) NSCache *imageCache;

/*!
 abstract  :    sharedManager
 param   :      nil
 discussion  :  Function that returns the common shared instance for the Constants class
 return      :  Constants
 */
+(Utilities*)sharedManager;

/*!
 @abstract      screenRect
 param         string
 @discussion    Function that returns the common boolvalue
 @return        frame
 */
- (CGRect)screenRect;

/*!
 @abstract      emailCredibility
 param         string
 @discussion    Function that returns the common boolvalue
 @return        boovalue
 */
+(BOOL)emailCredibility:(NSString *)checkString;
/*!
 @abstract      displayCustemAlertViewCAll
 param         string
 @discussion    Function that returns the view
 return        boovalue
 */
+(void)displayCustemAlertViewCAll :(NSString*)message :(UIView*)currentView;
/*!
 @abstract      displayCustemAlertView
 param         string
 @discussion    Function that returns the view
 return        boovalue
 */
+(void)displayCustemAlertView :(NSString*)message :(UIView*)currentView;
+(UITextField*) setBorderTextFieldWithColorPass: (UITextField*)textField :(float)cornerRadiseValue : (UIColor*)color;



/*!
 @abstract      makeTextField
 param         string
 @discussion    Function that returns the common boolvalue
 @return        textfield properties
 */
+(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder;
/*!
 @abstract      gettingNumberString
 param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString*)gettingNumberString :(int)value;

/*!
 @abstract      setBorderTextField
 param         textfield
 @discussion    Function that returns the common boolvalue
 @return        textfield properties
 */
+(UITextField*) setBorderTextField: (UITextField*)textField :(float)cornerRadiseValue;
/*!
 @abstract      setBorderBtn
 param         Button
 @discussion    Function that returns the common boolvalue
 @return        textfield properties
 */
+(UIButton*) setBorderBtn: (UIButton*)currentBtn :(float)cornerRadiseValue :(UIColor*)color;
/*!
 @abstract      setPaddingTextField
 param         textfield
 @discussion    Function that returns the common boolvalue
 @return        textfield properties
 */
+(UITextField*) setPaddingTextField: (UITextField*)textField;
/*!
 @abstract      keyboardWillHide
 @param         currentview nad notification
 @discussion    Function that returns the keyboardWillHide
 @return        keyboardWillHide
 */
+ (void)keyboardWillHide:(NSNotification *)notification :(UIView*)currentView;
/*!
 @abstract      keyboardWillShow
 @param         currentview nad notification
 @discussion    Function that returns the keyboardWillShow
 @return        keyboardWillShow
 */
+ (void)keyboardWillShow:(NSNotification *)notification :(UIView*)currentView;
/*!
 @abstract      roundCornerImageView
 @param         iamgeview
 @discussion    Function that returns the roundCornerImageView
 @return        roundedCornerImageView
 */
+(void)roundCornerImageView:(UIImageView *)imageView;
/*!
 @abstract      savelatitude
 @param         lat long
 @discussion    Function that returns the savelatitude
 @return        savedlatitude
 */
+ (void) savelatitude:(NSString *)latitude and:(NSString *)longitude;

+(void)saveUserProfilePic:(NSString *)imageUrlString;
/*!
 @abstract      resizeSubViewSizes
 @param         iamgeview
 @discussion    Function that returns the resizeSubViewSizes
 @return       resizeSubViewSizes
 */
+(void)resizeSubViewSizes :(UIImageView *)imageView;
/*!
 @abstract      showLoading
 @param         view and color
 @discussion    Function that returns the showLoading
 @return        showLoading
 */
+(void)showLoading:(UIView *)onView :(NSString *)fillColor and:(NSString *)pathColor;
/*!
 @abstract      removeLoading
 @param         currentview
 @discussion    Function that returns the removeLoading
 @return        removeLoading
 */
+(void)removeLoading:(UIView *)onView;
/*!
 @abstract      displayCustemAlertView2Buttons
 @param         message and current view
 @discussion    Function that returns the displayCustemAlertView2Buttons
 @return        displayCustemAlertView2Buttons
 */
+(void)displayCustemAlertView2Buttons :(NSString*)message :(UIView*)currentView;
/*!
 @abstract      addLinearGradientToView
 @param         view and color
 @discussion    Function that returns the addLinearGradientToView
 @return        addLinearGradientToView
 */
+ (void)addLinearGradientToView:(UIView *)theView withColor:(UIColor *)theColor;
/*!
 @abstract      colorFromHexString
 @param         hexastring
 @discussion    Function that returns the colorFromHexString
 @return        colorFromHexString
 */
+ (UIColor *) colorFromHexString:(NSString *)hexString;
/*!
 @abstract      isInternetConnectionExists
 @param         nil
 @discussion    Function that returns the isInternetConnectionExists
 @return        isInternetConnectionExists
 */
+(BOOL)isInternetConnectionExists;
/*!
 @abstract      getIPAddress
 @param         nil
 @discussion    Function that returns the getIPAddress
 @return        getIPAddress
 */
+(NSString *)getIPAddress;
/*!
 @abstract      lablewidth
 @param         text font and font size
 @discussion    Function that returns the lablewidth
 @return        lablewidth
 */
+(float)lablewidth:(NSString*)text andFontSize:(CGFloat)size andFont:(NSString *)font;
/*!
 @abstract      lableHeight
 @param         text label font size
 @discussion    Function that returns the lableHeight
 @return        lableHeight
 */
+(float)lableHeight:(NSString*)text andFontSize:(CGFloat)size andFont:(NSString *)font andWidth:(CGFloat)labelwidth;
/*!
 @abstract      setBorderImage
 @param         current image
 @discussion    Function that returns the setBorderImage
 @return        setBorderImage
 */+(UIImageView*) setBorderImage: (UIImageView*)currentImageView :(float)cornerRadiseValue;
/*!
 @abstract      setBorderView
 @param         currentview
 @discussion    Function that returns the setBorderView
 @return        setBorderView
 */

+(UIView*) setBorderView: (UIView*)viewOfCurrent :(float)cornerRadiseValue :(UIColor*)color;

/*!
 @abstract      convertDateFormatString
 @param         dateStr
 @discussion    Function that returns the convertDateFormatString
 @return        convertDateFormatString
 */
+(NSString *)convertDateFormatString:(NSString *)dateValueSTR;

/*!
 @abstract      removeaAllUseerDefaults
 @param         nil
 @discussion    Function that returns the removeaAllUseerDefaults
 @return        removeaAllUseerDefaults properties
 */
+(void) removeaAllUseerDefaults;

/*!
 @abstract      gettingCurrentDate
 @param         nil
 @discussion    Function that returns the gettingCurrentDate
 @return        gettingCurrentDate
 */
+(NSString *)gettingCurrentDate;
/*!
 @abstract      gettingCurrentTime
 @param         nil
 @discussion    Function that returns the gettingCurrentTime
 @return        gettingCurrentTime
 */
+(NSString *)gettingCurrentTime;
/*!
 @abstract      null_ValidationString
 @param         string
 @discussion    Function that returns the null_ValidationString
 @return        null_ValidationString
 */
+(NSString*)null_ValidationString :(NSString *)checkstring;
/*!
 @abstract      circleImage
 @param         image
 @discussion    Function that returns the circleImage
 @return        circleImage
 */
+(void)circleImage :(UIView*)imageViewCurrent;
/*!
 @abstract      commentlableHeiight
 @param         text
 @discussion    Function that returns the commentlableHeiight
 @return        commentlableHeiight
 */
+(float)commentlableHeiight:(NSString*)text;
/*!
 @abstract      dateTochangeFormate
 @param         datestr
 @discussion    Function that returns the dateTochangeFormate
 @return        dateTochangeFormate
 */
+(NSString *)dateTochangeFormate:(NSString *)dateStr;
/*!
 @abstract      dateTochangeFormateToTime
 @param         atestr
 @discussion    Function that returns the dateTochangeFormateToTime
 @return        dateTochangeFormateToTime
 */
+(NSString *)dateTochangeFormateToTime:(NSString *)dateStr;
/*!
 @abstract      dateTochangeFormateToDate
 @param         datestr
 @discussion    Function that returns the dateTochangeFormateToDate
 @return        dateTochangeFormateToDate
 */
+(NSString *)dateTochangeFormateToDate:(NSString *)dateStr;
/*!
 @abstract      dateTochangeServerFormateToDisplay
 @param         datestr
 @discussion    Function that returns the dateTochangeServerFormateToDisplay
 @return        dateTochangeServerFormateToDisplay
 */
+(NSString *)dateTochangeServerFormateToDisplay:(NSString *)dateStr;
/*!
 @abstract      dateTochangeServerFormate
 @param         datestr
 @discussion    Function that returns the dateTochangeServerFormate
 @return        dateTochangeServerFormate
 */
+(NSString *)dateTochangeServerFormate:(NSString *)dateStr;
/*!
 @abstract      reviewLableHeiight
 @param         text font name font size
 @discussion    Function that returns the reviewLableHeiight
 @return        reviewLableHeiight
 */

+(float)reviewLableHeiight:(NSString*)text :(NSString*)fontName :(float)fontSize;
/*!
 @abstract      convertJsonString
 @param         dataArray
 @discussion    Function that returns the dataArray
 @return        jsonstring
 */
+(NSString*)convertJsonString : (NSArray*)dataArray;
/*!
 @abstract      sortingAnArray
 @param         sort array keyvalues
 @discussion    Function that returns the sortingAnArray
 @return        sorted Array
 */
+(NSArray*)sortingAnArray :(NSArray*)sortArr :(NSString*)keyVAlueStr;
/*!
 @abstract      compressingImageData
 @param         iamge
 @discussion    Function that returns the compressingImageData
 @return        compressingImageData
 */
+(NSData *)compressingImageData :(UIImage *)image;
/*!
 @abstract      expectedHeight
 @param         nil
 @discussion    Function that returns the expectedHeight
 @return        expectedHeight */
+(float)expectedHeight;
/*!
 @abstract      getLabelHeight
 @param         label
 @discussion    Function that returns the getLabelHeight
 @return        getLabelHeight
 */
+ (CGFloat)getLabelHeight:(UILabel*)label;
/*!
 @abstract      trimBlankCharactersFromBeginningOfString
 @param         string
 @discussion    Function that returns the trimBlankCharactersFromBeginningOfString
 @return        trimBlankCharactersFromBeginningOfString
 */
+(NSString*)trimBlankCharactersFromBeginningOfString:(NSString*)originalString;
/*!
 @abstract      displayCustemAlertViewWithimage
 @param         message view and image name
 @discussion    Function that returns the displayCustemAlertViewWithimage
 @return        displayCustemAlertViewWithimage with image
 */
+(void)displayCustemAlertViewWithimage :(NSString*)message :(UIView*)currentView :(NSString*)imagename;
/*!
 @abstract      editProfilecircleImage
 @param         image
 @discussion    Function that returns the editProfilecircleImage
 @return        editProfilecircleImage
 */
+(void)editProfilecircleImage :(UIImageView*)imageViewCurrent;
/*!
 @abstract      displayCustemAlertView
 @param         message and view and image name
 @discussion    Function that returns the displayCustemAlertView with image
 @return        displayCustemAlertView with image
 */
+(void)displayCustemAlertView :(NSString*)message :(UIView*)currentView :(NSString*)imageName;
/*!
 @abstract      lablHeight
 @param         labelwidth font size
 @discussion    Function that returns the lablHeight
 @return        lablHeight
 */
+(float)lablHeight:(NSString*)text :(CGFloat)labelwidth andFont:(float)fontSize;
/*!
 @abstract      sortingAnArrayDescending
 @param         arry and key values
 @discussion    Function that returns the sortingAnArrayDescending
 @return        sortingAnArrayDescending
 */
+(NSArray*)sortingAnArrayDescending :(NSArray*)sortArr :(NSString*)keyVAlueStr;
/*!
 @abstract      buttonLeft_corners
 @param         butgton
 @discussion    Function that returns the buttonLeft_corners
 @return        buttonLeft_corners
 */
+(void)buttonLeft_corners :(UIButton *)buttonName;
/*!
 @abstract      buttonRight_corners
 @param         button
 @discussion    Function that returns the buttonRight_corners
 @return        buttonRight_corners
 */
+(void)buttonRight_corners :(UIButton *)buttonName;
/*!
 @abstract      imageLeft_corners
 @param         image
 @discussion    Function that returns the imageLeft_corners
 @return        imageLeft_corners
 */
+(void)imageLeft_corners :(UIImageView *)imageName;
/*!
 @abstract      imageRight_corners
 @param         imageName
 @discussion    Function that returns the imageRight_corners
 @return        imageRight_corners
 */

+(void)imageRight_corners :(UIImageView *)imageName;



/*!
 @abstract      isTimeOfDate
 @param         start date end date
 @discussion    Function that returns the isTimeOfDate
 @return        isTimeOfDate
 */
+ (BOOL)isTimeOfDate:(NSDate *)targetDate betweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;
/*!
 @abstract      insertZImageInLabelAtLastPosition
 @param         label image message font...
 @discussion    Function that returns the insertZImageInLabelAtLastPosition
 @return        insertZImageInLabelAtLastPosition
 */
+(NSAttributedString *)insertZImageInLabelAtLastPosition:(UILabel *)label withImageName:(NSString *)imageName withFont:(UIFont *)font andTextColor:(UIColor *)textColor and:(NSString *)text andAlignment:(NSTextAlignment)alignment;
/*!
 @abstract      insertZImageInLabelAtLastPosition
 @param         label image message font...
 @discussion    Function that returns the insertZImageInLabelAtLastPosition
 @return        insertZImageInLabelAtLastPosition
 */
+(NSAttributedString *)insertZImageInLabelAtLastPosition:(UILabel *)label withImageName:(NSString *)imageName withFont:(UIFont *)font andTextColor:(UIColor *)textColor and:(NSString *)text andAlignment:(NSTextAlignment)alignment :(int )width :(int)height;

+(NSAttributedString *)insertZImageInLabelAtLastPositionLeft:(UILabel *)label withImageName:(NSString *)imageName withFont:(UIFont *)font andTextColor:(UIColor *)textColor and:(NSString *)text andAlignment:(NSTextAlignment)alignment : (NSString *)classType;


/*!
 @abstract      dateTochangeSlashDOB
 @param         datestr
 @discussion    Function that returns the dateTochangeSlashDOB
 @return        dateTochangeSlashDOB
 */
+(NSString *)dateTochangeSlashDOB:(NSString *)dateStr;
/*!
 @abstract      displayCustemAlertViewWithOutImage
 @param         message and currentview
 @discussion    Function that returns the displayCustemAlertViewWithOutImage
 @return        displayCustemAlertViewWithOutImage
 */
+(void)displayCustemAlertViewWithOutImage :(NSString*)message :(UIView*)currentView;
/*!
 @abstract      convertingArraytoString
 @param         data
 @discussion    Function that returns the convertingArraytoString
 @return        convertingArraytoString properties
 */
-(NSString*)convertingArraytoString :(NSString*)data;
/*!
 @abstract      dateTochangeComareCheck
 @param         date
 @discussion    Function that returns the compared date
 @return        compared properties
 */
+(NSString *)dateTochangeComareCheck:(NSDate *)date;
/*!
 @abstract      dictionaryByReplacingNullsWithStrings
 @param         currentDict
 @discussion    Function that returns the dictionaryByReplacingNullsWithString
 @return        dictionaryByReplacingNullsWithStrings properties
 */

+ (NSDictionary *) dictionaryByReplacingNullsWithStrings:(NSDictionary *)currentDict;
/*!
 @abstract      showNoDataLabel
 @param         view and text
 @discussion    Function that returns the common view
 @return        view data properties
 */
+(void)showNoDataLabel:(UIView *)view andText:(NSString *)text;
/*!
 @abstract      removeNodataLabel
 @param         view
 @discussion    Function that returns removeNodataLabele
 @return        removeNodataLabel
 */
+(void)removeNodataLabel:(UIView *)view;
/*!
 @abstract      dateFormate
 @param         dateStr
 @discussion    Function that returns the changed date
 @return        changed date
 */
+(NSString *)dateFormate:(NSString *)dateStr;
/*!
 @abstract      getUniqueDeviceId
 @param         nil
 @discussion    Function that returns the UniqueDeviceId
 @return        UniqueDeviceId
 */
+(NSString *)getUniqueDeviceId;


/*!
 @abstract      dateTochangeSlashNotifications
 @param         datestr
 @discussion    Function that returns dateTochangeSlashNotifications
 @return        dateTochangeSlashNotifications
 */
+(NSString *)dateTochangeSlashNotifications:(NSString *)dateStr;

//=========================================================================//



/*!
@abstract      saveName
@param         string
@discussion    Function save the stringvalue
@return        nil value
*/
+(void)saveName:(NSString *)Name;
/*!
 @abstract      getName
 @param         nil
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString *)getName;
/*!
 @abstract       saveEmail
 @param          string
 @discussion     Function save the stringvalue
 @return         nil value
 */
+(void)saveEmail:(NSString *)type;
/*!
 @abstract      getEmail
 @param         nil
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString *)getEmail;
/*!
 @abstract      savePhoneno
 @param         int
 @discussion    Function save the stringvalue
 @return        nil value
 */
+(void)savePhoneno:(NSString *)type;
/*!
 @abstract      getPhoneno
 @param         nil
 @discussion    Function that returns the string value
 @return        String value
 */
+(NSString *)getPhoneno;
/*!
 @abstract      insertZImageInLabelAtLastPositionWithTwoStrings
 @param         integer and string and float and color and float image values
 @discussion    Function that returns the string value with image
 @return        String value with image value
 */
+(NSAttributedString *)insertZImageInLabelAtLastPositionWithTwoStrings:(UILabel *)label withImageName:(NSString *)imageName withFont:(UIFont *)font andTextColor:(UIColor *)textColor andto:(NSString *)to and:(NSString *)text withImageName:(NSString *)imageName2 withFont:(UIFont *)font2  and:(NSString *)text2 andAlignment:(NSTextAlignment)alignment :(int )width :(int)height;
/*!
 @abstract      flattenHTML
 @param         htmltagsString
 @discussion    Function that returns remove the html tags in astring
 @return        string
 */
+(NSString *) flattenHTML:(NSString *)html;
/*!
 @abstract      dateFormateforepire
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString *)dateFormateforepire:(NSString *)dateStr;
/*!
 @abstract      dateFormatefordispached
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString *)dateFormatefordispached:(NSString *)dateStr;
/*!
 @abstract      unarchiveForKey
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+ (NSDictionary *)unarchiveForKey:(NSString *)key;
/*!
 @abstract      archive
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(BOOL)archive:(NSDictionary *)dict withKey:(NSString *)key;
/*!
 @abstract      roundtheValue
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString*)roundtheValue : (NSString*)roundedString;
/*!
 @abstract      dateFormateforCashback
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString *)dateFormateforCashback:(NSString *)dateStr;
/*!
 @abstract      getExpiryDateFormatString
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString *)getExpiryDateFormatString:(NSString *)dateStr;
/*!
 @abstract      offersDetailWithImag
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSAttributedString*)offersDetailWithImag :(NSString*)textData;
/*!
 @abstract      gettingPlistUsingDictonary
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)gettingPlistUsingDictonary;
/*!
 @abstract      savePlistUsingDictonary
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)savePlistUsingDictonary :(NSDictionary*)dataDict;
/*!
 @abstract      getAddressbookdetails
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
//addressbook contacts get
+ (NSArray *)getAddressbookdetails;


/*!
 @abstract      sendingUserdatatoHotLineServer
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
-(void)sendingUserdatatoHotLineServer;


/*!
 @abstract      setBorderViewLessAlpha
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(UIView*) setBorderViewLessAlpha: (UIView*)viewOfCurrent :(float)cornerRadiseValue :(UIColor*)color;
/*!
 @abstract      ChatImagecompressingImageData
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSData *)ChatImagecompressingImageData :(UIImage *)image;
/*!
 @abstract      topViewController
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+ (UIViewController*) topViewController;


/*!
 @abstract      getDateFromMilliseconds
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDate *)getDateFromMilliseconds:(NSString *)timeStamp;
/*!
 @abstract      getChatTimeFromString
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDate *)getChatTimeFromString:(NSString *)dateStr;
/*!
 @abstract      getChatTimeFromDate
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString *)getChatTimeFromDate;
/*!
 @abstract      saveDeviceTokenData
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(void)saveDeviceTokenData:(NSData *)tokenData;
/*!
 @abstract      getDeviceTokenData
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSData *)getDeviceTokenData;
/*!
 @abstract      getErrorMessageForStatus
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString *)getErrorMessageForStatus:(NSInteger)status;
/*!
 @abstract      compareStringChecking
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString*)compareStringChecking : (NSString*)sendingString;
/*!
 @abstract      displayToastWithMessage
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(void)displayToastWithMessage:(NSString *)toastMessage;
/*!
 @abstract      displayNotificationToast
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(void)displayNotificationToast :(NSString *)title andMessage :(NSString *)message;
/*!
 @abstract      stringByTrimmingLeadingWhitespace
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSString*)stringByTrimmingLeadingWhitespace :(NSString *)string;
/*!
 @abstract      convertBoldOneWorddifferentColor
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */


+ (NSAttributedString *)convertBoldOneWorddifferentColor :(NSString *)sendingStr :(NSString*)changeStr;

+ (UIImage *)image:(UIImage *)image withBottomHalfOverlayColor:(UIColor *)color andRatingDecimal:(float)fraction;
/*!
 @abstract      saveContactsUpdateStatus
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(void)saveContactsUpdateStatus:(BOOL)status;
/*!
 @abstract      getContactsUpdateStatus
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(BOOL)getContactsUpdateStatus;
/*!
 @abstract      latLongSaveServiceCall
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(void)latLongSaveServiceCall;
/*!
 @abstract      saveLocationsPlistUsingDictonary
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)saveLocationsPlistUsingDictonary :(NSDictionary*)dataDict;
/*!
 @abstract      saveDealTypesPlistUsingDictonary
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)saveDealTypesPlistUsingDictonary :(NSDictionary*)dataDict;
/*!
 @abstract      saveCusinesPlistUsingDictonary
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)saveCusinesPlistUsingDictonary :(NSDictionary*)dataDict;
/*!
 @abstract      saveCategoriesPlistUsingDictonary
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)saveCategoriesPlistUsingDictonary :(NSDictionary*)dataDict;
/*!
 @abstract      saveCustomDealVenutypesPlistUsingDictonary
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)saveCustomDealVenutypesPlistUsingDictonary :(NSDictionary*)dataDict;
/*!
 @abstract      gettingPlistUsingDictonaryCategories
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)gettingPlistUsingDictonaryCategories;
/*!
 @abstract      gettingPlistUsingDictonaryCusines
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)gettingPlistUsingDictonaryCusines;
/*!
 @abstract      gettingPlistUsingDictonaryDeals
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)gettingPlistUsingDictonaryDeals ;
/*!
 @abstract      gettingPlistUsingDictonaryLocations
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)gettingPlistUsingDictonaryLocations;
/*!
 @abstract      gettingPlistUsingDictonaryCustomDealVenutypes
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */
+(NSDictionary*)gettingPlistUsingDictonaryCustomDealVenutypes;


+(NSDictionary*)gettingPlistMainCitiesPlistUsingDictonary;

+(NSDictionary*)saveMainCitiesPlistUsingDictonary :(NSDictionary*)dataDict;
/*!
 @abstract      propblemForRemove
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */

+(void)propblemForRemove;
/*!
 @abstract      advertiserID
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */

+(NSString *)advertiserID;
/*!
 @abstract      sendingDataToMoengage
 @param         int
 @discussion    Function that returns the string value
 @return        string value
 */

+(void)sendingDataToMoengage :(NSString*)trackEventName;
+(void)animationParticularImageBlinking:(UIImageView*)blinkingImageView :(NSInteger)repetCountValue;
+(void)animationZoomZoomOutBtn : (UIButton*)button : (NSInteger)intvalueFOrRepet;
+ (void)callWithString:(NSString *)phoneString;
+(void)addShadowtoButton :(UIButton*)senderBtn;
+(void)addShadowtoImage:(UIImageView*)senderimageview;
+(void)addShadowtoView :(UIView*)senderView;
+(void)addShadowtoView1 :(UIView*)senderView :(NSString*)colorName;
+(void)addShadowtoImagea:(UIImageView*)senderimageview :(NSString*)ColorString;
+(NSArray *)filterArrayMethod :(NSMutableArray*)mainArr;
+(void)addShadowtoButtoncolor: (UIButton *)button :(NSString*)colorString;
+(NSString*)OpenRestaurantBetweenTheseTimes : (NSString*)SelectedTime;
+(NSString*)appendStringToanotherString :(NSString*)currentString :(NSString*)sendingString;
+(NSString *)percentEscapeString:(NSString *)string;

+ (CAShapeLayer *)customToggleButton;
+(void) changeTextfieldTextColor:(NSArray *)textFieldsArray and:(BOOL)isRegister;
+(BOOL)validateMobileOREmail:(NSString *)text error:(NSString **)error;
+(NSString *)locationNameWith :(NSDictionary *)locationObj;
//helthey pet
+(void)SaveAuthKey:(NSString *)type;
+(NSString *)getAuthKey;
+(void)SaveUserType:(NSString *)type;
+(NSString *)getUserType;

+(NSString *)getDateFormatStringToTime:(NSString *)dateStr;

+(void) changeTextfieldTextColorChangePassword:(NSArray *)textFieldsArray and:(BOOL)isRegister;


+(NSString *)convertDateFormate:(NSString *)dateStr;
+(void)saveDeviceToken:(NSString *)deviceToken;
+(NSString *)getDeviceToken;
//MealShack

+(void)SaveCode:(NSString *)type;
+(NSString *)getCode;


+(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude;


//shopality
+(void)SaveUserID:(NSString *)type;
+(NSString *)getUserID;
//+(void)saveUserId :(NSString *)user_id;
+ (void) deleteALLEntityInDB;
+ (NSManagedObjectContext *)managedObjectContext;
+(void)SaveTax:(NSString *)type;
    +(NSString *)getTax;
+(void)SaveOpentime:(NSString *)type;
+(NSString *)getopenTime;
+(void)SaveCloseTime:(NSString *)type;
+(NSString *)getCloseTime;
+(void)Savedelivery_slot_duration:(NSString *)type;
+(NSString *)getdelivery_slot_duration;
+(void)SaveGranTotal:(NSString *)type;
+(NSString *)getSaveGranTotal;
+(void)SaveDeliveryTime:(NSString *)type;
+(NSString *)getDeliveryTime;


//merchant methods
// saving OPEN TIME
+(void)Saveimageurl:(NSString *)type;
+(NSString *)getimageurl;
// saving CLOSE TIME
+(void)SaveCloseTime_machant:(NSString *)type;
+(NSString *)getCloseTime_merchant;
// saving Item Category ID
+(void)SaveItemCategoryID:(NSString *)type;
+(NSString *)getItemCategoryID;
// Save DeliveryCompanyID
+(void)SaveDeliveryCompanyID:(NSString *)type;
+(NSString *)getDeliveryCompanyID;
+(void)SaveCmsID:(NSString *)type;
+(NSString *)getCmsID;


+(void)saveMobileno:(NSString *)type;
+(NSString *)getMobileno;

//helper method for color hex values
+ (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

@end


