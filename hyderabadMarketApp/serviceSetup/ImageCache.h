//
//  BiZManager.h
//  Rush Now
//  Created by Sharvani on 03/07/15.
//  Copyright (c) 2015 Possibilliontech. All rights reserved.

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface ImageCache : NSObject
{
 
}

@property (nonatomic, strong) NSCache *imageCache;
/*!
 @abstract      sharedManager
 @param         nil
 @discussion    Function that returns the common shared instance for the BiZManager class
 @return        BiZManager
 */

+(ImageCache*)sharedManager;

/*!
 @abstract      initialiseBizManager
 @param         nil
 @discussion    initialiseBizManager initialises the BizManager
 @return        nil
 */

-(void)initialiseBizManager;

-(void)imageDownloading:(NSString*)imageUrl;


@end
