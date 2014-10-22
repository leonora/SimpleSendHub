//
//  HUBCommunicator.h
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HUBCommunicatorDelegate;

@interface HUBCommunicator : NSObject

@property (weak, nonatomic) id<HUBCommunicatorDelegate> delegate;

- (void)requestContacts;
- (void)sendMessageToContacts:(NSString*) message;

@end
