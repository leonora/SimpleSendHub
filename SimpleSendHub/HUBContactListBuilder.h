//
//  HUBContactListBuilder.h
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUBContactListBuilder : NSObject

+ (NSArray *)contactListFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
