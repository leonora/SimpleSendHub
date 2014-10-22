//
//  HUBContactsManager.m
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import "HUBContactsManager.h"
#import "HUBCommunicator.h"
#import "HUBContactListBuilder.h"
#import "HUBMessageJsonBuilder.h"

@implementation HUBContactsManager

- (void)fetchContacts
{
    [self.communicator requestContacts];
}

- (void)sendMessage:(NSString*) message
{
    [self.communicator sendMessageToContacts:(NSString*) message];
}

#pragma mark - HUBCommunicatorDelegate

- (void)receivedContactsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *contacts = [HUBContactListBuilder contactListFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingContactsFailedWithError:error];
    } else {
        [self.delegate didReceiveContacts:contacts];
    }
}

- (void)fetchingContactsFailedWithError:(NSError *)error
{
    [self.delegate fetchingContactsFailedWithError:error];
}

@end
