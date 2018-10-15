//
//  ContactsExternalChange.m
//  Zaggle
//
//  Created by Sharvani on 04/09/16.
//  Copyright © 2016 Zaggle Prepaid Ocean Services Private Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface ContactsExternalChange : NSObject
{
    ABAddressBookRef addressBook;
    NSArray *people;
}

+ (ContactsExternalChange*)sharedInstance;
- (void)refresh;

void MyAddressBookExternalChangeCallback (
                                          ABAddressBookRef addressBook,
                                          CFDictionaryRef info,
                                          void *context
                                          );

@end