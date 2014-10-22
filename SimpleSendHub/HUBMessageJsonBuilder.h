//
//  HUBMessageJsonBuilder.h
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/22/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUBMessageJsonBuilder : NSObject

+ (NSString *)jsonFromMessage:(NSArray *)contacts withText:(NSString *)text;

@end
