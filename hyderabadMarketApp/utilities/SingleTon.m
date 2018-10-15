//
//  SingleTon.m
//  SingleTonDataPassing
//
//  Created by Bharat shankar on 01/03/17.
//  Copyright © 2017 Edu.Self. All rights reserved.
//

#import "SingleTon.h"

@implementation SingleTon
+(id)singleTonMethod{
    static SingleTon *singleTon=nil;
    @synchronized (self) {
        if (singleTon ==nil) {
            singleTon=[self alloc];
        }
    }
    return singleTon;
}

+ (void)resetSharedInstance {
    static SingleTon *singleTon;
    singleTon = nil;
}

@end
