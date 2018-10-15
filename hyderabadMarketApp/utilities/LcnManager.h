
//  LocationManager.h
//  Delivery Wala
//  Created by Sharvani on 30/06/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface LcnManager : NSObject <CLLocationManagerDelegate>
{
    NSString * locLatitude;
    NSString * locLongitude;
    int requestId;
    CLGeocoder *geocoder;
}

@property (nonatomic, strong) CLLocationManager *locationManager;

+(LcnManager *) sharedManager;
//-(NSString*) getaddressDetailsWithString : (CLLocation*)locationVal;
-(void) getCurrentLocation;
- (void)getCurrentLocationInfo:(CLLocationCoordinate2D)locCorrdinate;
/*!
 @abstract      encodeToBase64String
 @param         image
 @discussion    encodeToBase64String
 @return        string
 */
- (NSString *)calculateDistance : (NSString *) deliveryAddLat :(NSString *)deliveryAddLong :(NSString *)pickupLat : (NSString *)pickupLong;
- (BOOL) enableLocationServices;

@end
