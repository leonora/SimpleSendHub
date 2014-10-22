//
//  HUBCommunicatorDelegate.h
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HUBCommunicatorDelegate <NSObject>

- (void)receivedContactsJSON:(NSData *)objectNotation;
- (void)fetchingContactsFailedWithError:(NSError *)error;

@end
