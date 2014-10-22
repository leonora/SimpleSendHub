//
//  HUBContactsManager.h
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HUBContactsManagerDelegate.h"
#import "HUBCommunicatorDelegate.h"

@class HUBCommunicator;

@interface HUBContactsManager : NSObject<HUBCommunicatorDelegate>
@property (strong, nonatomic) HUBCommunicator *communicator;
@property (weak, nonatomic) id<HUBContactsManagerDelegate> delegate;

- (void)fetchContacts;
- (void)sendMessage:(NSString*) message;

@end
