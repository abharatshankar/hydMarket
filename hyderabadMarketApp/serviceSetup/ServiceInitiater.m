//
//  ServiceInitiater.m
//  Jobaap
//
//  Created by  on 25/08/15.
//  Copyright (c) 2015 . All rights reserved.
//


#import "ServiceInitiater.h"
#import "ServiceManager.h"
#import "Constants.h"

@implementation ServiceInitiater

+(ServiceInitiater *) sharedInstance
{
    static ServiceInitiater *_sharedInstance = nil;
    if (!_sharedInstance) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _sharedInstance = [[ServiceInitiater alloc] init];
        });
    }
    return _sharedInstance;
}

- (void)requestQuoteForSymbol:(NSString *)symbol :(NSDictionary *)request :(NSString *)method withCallback:(responseSuccessCompletionBlock)callback
{
    
    ServiceManager *connection = [ServiceManager sharedInstance];
    
    [connection executeRequestOnSuccess:^(BOOL isSuccess, NSDictionary *result)
     {
         callback(YES,result);
     } failure:^(NSError *error, NSDictionary *errorMsg){
         callback(NO, errorMsg);
     }urlString:symbol methodType:method requestDic:request
     ];
}

- (void)placeOrderRequestforSymbol:(NSString *)embeddedUrl
                                  :(NSDictionary *)request
                                  :(NSString *)method
                      withCallback:(responseSuccessCompletionBlock)callback
{
    ServiceManager *connection = [ServiceManager sharedInstance];
    
    [connection placeOrderRequestOnSuccess:^(BOOL isSuccess, NSDictionary *result)
     {
         callback(YES,result);
         
     } failure:^(NSError *error, NSDictionary *errorMsg){
         callback(NO, errorMsg);
     } urlString:embeddedUrl requestDict:request methodType:method];
    
}

- (void)requestForLocationsSearchWithCallback:(responseSuccessCompletionBlock)callback
{
//    ServiceManager *connection = [ServiceManager sharedInstance];
//    
//    //[connection locationsRequestOnSuccess:^(BOOL isSuccess, NSDictionary *result)
//    {
//        callback(YES,result);
//    
//    }failure:^(NSError *error){
//        callback(NO, nil);
//    }];
}


- (void)contactSynForSymbol :(NSString *)urlStr
                            :(NSDictionary *)request
                            :(NSString *)method
               withCallback :(responseSuccessCompletionBlock)callback
{
    ServiceManager *connection = [ServiceManager sharedInstance];
    
    [connection executeRequestForContactsSyncOnSuccess:^(BOOL isSuccess, NSDictionary *result)
    {
        callback(YES, result);
    }failure:^(NSError *error, NSDictionary *errorMsg){
        callback(NO, errorMsg);
    } urlString:urlStr methodType:method requestDic:request];
    
}


@end
