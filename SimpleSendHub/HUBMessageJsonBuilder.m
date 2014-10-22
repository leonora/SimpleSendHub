//
//  HUBMessageJsonBuilder.m
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/22/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import "HUBMessageJsonBuilder.h"

@implementation HUBMessageJsonBuilder

+ (NSString *)jsonFromMessage:(NSArray *)contacts withText:(NSString *)text
{
    NSDictionary *messageDict = [[NSDictionary alloc] initWithObjectsAndKeys:contacts, @"contacts", text, @"text", nil];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDict
                                                       options:0
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Error while turning message dictionary into json string: %@", error);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
