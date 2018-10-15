//
//  ServiceInitiater.h
//  Jobaap
//
//  Created by  on 25/08/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void (^responseSuccessCompletionBlock) (BOOL wasSuccessful, NSDictionary *result);

@interface ServiceInitiater : NSObject

+(ServiceInitiater *) sharedInstance;



- (void)requestForLocationsSearchWithCallback:(responseSuccessCompletionBlock)callback;

//- (void)requestForLinkedInAuthorizationCode:(NSString *)embeddedUrl
                               //withCallback:(responseSuccessCompletionBlock)callback;


- (void)placeOrderRequestforSymbol:(NSString *)embeddedUrl
                                  :(NSDictionary *)request
                                  :(NSString *)method
                      withCallback:(responseSuccessCompletionBlock)callback;


- (void)requestQuoteForSymbol:(NSString *)url
                             :(NSDictionary *)request
                             :(NSString *)method
                 withCallback:(responseSuccessCompletionBlock)callback;


- (void)contactSynForSymbol :(NSString *)urlStr
                            :(NSDictionary *)request
                            :(NSString *)method
               withCallback :(responseSuccessCompletionBlock)callback;


@end

