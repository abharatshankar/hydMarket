//
//  BiZManager.m
//  Rush Now
//  Created by Sharvani on 03/07/15.
//  Copyright (c) 2015 Possibilliontech. All rights reserved.

/*!
 ->  ImageCache used for.
 
 -> in this controller used to store Images cache
 
 */


#import "ImageCache.h"
@implementation ImageCache
@synthesize  imageCache;

+(ImageCache *)sharedManager
{
    static ImageCache *sharedMyManager = nil;
    
    @synchronized(self) {
        if (sharedMyManager == nil)
        {
            sharedMyManager = [[self alloc] init];
        }
    }
    
    return sharedMyManager;
}


- (void)initialiseBizManager
{
    
//    [[WebService sharedManager] initialiseWebServiceManager];
//    [WebService sharedManager].delegate = self;
}

- (id)init
{
    if (self = [super init])
    {
        imageCache = [[NSCache alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __unused notification) {
            [self.imageCache removeAllObjects];
        }];
    }
    
    return self;
}

-(void)clearDocumentDirectory{
    NSString *path;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"/video.mp4"];
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])		//Does file exist?
    {
        if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error])	//Delete it
        {
            //@"Delete file error: %@", error);
        }
    }
}

-(void)imageDownloading:(NSString*)imageUrl
{
    
    [self clearDocumentDirectory];
    
    NSString *urlString=imageUrl;
    //@"urlString=%@",urlString);
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo
{
    if (error != NULL)
    {
        // handle error
    }
    else
    {
        UIAlertView  *alert=[[UIAlertView alloc] initWithTitle:@"Download Alert" message:@"Download image successfully" delegate:self cancelButtonTitle:  nil otherButtonTitles:@"Ok", nil];
        [alert show];
        // [APPDELEGATE hideHUD];
    }
}
-(void)showAlert {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Download Alert" message:@"Download image successfully" delegate:self cancelButtonTitle:  nil otherButtonTitles:@"Ok", nil];
    [alert show];
}
/*
-(void)createRushNowAccountWithDict:(NSMutableDictionary *)dict withImage:(UIImage *)image
{
    requestID = 100;
    [[WebService sharedManager] createRushNowAccountWithDict:dict withImage:image];
    
}
*/
@end
