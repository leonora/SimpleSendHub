//
//  HUBContactsManagerDelegate.h
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HUBContactsManagerDelegate <NSObject>

@optional
- (void)didReceiveContacts:(NSArray *)contacts;
- (void)fetchingContactsFailedWithError:(NSError *)error;

@end
