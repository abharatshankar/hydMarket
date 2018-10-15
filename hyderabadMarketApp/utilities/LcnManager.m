
//  LocationManager.m
//  Delivery Wala
//  Created by Sharvani on 30/06/15.
//  Copyright (c) 2015 . All rights reserved.
//

/*!
 ->  LcnManager used for.
 
 -> in this controller displaying location lat, longs
 
 */


#import "LcnManager.h"
#import <MapKit/MapKit.h>
#import "Constants.h"
#import "Utilities.h"
@implementation LcnManager

+(LcnManager *)sharedManager
{
    static LcnManager *sharedMyManager = nil;
    
    @synchronized(self) {
        if (sharedMyManager == nil)
        {
            sharedMyManager = [[self alloc] init];
        }
 }
    return sharedMyManager;
}

- (BOOL) enableLocationServices
{
    
    if ([CLLocationManager locationServicesEnabled])
    {
        self.locationManager.distanceFilter = 10;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        return YES;
    }
    else
    {
        return NO;
    }
}

- (CLLocationManager *)locationManager
{
    
    //  Location manager is lazily intialized when its really needed
    if(!_locationManager)
    { self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        [self.locationManager setDelegate:self];
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        [ self.locationManager startUpdatingLocation];
        
        //Only applies when in foreground otherwise it is very significant changes
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
    
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if([Utilities null_ValidationString:[USERDEFAULTS valueForKey:@"city"]].length==0)
    {
    CLLocation *currentLocation = [self.locationManager location];
    [self.locationManager stopUpdatingLocation];

    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = currentLocation.coordinate.latitude;
    region.center.longitude = currentLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;

        
        NSLog(@"Resolving the Address");
        CLGeocoder *geocoder1 = [[CLGeocoder alloc] init] ;
        [geocoder1 reverseGeocodeLocation:self.locationManager.location
                       completionHandler:^(NSArray *placemarks, NSError *error)
                        {
                           NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                           
                           if (error)
                           {
                               NSLog(@"Geocode failed with error: %@", error);
                               return;
                               
                           }
                            
                           CLPlacemark *placemark = [placemarks objectAtIndex:0];
                            [USERDEFAULTS setValue:placemark.locality forKey:@"city"];
                           [USERDEFAULTS synchronize];
                           NSLog(@"placemark.locality %@",placemark.locality);
                            NSLog(@"placemark.locality TOTAL:%@",[NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                         placemark.subThoroughfare, placemark.thoroughfare,
                                         placemark.postalCode, placemark.locality,
                                         placemark.administrativeArea,
                                         placemark.country]);
                           
                       }];

      //    geocoder = [[CLGeocoder alloc] init] ;
//    [geocoder reverseGeocodeLocation:currentLocation
//                   completionHandler:^(NSArray *placemarks, NSError *error) {
//                       if (error){
//                           NSLog(@"Geocode failed with error: %@", error);
//                           return;
//                       }
//                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
//                       NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//                       if([[USERDEFAULTS valueForKey:@"city"] isEqualToString:@"Hyderabad"])
//                       {
//                           
//                       }
//                       else
//                       {
//                           [USERDEFAULTS setValue:placemark.locality forKey:@"city"];
//
//                       }
//                       
//                       NSLog(@"city %@",placemark.locality);
//                       NSLog(@"city %@",placemark.subLocality);
//                       NSLog(@"city %@",placemark.name);
//
//                       
//                   }];
    }
  }

-(void)restartLocationUpdates
{
   // NSLog(@"restartLocationUpdates");
}

- (NSString *)calculateDistance : (NSString *) deliveryAddLat :(NSString *)deliveryAddLong :(NSString *)pickupLat : (NSString *)pickupLong
{
    
   
    static const double DEG_TO_RAD = 0.017453292519943295769236907684886;
    static const double EARTH_RADIUS_IN_METERS = 6372797.560856;
    
    double latitudeArc  = ([pickupLat floatValue] - [deliveryAddLat floatValue]) * DEG_TO_RAD;
    double longitudeArc = ([pickupLong floatValue]- [deliveryAddLong floatValue]) * DEG_TO_RAD;
    double latitudeH = sin(latitudeArc * 0.5);
    latitudeH *= latitudeH;
    double lontitudeH = sin(longitudeArc * 0.5);
    lontitudeH *= lontitudeH;
    double tmp = cos([pickupLat floatValue]*DEG_TO_RAD) * cos([deliveryAddLat floatValue]*DEG_TO_RAD);
    
    
    double meters = EARTH_RADIUS_IN_METERS * 2.0 * asin(sqrt(latitudeH + tmp*lontitudeH));
    
    CLLocationDistance kilometers = meters / 1000.0;
    //NSLog(@"kilometers :%f", kilometers);
    //Get distance in miles
    //NSLog(@"Miles:%f",kilometers*0.62137);
    //convert kilometers to int value
   // NSInteger num = kilometers;
    //NSLog(@"kilometers :%ld", (long)num);
    //NSInteger finalvalue ;
//if(num ==0)
//{
//    finalvalue = 5;
//}
//  else
//  {
//      finalvalue = num *5;
//  }
    NSLog(@"kilometers =%f",kilometers);

    NSString *finlDictStr = [NSString stringWithFormat:@"%.2f",(float)kilometers];
    NSLog(@"finlDictStr =%@",finlDictStr);
    
    return finlDictStr;
}
# pragma mark - Public interface
-(void)getCurrentLocation
{
    locLongitude = [[NSString alloc]init];
    locLatitude = [[NSString alloc]init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    
     self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [ self.locationManager startUpdatingLocation];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    //NSLog(@"lat: %lf, long: %lf", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        if (&UIApplicationOpenSettingsURLString != NULL) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
        else {
            // Present some dialog telling the user to open the settings app.
        }
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //NSLog(@"Location access Enabled");
        //[NOTIFICATIONCENTER postNotificationName:LOCATIONSTATUS_NOTIFY object:self userInfo:nil];

    }
    else if (status == kCLAuthorizationStatusDenied)
    {
        //NSLog(@"Location access denied");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enable Location Service"
                                                        message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                                       delegate:self
                                              cancelButtonTitle:@"Settings"
                                              otherButtonTitles:nil];
        [alert show];

    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        locLongitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        locLatitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        
        // Reverse Geocoding
        NSLog(@"Resolving the Address");
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
            if (error == nil && [placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks lastObject];
                NSLog(@"%@",[NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                     placemark.subThoroughfare, placemark.thoroughfare,
                                     placemark.postalCode, placemark.locality,
                                     placemark.administrativeArea,
                                     placemark.country]);
            } else {
                NSLog(@"%@", error.debugDescription);
            }
        } ];
        
    
    }
}

- (void)getCurrentLocationInfo:(CLLocationCoordinate2D)locCorrdinate
{
    
   // NSString *str = [NSString stringWithFormat:@"latitude: %f longitude: %f", locCorrdinate.latitude, locCorrdinate.longitude];
    
    //NSLog(@"str =%@",str);
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:locCorrdinate.latitude longitude:locCorrdinate.longitude];
    
    // Instantiate _geoCoder if it has not been already
    if (geocoder == nil)
    {
        geocoder = [[CLGeocoder alloc] init];
    }
    
    //Only one geocoding instance per action
    //so stop any previous geocoding actions before starting this one
    if([geocoder isGeocoding])
    {
        [geocoder cancelGeocode];
    }
    [geocoder reverseGeocodeLocation: newLocation
                   completionHandler: ^(NSArray* placemarks, NSError* error)
     {
         if([placemarks count] > 0)
         {

         }
         else if (error.code == kCLErrorGeocodeCanceled)
         {
            // NSLog(@"Geocoding cancelled");
         }
         else if (error.code == kCLErrorGeocodeFoundNoResult)
         {
            // NSLog(@"No geocode result found");
         }
         else if (error.code == kCLErrorGeocodeFoundPartialResult)
         {
            // NSLog(@"Partial geocode result");
         }
         else
         {
             //NSLog(@"%@", [NSString stringWithFormat:@"Unknown error: %@",
                          // error.description]);
         }
     }];
}
@end
