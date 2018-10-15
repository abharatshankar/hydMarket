//
//  SingleTon.h
//  SingleTonDataPassing
//
//  Created by Bharat shankar on 01/03/17.
//  Copyright © 2017 Edu.Self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SingleTon : NSObject


@property NSString * barsCountStr,
                   *loungeCountStr,
                   *clubCountStr,
                   *restaurantsStr; // these strings are to take array count from landed_pages and send it to profile page

@property NSString * imgUrlStr;

@property CGFloat  mostPopLatiNum ;
@property CGFloat mostPopLongiNum;
@property BOOL isMostPopularClicked;

@property NSMutableDictionary *summaryDict;

@property NSString * devicetoken;

@property NSString * toDetectLocationStr;
@property BOOL  isForEventPage, isHomeFilter;

@property NSString * userRatingStr;

@property NSMutableArray * offersArray , *latitudeArray , *longitudeArray;
@property NSMutableDictionary * dixFromAnimation2Profile;

@property NSMutableArray * barsArray,
                         * barsArrayReady,
                         *loungeArray,
                         *ClubsArray,
                         *restaurantsArray;

@property NSData * profilePicData; // save from edit profile to profile

@property NSString * profilePicName; //after saved in edit profile

@property NSString * profilePicImageUrlString;

@property NSDictionary * dixFromLogin;

@property (nonatomic, strong) NSArray *mapItemList;
@property NSString  *startDateStr,
                    *endDateStr,
                    *showTimeStr,
                    *endTimeStr,
                    *descriptionStr,
                    *eventNameSt,
                    *areaName;

@property NSString * areaNameForCreateEvent;

@property CGFloat  latiNum ;
@property CGFloat longiNum;
// these are for eventReady to menu page
@property CGFloat  latiNumTomenu ;
@property CGFloat longiNumTomenu;



@property MKMapItem *mapItem,* mapItemForEventPage;

@property NSString * areaNameForEventPage;

@property NSData *editEventImgData;

@property NSMutableData * eventImgData ;

@property NSMutableArray * filterResultArray;



@property NSMutableArray * invitesSendArray,*requireArrayToSend,*invitesSendArr,*contactsSendArray;
@property NSString * startDateToServer,
                    *endDateToServer,
                    *startTimeToServer,
                    *endTimeToServer,
                    *addressToServer,
                    *eventUploadedImageName,
                    *editEventUploadedImageName;




@property NSString  * editedEventName,
                    *editedEventStartDate,
                    *editedEventStartTime,
                    *editedEventStartTimeToServer,
                    *editedEventStartDateToServer,

                    *editedEventEndDate,
                    *editedEventLocation,
                    *editedEventDescription,
                    *editedEventEndDateToServer,
                    *editedEventEndTime,
                    *editedEventEndTimeToServer,
                    *areaNameForEditEvent,
                    *addressToServerForEditPage;

@property BOOL  isDateAvailable,
                isLocationAvailable,
                isDescriptionAvailable;

@property BOOL isFriendAdded;

@property BOOL  isLocationChanged;

@property NSString * eventIdStr;

@property (nonatomic, strong) NSArray *mapItemListForEditPage;
@property (nonatomic, strong) NSArray *mapItemsForcreateEventPage;


@property NSString * voteOption1,* voteOption2,* voteOption3,* voteOption4, * voteQuestion;
@property NSMutableArray * votesArray;


//for filters page to store previous selected options
@property NSMutableArray
                         * locationOptions,
                         * cusinesOptions,
                         * categoriesOptions;
@property NSString * sortByOptions;

+(id)singleTonMethod;
+ (void)resetSharedInstance ;



@end
