//
//  ServiceManager.h
//  Jobaap
//
//  Created by  on 21/08/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OnSuccess) (BOOL status, NSDictionary *result);
typedef void (^OnFailure) (NSError *error, NSDictionary *info);

@protocol ServiceHandlerDelegate <NSObject>

@required
- (void)responseDic:(NSDictionary *)info;

@optional
- (void)failResponse:(NSError*)error;
- (void)clientRequestFailed:(NSDictionary *)errorInfo;
@end
@interface ServiceManager : NSObject

@property (nonatomic, assign) id <ServiceHandlerDelegate> delegate;
@property (copy, nonatomic) OnSuccess onSuccess;
@property (copy, nonatomic) OnFailure onFailure;

+(ServiceManager *) sharedInstance;
/*!
 @abstract      uploadFile
 @param         nsstring,NSDictionary
 @discussion    this method used to upload the images to server
 @return        nill
 */


- (NSDictionary *)uploadFile:(NSString *)urlString info:(NSDictionary*)reqDict;

/*!
 @abstract      handleRequestWithDelegates
 @param         nsstring,NSDictionary
 @discussion    this method used to handleRequestWithDelegates to server
 @return        nill
 */

- (void)handleRequestWithDelegates :(NSString *)urlString info:(NSDictionary *)reqDict;
- (void)handleRequestWithDelegatesLandingPage :(NSString *)urlString info:(NSDictionary *)reqDict;
- (void)executeRequestOnSuccess:(OnSuccess)onSuccessBlock
                        failure:(OnFailure)onFailureBlock
                      urlString:(NSString *)url
                     methodType:(NSString *)method
                     requestDic:(NSDictionary *)info;

- (void)executeRequestForContactsSyncOnSuccess:(OnSuccess)onSuccessBlock
                                       failure:(OnFailure)onFailureBlock
                                     urlString:(NSString *)url
                                    methodType:(NSString *)method
                                    requestDic:(NSDictionary *)info;

- (void)placeOrderRequestOnSuccess:(OnSuccess)onSuccessBlock
                           failure:(OnFailure)onFailureBlock
                         urlString:(NSString *)url
                       requestDict:(NSDictionary *)info
                        methodType:(NSString *)method;

/*!
 @abstract      LinkedInOAuthAuthorizationRequestOnSuccess
 @discussion    this method used to LinkedInOAuthAuthorizationRequestOnSuccess
 @return        nill
 */

- (void)LinkedInOAuthAuthorizationRequestOnSuccess:(OnSuccess)onSuccessBlock
                                           failure:(OnFailure)onFailureBlock
                                         urlString:(NSString *)url;
/*!
 @abstract      suggestableLocations
 @param         nsstring
 @discussion    this method used to suggestableLocations to searching
 @return        nill
 */

-(void)suggestableLocations:(NSString *)searchString;
- (NSDictionary *)getAllData :(NSString*)methodTypeStr;
/*!
 @abstract      uploadingMultipleImagesAndDataForReview
 @param         nsstring,NSDictionary,NSMutableArray
 @discussion    this method used to uploadingMultipleImages to searching
 @return        nill
 */


-(void)uploadingMultipleImagesAndDataForReview:(NSDictionary*)requestDict :(NSMutableArray*)imagedataArray :(NSString*)urlStr;
- (NSDictionary *)getAllDataForRedeem :(NSString*)methodTypeStr;

/*!
 @abstract      redeemGetServiceCall
 @param         nsstring
 @discussion    this method used to redeemGetServiceCall to server
 @return        nill
 */

-(void)redeemGetServiceCall :(NSString *)urlString;
-(void)handleRegistration :(NSString *)urlString info:(NSDictionary *)reqDict andMethod:(NSString *)method;
- (NSDictionary *)getAllDataService : (NSString*)urlStr;
/*!
 @abstract      getdataFromFaqs
 @param         nsstring
 @discussion    this method used to getdataFromFaqs to server(GET)
 @return        NSDictionary
 */

- (NSDictionary *)getdataFromFaqs :(NSString*)urlStr;
-(void)handleGetLandingData :(NSString *)urlString info:(NSDictionary *)reqDict;
-(void)orderHistoryService:(NSString *)reqUrl info:(NSDictionary *)dict;
- (void)handleRequestWithDelegates_param :(NSString *)urlString info:(NSDictionary *)reqDict;

/*!
 @abstract      handleRequestWithDelegates_string
 @param         nsstring
 @discussion    this method used to handleRequestWith string to server(GET)
 @return        nil
 */

- (void)handleRequestWithDelegates_string :(NSString *)urlString info:(NSString *)parameter;
-(void)gettingCurrentLocatoion : (NSString *)latitude : (NSString *) langtitude;
-(void)getLocationswithStrig:(NSString*)searchString;


@end
