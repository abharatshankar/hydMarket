                                                             
//  ServiceManager.m
//  Jobaap
//
//  Created by  on 21/08/15.
//  Copyright (c) 2015 . All rights reserved.
//

/*!
 ->  ServiceManager used for.
 
 -> in this controller displaying all services handling methods
 
 */

#import "ServiceManager.h"
#import <CoreData/CoreData.h>
#import "Constants.h"
#import "Utilities.h"
//#import "GM_AES128_CTR.h"
#import "AFHTTPRequestOperationManager.h"
#import "Utilities.h"
@implementation ServiceManager
@synthesize onFailure,onSuccess;

+(ServiceManager *) sharedInstance
{
    static ServiceManager *_sharedInstance = nil;
    if (!_sharedInstance) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _sharedInstance = [[ServiceManager alloc] init];
        });
    }
    return _sharedInstance;
}

- (void)executeRequestOnSuccess:(OnSuccess)onSuccessBlock
                        failure:(OnFailure)onFailureBlock
                      urlString:(NSString *)url
                     methodType:(NSString *)method
                     requestDic:(NSDictionary *)info
{
    self.onSuccess = onSuccessBlock;
    self.onFailure = onFailureBlock;
    
    [self handleRedeemRequestWithBlocks:url info:info andMethod:method];
}

- (void)executeRequestForContactsSyncOnSuccess:(OnSuccess)onSuccessBlock
                                       failure:(OnFailure)onFailureBlock
                                     urlString:(NSString *)url
                                    methodType:(NSString *)method
                                    requestDic:(NSDictionary *)info
{
    self.onSuccess = onSuccessBlock;
    self.onFailure = onFailureBlock;
    [self handleContactsSynRequestWithBlocks:url info: info andMethod: method];
}

- (void)placeOrderRequestOnSuccess:(OnSuccess)onSuccessBlock
                           failure:(OnFailure)onFailureBlock
                         urlString:(NSString *)url
                       requestDict:(NSDictionary *)info
                        methodType:(NSString *)method
{
    self.onSuccess = onSuccessBlock;
    self.onFailure = onFailureBlock;
    [self placeOrder:url andRequest:info :method];
}



- (void)LinkedInOAuthAuthorizationRequestOnSuccess:(OnSuccess)onSuccessBlock
                                           failure:(OnFailure)onFailureBlock
                                         urlString:(NSString *)url
{
    self.onSuccess = onSuccessBlock;
    self.onFailure = onFailureBlock;
    //[self getAuthorizationCodeFromLinkedIn:url];
}
- (void)handleRequestWithDelegates_string :(NSString *)urlString info:(NSString *)parameter
{
    
    // creating a NSMutableURLRequest that we can manipulate before sending
    //urlString = [NSString stringWithFormat:@"%@/%@",BASE_URL,urlString];
    
    
    //    NSString *parameter = [NSString stringWithFormat:@"username=%@&password=%@",username, password];
    
    NSString * jsonString = parameter;
    NSData * data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error = nil;
    id parameterData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
//    NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
//    [theRequest addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setHTTPMethod:@"POST"];
    NSLog(@"TOKENID : %@",[USERDEFAULTS valueForKey:@"TOKENID"]);
    [theRequest setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];

    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // the boundary string. Can be whatever we want, as long as it doesn't appear as part of "proper" fields
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    NSString *contentType = [NSString stringWithFormat:@"application/json; boundary=%@", boundary];
    [theRequest setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // assigning the completed NSMutableData buffer as the body of the HTTP POST request
    
    

    
    [theRequest setHTTPBody:parameterData];
    
    //    [theRequest addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *res ,NSData*data,NSError *err)
     {
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
         
         NSLog(@"%@",dict);
         
         
         
         
         //
         //         NSURLResponse * response = nil;
         NSError * error = nil;
         //         NSData * data = [NSURLConnection sendSynchronousRequest:request
         //                                               returningResponse:&response
         //                                                           error:&error];
         
         NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         
         NSLog(@"response = %@",myString);
         
         if (error) {
             if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                 [self.delegate failResponse:error];
         }
         else{
             if (data) {
                 NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                 
                 if (jsonDictionary) {
                     if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                         [self.delegate responseDic:jsonDictionary];
                     
                     
                 }
                 else{
                     if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                         [self.delegate failResponse:error];
                     
                 }
             }
         }
     }];
    
    
}

- (void)handleRequestWithDelegates_param :(NSString *)urlString info:(NSDictionary *)reqDict
{
    
    // creating a NSMutableURLRequest that we can manipulate before sending
    //urlString = [NSString stringWithFormat:@"%@/%@",BASE_URL,urlString];
    NSURL *theURL =[NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    
    // setting the HTTP method
    [request setHTTPMethod:@"POST"];
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];
    
    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // the boundary string. Can be whatever we want, as long as it doesn't appear as part of "proper" fields
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"application/json; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
          // assigning the completed NSMutableData buffer as the body of the HTTP POST request
    
    NSError *error1;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:reqDict options:0 error:&error1];

    
    
    [request setHTTPBody:postdata];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    //    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //@"response = %@",myString);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    if (!error) {
        
    }
    else {
        //@"something went wrong: %@", [error userInfo]);
    }
    
    
    // NSLog( @"~~~~~ httpResponse: %@",httpResponse);
    
    //NSLog(@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
    
    if([httpResponse statusCode] == 500){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate failResponse:error];
            
            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });
        //[Utilities getErrorMessageForStatus:[httpResponse statusCode]];
    }
    else{
        if (error) {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                [self.delegate failResponse:error];
        }
        else{
            if (data) {
                NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                
                if (jsonDictionary) {
                    @try {
                        if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                            [self.delegate responseDic:jsonDictionary];
                    }
                    @catch (NSException *exception) {
                        //@"%@", exception.reason);
                    }
                    @finally {
                        //@"Char at index %d cannot be found", index);
                    }
                    
                }
                else{
                    if (jsonDictionary == nil && data.length > 0)
                    {
                        
                        //NSString * myString1 = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                        
                        //NSLog(@"%@",myString1);
                        NSString * myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        NSString *complete = [NSString stringWithFormat:@"%@%@", myString,@"\"}"];
                        
                        NSData *data = [complete dataUsingEncoding:NSUTF8StringEncoding];
                        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                            [self.delegate responseDic:json];
                        
                        
                    }
                    else
                        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                            [self.delegate failResponse:error];
                    
                }
            }
        }
    }
    
}

- (void)handleRequestWithDelegates :(NSString *)urlString info:(NSDictionary *)reqDict
{
    
    // creating a NSMutableURLRequest that we can manipulate before sending
    //urlString = [NSString stringWithFormat:@"%@/%@",BASE_URL,urlString];
    NSURL *theURL =[NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    
    // setting the HTTP method
    [request setHTTPMethod:@"POST"];
//    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];
    
    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // the boundary string. Can be whatever we want, as long as it doesn't appear as part of "proper" fields
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // we need a buffer of mutable data where we will write the body of the request
    NSMutableData *body = [NSMutableData data];
    
    // writing the basic parameters
    for (NSString *key in reqDict) {
        
        if ([key isEqualToString:@"KEY"]) {
            continue;
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n",[reqDict objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    // NSTimeInterval is defined as double
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    
    if ([reqDict valueForKey:@"FileData"] && [reqDict valueForKey:@"KEY"]) {
        
        NSString *imageName = [NSString stringWithFormat:@"logo%@.png",timeStampObj];
        // creating a NSData representation of the image
        NSData *imageData = [NSData dataWithData:[reqDict objectForKey:@"FileData"]];
        
        // if we have successfully obtained a NSData representation of the image
        
        if (imageData) {
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",[reqDict valueForKey:@"KEY"], imageName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:imageData]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
    }
    if ([reqDict valueForKey:@"OfficeImageData"] && [reqDict valueForKey:@"OFFICE_KEY"]) {
        NSString *resumeName = [NSString stringWithFormat:@"office%@",timeStampObj];
        // creating a NSData representation of the image
        NSData *resumeData = [NSData dataWithData:[reqDict objectForKey:@"OfficeImageData"]];
        // if we have successfully obtained a NSData representation of the image
        if (resumeData) {
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",[reqDict valueForKey:@"OFFICE_KEY"], resumeName] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[NSData dataWithData:resumeData]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    // assigning the completed NSMutableData buffer as the body of the HTTP POST request
    [request setHTTPBody:body];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    //    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //@"response = %@",myString);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    if (!error) {
        
    }
    else {
        //@"something went wrong: %@", [error userInfo]);
    }
    
    
    // NSLog( @"~~~~~ httpResponse: %@",httpResponse);
    
    //NSLog(@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
    
    if([httpResponse statusCode] == 500)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate failResponse:error];
            
            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });
        //[Utilities getErrorMessageForStatus:[httpResponse statusCode]];
    }
    else{
        if (error) {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                [self.delegate failResponse:error];
        }
        else{
            if (data)
            {
                
                NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"Print : %@",jsonString);
                if (jsonDictionary) {
                    @try {
                        
                        if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                            [self.delegate responseDic:jsonDictionary];
                    }
                    @catch (NSException *exception) {
                        //@"%@", exception.reason);
                    }
                    @finally {
                        //@"Char at index %d cannot be found", index);
                    }
                    
                }
                else{
                    if (jsonDictionary == nil && data.length > 0)
                    {
                        
                        //NSString * myString1 = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                        
                        //NSLog(@"%@",myString1);
                        NSString * myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        NSString *complete = [NSString stringWithFormat:@"%@%@", myString,@"\"}"];
                        
                        NSData *data = [complete dataUsingEncoding:NSUTF8StringEncoding];
                        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                            [self.delegate responseDic:json];
                        
                        
                    }
                    else
                        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                            [self.delegate failResponse:error];
                    
                }
            }
        }
    }
}


- (void)handleRequestWithDelegatesLandingPage :(NSString *)urlString info:(NSDictionary *)reqDict
{
    
    // creating a NSMutableURLRequest that we can manipulate before sending
    //urlString = [NSString stringWithFormat:@"%@/%@",BASE_URL,urlString];
    
    NSURL *theURL =[NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    
    // setting the HTTP method
    [request setHTTPMethod:@"POST"];
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];

    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // the boundary string. Can be whatever we want, as long as it doesn't appear as part of "proper" fields
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // we need a buffer of mutable data where we will write the body of the request
    NSMutableData *body = [NSMutableData data];
    
    // writing the basic parameters
    for (NSString *key in reqDict) {
        
        if ([key isEqualToString:@"KEY"]) {
            continue;
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n",[reqDict objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];

    }
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    // NSTimeInterval is defined as double
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    
    if ([reqDict valueForKey:@"FileData"] && [reqDict valueForKey:@"KEY"]) {
        
        NSString *imageName = [NSString stringWithFormat:@"logo%@.png",timeStampObj];
        // creating a NSData representation of the image
        NSData *imageData = [NSData dataWithData:[reqDict objectForKey:@"FileData"]];
        
        // if we have successfully obtained a NSData representation of the image
        
        if (imageData) {
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",[reqDict valueForKey:@"KEY"], imageName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:imageData]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
    }
    if ([reqDict valueForKey:@"OfficeImageData"] && [reqDict valueForKey:@"OFFICE_KEY"]) {
        NSString *resumeName = [NSString stringWithFormat:@"office%@",timeStampObj];
        // creating a NSData representation of the image
        NSData *resumeData = [NSData dataWithData:[reqDict objectForKey:@"OfficeImageData"]];
        
        // if we have successfully obtained a NSData representation of the image
        
        if (resumeData) {
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",[reqDict valueForKey:@"OFFICE_KEY"], resumeName] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[NSData dataWithData:resumeData]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    // assigning the completed NSMutableData buffer as the body of the HTTP POST request
    [request setHTTPBody:body];
    
    //NSURLResponse * response = nil;
    NSError * error = nil;
  
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        if (error)
        {
            //@"response = %@",myString);
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (!error) {
//                NSString *responseURL_get2 = [[httpResponse URL] absoluteString];           // null value
//                NSString *responseTextEncodingName_get2 = [httpResponse textEncodingName];  // null value
//                NSString *responseMIMEType_get2 = [httpResponse MIMEType];                  // null value
//                NSInteger *responseStatusCode_get2 = [httpResponse statusCode]; //[responseStatusCode intValue]; // the status code is 0
                
            }
            else {
                //@"something went wrong: %@", [error userInfo]);
            }
            
            
            NSLog( @"~~~~~ httpResponse: %@",httpResponse);
            
            NSLog(@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
            
            if([httpResponse statusCode] == 500){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate failResponse:error];
                    
                    [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
                });
                //[Utilities getErrorMessageForStatus:[httpResponse statusCode]];
            }
            
            else if([httpResponse statusCode] == 0){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate failResponse:error];
                    
                });
            }

            
            else{
                if (error) {
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                        [self.delegate failResponse:error];
                }
                
                
            }        }
        else
        {
            if (data) {
                NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                
                if (jsonDictionary) {
                    @try {
                        if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                            [self.delegate responseDic:jsonDictionary];
                    }
                    @catch (NSException *exception) {
                        //@"%@", exception.reason);
                    }
                    @finally {
                        //@"Char at index %d cannot be found", index);
                    }
                    
                }
                else{
                    if (jsonDictionary == nil && data.length > 0)
                    {
                        NSError * err;
                        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:&err];
                        
                        NSString * myString1 = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"%@",myString1);
                        NSString * myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        NSString *complete = [NSString stringWithFormat:@"%@%@", myString,@"\"}"];
                        
                        NSData *data = [complete dataUsingEncoding:NSUTF8StringEncoding];
                        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                            [self.delegate responseDic:json];
                        
                        
                    }
                    else
                        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                            [self.delegate failResponse:error];
                    
                }
            }
        }
    }];
    
    
}

- (NSDictionary *)getAllData :(NSString*)methodTypeStr
{
    
    
    @try {
        NSURL *theURL;
        if([methodTypeStr isEqualToString:@"merchant_categories"]||[methodTypeStr isEqualToString:@"deal_types"])
        {
            theURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL2,methodTypeStr]];
            
        }
        
        else if ([methodTypeStr isEqualToString:@"cuisines"]){
            theURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,methodTypeStr]];
            
        }
        else if ([methodTypeStr isEqualToString:@"GraceTime"]){
            theURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL2,methodTypeStr]];
            
        }
        else
        {
            theURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL2,methodTypeStr]];
            
        }
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
        NSDictionary *jsonDictionary ;
        // setting the HTTP method
        [request setHTTPMethod:@"GET"];
        [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];
        
        // we want a JSON response
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        // the boundary string. Can be whatever we want, as long as it doesn't appear as part of "proper" fields
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        
        // setting the Content-type and the boundary
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        
        
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:&response
                                                          error:&error];
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (!error) {
//            NSString *responseURL_get2 = [[httpResponse URL] absoluteString];           // null value
//            NSString *responseTextEncodingName_get2 = [httpResponse textEncodingName];  // null value
//            NSString *responseMIMEType_get2 = [httpResponse MIMEType];                  // null value
//            NSInteger *responseStatusCode_get2 = [httpResponse statusCode]; //[responseStatusCode intValue]; // the status code is 0
        }
        else
        {
            NSLog(@"something went wrong: %@", [error userInfo]);
        }
        
        //@"~~~~~ httpResponse: %@",httpResponse);
        //@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
        if([httpResponse statusCode] == 500){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate failResponse:error];
                
                [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
            });    }
        else{
            if (error) {
                if (self.onFailure) {
                    
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                        [self.delegate failResponse:error];
                }
            }
            else{
                if (data) {
                    
                    jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                    
                    if (jsonDictionary) {
                        if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                            [self.delegate responseDic:jsonDictionary];
                        return jsonDictionary;
                    }
                    else{
                        
                        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                            [self.delegate failResponse:error];
                    }
                    
                }
                
                
            }
        }
        return jsonDictionary;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    @finally {
    }
   
}
- (NSDictionary *)getAllDataForRedeem :(NSString*)methodTypeStr
{
    @try {
        NSURL *theURL;
        theURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL,methodTypeStr]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
        NSDictionary *jsonDictionary ;
        // setting the HTTP method
        [request setHTTPMethod:@"GET"];
        
        // we want a JSON response
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        // setting the Content-type and the boundary
        NSString *contentType = [NSString stringWithFormat:@"application/json"];
        //[request setValue:@"Token token=627ce19c8ee08edde5ce6b25f5b18fcf;device_id=123456" forHTTPHeaderField:@"Authorization"];
        [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:&response
                                                          error:&error];
        
        NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"response = %@",myString);

        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [USERDEFAULTS setObject:[json valueForKey:@"message"] forKey:@"ExpiredToken"];
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (!error)
        {
//            NSString *responseURL_get2 = [[httpResponse URL] absoluteString];           // null value
//            NSString *responseTextEncodingName_get2 = [httpResponse textEncodingName];  // null value
//            NSString *responseMIMEType_get2 = [httpResponse MIMEType];                  // null value
//            NSInteger *responseStatusCode_get2 = [httpResponse statusCode]; //[responseStatusCode intValue]; // the status code is 0
            
        }
        else {
            NSLog(@"something went wrong: %@", [error userInfo]);
        }
        
        //@"~~~~~ httpResponse: %@",httpResponse);
        
        //@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
        
        
        if([httpResponse statusCode] == 500){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate failResponse:error];
                
                [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
            });
            
        }
        else if([httpResponse statusCode] == 401 ){
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([USERDEFAULTS boolForKey:@"UserSignedIn"]){
                    //[APPDELEGATE showAlertBlockOrAuthenticationCheck:BlockMessageAfterLogin];
                    
                }
                else{
                   // [APPDELEGATE showAlertBlockOrAuthenticationCheck:BlockMessageBeforeLogin];
                    
                }
            });
        }
        else{
            if ([httpResponse statusCode] != 200)
            {
                if (self.onFailure) {
                    
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                        [self.delegate failResponse:error];
                }
            }
            else{
                if (data) {
                    
                    jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                    
                    if (jsonDictionary) {
                        if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                            [self.delegate responseDic:jsonDictionary];
                        
                        return jsonDictionary;
                    }
                    else{
                        
                        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                            [self.delegate failResponse:error];
                    }
                    
                }
                
                
            }
        }
        return jsonDictionary;

    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    @finally {
    }
   }
- (NSDictionary *)getAllDataService : (NSString*)urlStr
{
    NSURL *theURL;
    theURL =[NSURL URLWithString:urlStr];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    NSDictionary *jsonDictionary ;
    // setting the HTTP method
    [request setHTTPMethod:@"GET"];
    
    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];

    // the boundary string. Can be whatever we want, as long as it doesn't appear as part of "proper" fields
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];
    
    //@"TOKEN ID :%@",[USERDEFAULTS valueForKey:@"TOKENID"]);
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"application/json; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog( @"response = %@",myString);
    
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    
    if (!error) {
      
        
    }
    else {
        NSLog(@"something went wrong: %@", [error userInfo]);
    }
    
    //@"~~~~~ httpResponse: %@",httpResponse);
    
    //@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
    if([httpResponse statusCode] == 500){
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.delegate failResponse:error];

            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });    }
    
    else if([error code] == -1012 ||[httpResponse statusCode] == 401 ){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([USERDEFAULTS boolForKey:@"UserSignedIn"]){
              //  [APPDELEGATE showAlertBlockOrAuthenticationCheck:BlockMessageAfterLogin];
                
            }
            else{
             //   [APPDELEGATE showAlertBlockOrAuthenticationCheck:BlockMessageBeforeLogin];
                
            }
        });
    }
    else{
    if ([httpResponse statusCode] != 200)
    {
        if (self.onFailure) {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                [self.delegate failResponse:error];
        }
    }
    else{
        if (data) {
            
            jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
            
            if (jsonDictionary) {
                if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                    [self.delegate responseDic:jsonDictionary];
                
                return jsonDictionary;
            }
            else{
                if (jsonDictionary == nil && data.length > 0)
                {
                   // NSError * err;
                    ///NSData * jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:&err];
                    NSString * myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSString *complete = [NSString stringWithFormat:@"%@%@", myString,@"\"}}"];
                    
                    NSData *data = [complete dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                        [self.delegate responseDic:json];
                    
                    
                }
                else
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                        [self.delegate failResponse:error];
                
            }
            
        }
        
        
    }
    }
    return jsonDictionary;
}
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger code = [httpResponse statusCode];
    [Utilities getErrorMessageForStatus:code];
}


-(void)suggestableLocations:(NSString *)searchString
{
    NSString *trimmed = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *reqUrl =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=(regions)&key=%@",trimmed,GOOGLEAPIKEY];
    
    NSURL *theURL =[NSURL URLWithString:reqUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    
    // setting the HTTP method
    [request setHTTPMethod:@"GET"];
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];

    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // the boundary string. Can be whatever we want, as long as it doesn't appear as part of "proper" fields
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    //NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //@"response = %@",myString);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    
    //@"~~~~~ httpResponse: %@",httpResponse);

    //@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
    if([httpResponse statusCode] == 500){
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.delegate failResponse:error];

            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });
    }
    else{
    if (error) {
        //if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
        //  [self.delegate failResponse:error];
    }
    else{
        if (data) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
            
            if (jsonDictionary) {
                if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                    [self.delegate responseDic:jsonDictionary];
                
                
            }
            else{
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                    [self.delegate failResponse:error];
                
            }
        }
    }
    
}
}

- (NSDictionary *)uploadFile:(NSString *)urlString info:(NSDictionary*)reqDict{
    
    // creating a NSMutableURLRequest that we can manipulate before sending
    //urlString = [NSString stringWithFormat:@"%@/%@",BASE_URL,urlString];
    
    NSURL *theURL =[NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    
    // setting the HTTP method
    [request setHTTPMethod:@"POST"];
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];

    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // the boundary string. Can be whatever we want, as long as it doesn't appear as part of "proper" fields
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    // we need a buffer of mutable data where we will write the body of the request
    NSMutableData *body = [NSMutableData data];
    
    // writing the basic parameters
    for (NSString *key in reqDict) {
        
        if ([key isEqualToString:@"KEY"]) {
            continue;
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [reqDict objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if ([reqDict valueForKey:@"FileData"] && [reqDict valueForKey:@"KEY"]) {
        NSString *imageName = [NSString stringWithFormat:@"%@.png",@"Prasad"];
        // creating a NSData representation of the image
        NSData *imageData = [NSData dataWithData:[reqDict objectForKey:@"FileData"]];
        
        
        // if we have successfully obtained a NSData representation of the image
        
        if (imageData) {
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",[reqDict valueForKey:@"KEY"], imageName] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[NSData dataWithData:imageData]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    // assigning the completed NSMutableData buffer as the body of the HTTP POST request
    [request setHTTPBody:body];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    
    if (data) {
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
        // //@"result = %@",jsonDictionary);
        if (jsonDictionary) {
            if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                [self.delegate responseDic:jsonDictionary];
            return jsonDictionary;
        }
        else{
            
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                [self.delegate failResponse:error];
        }
        
    }
    
    else{
        dispatch_async(dispatch_get_main_queue(), ^{

        });
        return nil;
        
    }
    
    return nil;
}

-(NSString *) getHTTPBodyParamsFromDictionary: (NSDictionary *)params boundary:(NSString *)boundary
{
    NSMutableString *tempVal = [[NSMutableString alloc] init];
    for(NSString * key in params)
    {
        [tempVal appendFormat:@"\r\n--%@\r\n", boundary];
        [tempVal appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@",key,[params objectForKey:key]];
    }
    return [tempVal description];
}


#pragma mark - Coredata Methods

#pragma mark - Avoid Duplication Methods

-(BOOL)checkAttributes:(NSString *)attributeName InEntityWithEntityName:(NSString *)entityName ForPreviousItems:(NSString *)itemValue inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userID == %@",itemValue];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:attributeName ascending:YES];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    if ([fetchedObjects count]>0)
    {
        return YES;
    }
    
    return NO;
}

#define UploadMultiple Images


-(void)uploadingMultipleImagesAndDataForReview:(NSDictionary*)requestDict :(NSMutableArray*)imagedataArray :(NSString*)urlStr
{
   
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"foo" password:@"bar"];
        [manager.requestSerializer setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];
        [manager POST:urlStr parameters:requestDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
         {
             
             for (int i=0; i<[imagedataArray count]; i++) {
                 
                 //@"photo name is : %@",[NSString stringWithFormat:@"photo%d",i+1]);
                 
                 [formData appendPartWithFileData:[Utilities compressingImageData:[imagedataArray objectAtIndex:i]]
                                             name:[NSString stringWithFormat:@"review_img%d",i+1]
                                         fileName:[NSString stringWithFormat:@"image%d.jpg",i]
                                         mimeType:@"image/jpeg"];
             }
             
         }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSDictionary *response = (NSDictionary *)responseObject;
                  NSUInteger status = [[response valueForKey:@"status"] integerValue];
                  NSString *resultMessage = [response valueForKey:@"result"];
//                  if(status == 30 )
//                  {
//                      [APPDELEGATE showAlertBlockOrAuthenticationCheck:resultMessage];
//                  }
//                  else if(status == 31)
//                  {
//                      dispatch_async(dispatch_get_main_queue(), ^{
//                          [APPDELEGATE showAlertBlockOrAuthenticationCheck:resultMessage];
//                          
//                      });
//                      return;        }
//                  else if(status == 32)
//                  {
//                      dispatch_async(dispatch_get_main_queue(), ^{
//                          [APPDELEGATE showAlertBlockOrAuthenticationCheck:resultMessage];
//                          
//                      });
//                      return;
//                  }

                  NSDictionary *jsonDictionary = (NSDictionary *)responseObject;
                  if ([[jsonDictionary valueForKey:@"status"] integerValue] == 1) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          if (jsonDictionary) {
                              if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                                  [self.delegate responseDic:jsonDictionary];
                              
                              
                          }                          //@"sucessssssss.....%@",responseObject);
                      });
                  }
                  else
                  {
                     
                  }
                  
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             
             
         }];
        
    });

}
-(NSData *)returnCompressedImageData :(UIImage *)image
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

-(void)placeOrder:(NSString *)urlStr andRequest:(NSDictionary *)requestDict :(NSString *)method{
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData *postData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *theURL =[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
    // setting the HTTP method
    [request setHTTPMethod:method];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    //[request setValue:@"Token token=627ce19c8ee08edde5ce6b25f5b18fcf;device_id=123456" forHTTPHeaderField:@"Authorization"];
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    // assigning the completed NSMutableData buffer as the body of the HTTP POST request
    [request setHTTPBody:postData];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"response = %@",str);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSLog( @"~~~~~ httpResponse: %@",httpResponse);
     NSLog(@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
    
    
    
    if([httpResponse statusCode] == 500){
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.delegate failResponse:error];

            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });    }
    else if([error code] == -1012 || [httpResponse statusCode] == 401 ){
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            if ([USERDEFAULTS boolForKey:@"UserSignedIn"]){
//                [APPDELEGATE showAlertBlockOrAuthenticationCheck:BlockMessageAfterLogin];
// 
//            }
//            else{
//                [APPDELEGATE showAlertBlockOrAuthenticationCheck:BlockMessageBeforeLogin];
//   
//            }
        });
        }
    else{
    if (data == nil){
        NSDictionary *errorInfo = @{@"message" : @"Something went wrong. Please try again later"};
        if (self.onFailure) {
            self.onFailure(error,errorInfo);
        }
    }
    else{
        if ([httpResponse statusCode] != 200)
        {
            if (self.onFailure) {
                NSDictionary *errorInfo = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                self.onFailure(error,errorInfo);
            }
        }
        else{
            if (data) {
                NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                
                if (jsonDictionary)
                {
                    if (self.onSuccess)
                        self.onSuccess(YES, jsonDictionary);
                }
                else
                {
                    if (self.onSuccess)
                        self.onSuccess(YES, nil);
                }
            }
            
        }
    }
    
}
}
-(void)handleRedeemRequestWithBlocks :(NSString *)urlString info:(NSDictionary *)reqDict andMethod:(NSString *)method
{
    NSURL *theURL =[NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
    if (![method isEqualToString:@"GET"]) {
        NSMutableString *post = [[NSMutableString alloc]init];
        for (NSString *key in reqDict) {
            [post appendString:[NSString stringWithFormat:@"%@=%@&",key,[reqDict objectForKey:key]]];
        }
        [post deleteCharactersInRange:NSMakeRange([post length]-1, 1)];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        // assigning the completed NSMutableData buffer as the body of the HTTP POST request
        [request setHTTPBody:postData];
        
    }
    // setting the HTTP method
    [request setHTTPMethod:method];
    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"]  forHTTPHeaderField:@"Authorization"];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //@"response = %@",str);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    //@"~~~~~ httpResponse: %@",httpResponse);
    //@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
    if([httpResponse statusCode] == 500){
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.delegate failResponse:error];

            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });
    }
    else{
    if (data == nil){
        NSDictionary *errorInfo = @{@"message" : @"Something went wrong. Please try again later"};
        if (self.onFailure) {
            self.onFailure(error,errorInfo);
        }
    }
    else{
        if ([httpResponse statusCode] != 200)
        {
            if (self.onFailure) {
                NSDictionary *errorInfo = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                self.onFailure(error,errorInfo);
            }
        }
        else{
            if (data) {
                NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                
                if (jsonDictionary) {
                    if (self.onSuccess)
                        self.onSuccess(YES, jsonDictionary);
                    
                }
                else{
                    if (self.onSuccess)
                        self.onSuccess(YES, nil);
                    
                }
            }
            
        }
    }
}
}

#pragma mark - Registration
-(void)handleGetLandingData :(NSString *)urlString info:(NSDictionary *)reqDict {
    
    NSMutableString *post = [[NSMutableString alloc]init];
    for (NSString *key in reqDict) {
        [post appendString:[NSString stringWithFormat:@"%@=%@&",key,[reqDict objectForKey:key]]];
    }
    [post deleteCharactersInRange:NSMakeRange([post length]-1, 1)];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *theURL =[NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
    // setting the HTTP method
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];
    //@"TOKENID = %@" , [USERDEFAULTS valueForKey:@"TOKENID"]);
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    // assigning the completed NSMutableData buffer as the body of the HTTP POST request
    [request setHTTPBody:postData];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    //@"~~~~~ httpResponse: %@",httpResponse);
    //@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
     if([httpResponse statusCode] == 500){
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.delegate failResponse:error];

            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });    }
    else{
    if ([httpResponse statusCode] == 200)
    {
        if (data) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
            
            if (jsonDictionary) {
                if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                    [self.delegate responseDic:jsonDictionary];
            }
            else{
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                    [self.delegate failResponse:error];
            }
        }
    }
    else {
        if(data != nil){
            NSDictionary *errorDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
            [self.delegate clientRequestFailed:errorDictionary];
        }
    }
}
}


#pragma mark - Registration
-(void)handleRegistration :(NSString *)urlString info:(NSDictionary *)reqDict andMethod:(NSString *)method{
    
    NSMutableString *post = [[NSMutableString alloc]init];
    for (NSString *key in reqDict) {
        [post appendString:[NSString stringWithFormat:@"%@=%@&",key,[reqDict objectForKey:key]]];
    }
    [post deleteCharactersInRange:NSMakeRange([post length]-1, 1)];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *theURL =[NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
    // setting the HTTP method
    [request setHTTPMethod:method];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];
    //@"TOKENID = %@" , [USERDEFAULTS valueForKey:@"TOKENID"]);
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    // assigning the completed NSMutableData buffer as the body of the HTTP POST request
    [request setHTTPBody:postData];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //@"response = %@",str);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    //@"~~~~~ httpResponse: %@",httpResponse);
    //@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
    if([httpResponse statusCode] == 500)
    {
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.delegate failResponse:error];
            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });
    }
    else
    {
    if ([httpResponse statusCode] == 200)
    {
        if (data) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
            
            if (jsonDictionary) {
                if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                    [self.delegate responseDic:jsonDictionary];
                
                
            }
            else{
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                    [self.delegate failResponse:error];
                
            }
        }
    }
    else {
        if(data != nil){
        NSDictionary *errorDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
            [self.delegate clientRequestFailed:errorDictionary];
        }
    }
}
}

-(void)redeemGetServiceCall :(NSString *)urlString{
    
    NSURL  *theURL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
    NSDictionary *jsonDictionary ;
    // setting the HTTP method
    [request setHTTPMethod:@"GET"];
    
    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSLog(@"token = %@",[USERDEFAULTS valueForKey:@"TOKENID"]);
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"]  forHTTPHeaderField:@"Authorization"];
    
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"response = %@",myString);
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    
    //@"~~~~~ httpResponse: %@",httpResponse);
    
    //@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
    if([httpResponse statusCode] == 500){
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.delegate failResponse:error];

            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });    }
    else{
    if (data == nil) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
            [self.delegate failResponse:error];
    }
    else{
        if ([httpResponse statusCode] != 200)
        {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                [self.delegate failResponse:error];
        }
        else{
            if (data) {
                jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                
                if (jsonDictionary) {
                    if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                        [self.delegate responseDic:jsonDictionary];
                }
                else{
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                        [self.delegate failResponse:error];
                }
            }
            else{
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                    [self.delegate failResponse:error];
            }
        }
    }
}
}

-(void)handleContactsSynRequestWithBlocks :(NSString *)urlString info:(NSDictionary *)reqDict andMethod:(NSString *)method{
    
    NSLog(@"urlString =%@",urlString);
    
    NSLog(@"reqDict =%@",reqDict);

    NSURL *theURL =[NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    
    // setting the HTTP method
    [request setHTTPMethod:@"POST"];
    
    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // the boundary string. Can be whatever we want, as long as it doesn't appear as part of "proper" fields
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // we need a buffer of mutable data where we will write the body of the request
    NSMutableData *body = [NSMutableData data];
    
    // writing the basic parameters
    for (NSString *key in reqDict) {
        
        if ([key isEqualToString:@"KEY"]) {
            continue;
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n",[reqDict objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    // assigning the completed NSMutableData buffer as the body of the HTTP POST request
    [request setHTTPBody:body];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    //NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //@"response = %@",myString);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    
    //@"~~~~~ httpResponse: %@",httpResponse);
    
    //@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
    if([httpResponse statusCode] == 500){
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.delegate failResponse:error];

            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });    }
    else{
    if (error) {
        if (self.onFailure) {
            NSDictionary *errorInfo = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
            self.onFailure(error,errorInfo);
        }
    }
    else{
        if (data) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
            
            if (jsonDictionary) {
                if (self.onSuccess)
                    self.onSuccess(YES, jsonDictionary);
                
                
            }
            else{
                if (self.onFailure) {
                    NSDictionary *errorInfo = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                    self.onFailure(error,errorInfo);
                }
                
            }
        }
    }
    
}
}
- (NSDictionary *)getdataFromFaqs :(NSString*)urlStr
{
    NSURL *theURL;
    theURL =[NSURL URLWithString:urlStr];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    NSDictionary *jsonDictionary ;
    // setting the HTTP method
    [request setHTTPMethod:@"GET"];
    
    // we want a JSON response
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // the boundary string. Can be whatever we want, as long as it doesn't appear as part of "proper" fields
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    [request setValue:[USERDEFAULTS valueForKey:@"TOKENID"] forHTTPHeaderField:@"Authorization"];
    
    //@"TOKEN ID :%@",[USERDEFAULTS valueForKey:@"TOKENID"]);
    // setting the Content-type and the boundary
    NSString *contentType = [NSString stringWithFormat:@"application/json; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
   // NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //@"response = %@",myString);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    
    if (!error) {
        //NSString *responseURL_get2 = [[httpResponse URL] absoluteString];           // null value
        //NSString *responseTextEncodingName_get2 = [httpResponse textEncodingName];  // null value
        //NSString *responseMIMEType_get2 = [httpResponse MIMEType];                  // null value
       // NSInteger *responseStatusCode_get2 = [httpResponse statusCode]; //[responseStatusCode intValue]; // the status code is 0
        
    }
    else {
        //@"something went wrong: %@", [error userInfo]);
    }
    
    //@"~~~~~ httpResponse: %@",httpResponse);
    
    //@"~~~~~ Status code: %ld",(long)[httpResponse statusCode]);
    if([httpResponse statusCode] == 500){
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.delegate failResponse:error];

            [Utilities displayCustemAlertViewWithOutImage:[Utilities getErrorMessageForStatus:[httpResponse statusCode]] :[APPDELEGATE window]];
        });    }
    else{
    if ([httpResponse statusCode] != 200)
    {
        if (self.onFailure) {
            
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                [self.delegate failResponse:error];
        }
    }
    else{
        if (data) {
            
            jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
            
            if (jsonDictionary) {
                if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                    [self.delegate responseDic:jsonDictionary];
                
                return jsonDictionary;
            }
            else{
                
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                    [self.delegate failResponse:error];
            }
            
        }
        
        
    }
    }
    return jsonDictionary;
}

-(NSMutableData *)generateDataFromText:(NSString *)dataText fieldName:(NSString *)fieldName
{
    NSString *post = [NSString stringWithFormat:@"--AaB03x\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n", fieldName];
    // Get the post header int ASCII format:
    NSData *postHeaderData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    // Generate the mutable data variable:
    NSMutableData *postData = [[NSMutableData alloc] initWithLength:[postHeaderData length]];
    [postData setData:postHeaderData];
    NSData *uploadData = [dataText dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    // Add the text:
    [postData appendData: uploadData];
    // Add the closing boundry:
    [postData appendData: [@"\r\n" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    // Return the post data:
    return postData;
}

- (NSData *)generatePostDataForData:(NSData *)uploadData fileName:(NSString *)fileName
{
    // Generate the post header:
    NSString *post = [NSString stringWithFormat:@"--AaB03x\r\nContent-Disposition: form-data; name=\"attachment\"; filename=\"%@\"\r\nContent-Type: video/3gpp\r\n\r\n", fileName];
    // Get the post header int ASCII format:
    NSData *postHeaderData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    // Generate the mutable data variable:
    NSMutableData *postData = [[NSMutableData alloc] initWithLength:[postHeaderData length]];
    [postData setData:postHeaderData];
    // Add the image:
    [postData appendData: uploadData];
    // Add the closing boundry:
    [postData appendData: [@"\r\n--AaB03x--" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    // Return the post data:
    return postData;
}
-(void)gettingCurrentLocatoion : (NSString *)latitude : (NSString *) langtitude
{
    
    NSString *reqUrl =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&key=%@", latitude ,langtitude,GOOGLEKEY];
    
    
    NSMutableURLRequest *getRTequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:reqUrl] cachePolicy: NSURLRequestReloadIgnoringLocalCacheData timeoutInterval: 30];
    
    [getRTequest setHTTPMethod:@"GET"];
    [getRTequest setValue:@"multipart/form-data; boundary=AaB03x" forHTTPHeaderField:@"Content-Type"];
    
    [getRTequest addValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:getRTequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         
         
         if (data.length > 0 && connectionError == nil)
         {
             if (data == nil) {
                 if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                     [self.delegate failResponse:connectionError];
             }
             else{
                
                     if (data) {
                         NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                         NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                         NSLog(@"Printaddress : %@",jsonString);

                         
                         if (jsonDictionary) {
                             if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                                 [self.delegate responseDic:jsonDictionary];
                         }
                         else{
                             if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                                 [self.delegate failResponse:connectionError];
                         }
                     }
                     else{
                         if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                             [self.delegate failResponse:connectionError];
                     }
                 
             }
             
//             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data
//                                                                           options:0
//                                                                             error:NULL];
//             if([self.delegate respondsToSelector:@selector(webServiceFinishWithDictionary:withError:)])
//                 [self.delegate webServiceFinishWithDictionary:result withError:nil];
         }
         
     }];
    
}
-(void)getLocationswithStrig:(NSString*)searchString
{
    NSString *reqUrl =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@+location+in+hyderabad&sensor=true&key=%@",searchString,GOOGLEKEY];
    
    
    NSMutableURLRequest *getRTequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:reqUrl] cachePolicy: NSURLRequestReloadIgnoringLocalCacheData timeoutInterval: 30];
    
    [getRTequest setHTTPMethod:@"GET"];
    [getRTequest setValue:@"multipart/form-data; boundary=AaB03x" forHTTPHeaderField:@"Content-Type"];
    
    [getRTequest addValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:getRTequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         
         
         if (data.length > 0 && connectionError == nil)
         {
             if (data == nil) {
                 if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                     [self.delegate failResponse:connectionError];
             }
             else{
                 
                 if (data) {
                     NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error:nil];
                     NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                     NSLog(@"Print : %@",jsonString);
                     
                     
                     if (jsonDictionary) {
                         if (self.delegate  && [self.delegate respondsToSelector:@selector(responseDic:)])
                             [self.delegate responseDic:jsonDictionary];
                     }
                     else{
                         if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                             [self.delegate failResponse:connectionError];
                     }
                 }
                 else{
                     if (self.delegate != nil && [self.delegate respondsToSelector:@selector(failResponse:)])
                         [self.delegate failResponse:connectionError];
                 }
                 
             }
             
             //             NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data
             //                                                                           options:0
             //                                                                             error:NULL];
             //             if([self.delegate respondsToSelector:@selector(webServiceFinishWithDictionary:withError:)])
             //                 [self.delegate webServiceFinishWithDictionary:result withError:nil];
         }
         
     }];
}

@end
