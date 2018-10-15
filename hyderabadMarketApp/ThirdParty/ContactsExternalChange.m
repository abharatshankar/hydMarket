#import "ContactsExternalChange.h"

void MyAddressBookExternalChangeCallback (
                                          ABAddressBookRef addressBook,
                                          CFDictionaryRef info,
                                          void *context
                                          )
{
    //NSLog(@"callback called ");
    [[ContactsExternalChange sharedInstance] refresh];
    
}

@implementation ContactsExternalChange

+ (ContactsExternalChange*)sharedInstance
{
    static ContactsExternalChange *sharedInstance = nil;
    
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[ContactsExternalChange alloc] init];
        }
    }
    return sharedInstance;
}

- (void)refresh
{
    ABAddressBookRevert(addressBook); /*refreshing the address book in case of changes*/
    people = (__bridge NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
   // NSLog(@"RefreshData = %@",people);
    
}

- (id)init
{
    if ((self = [super init]))
    {
        //sharedInstance = self;
        addressBook = ABAddressBookCreate();
        people = nil;
        [self refresh];
        ABAddressBookRegisterExternalChangeCallback (addressBook,
                                                     MyAddressBookExternalChangeCallback,
                                                     (__bridge void *)(self)
                                                     );
    }
    return self;
}

@end
