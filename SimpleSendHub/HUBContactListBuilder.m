//
//  HUBContactListBuilder.m
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import "HUBContactListBuilder.h"
#import "HUBContact.h"

@implementation HUBContactListBuilder

+ (NSArray *)contactListFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"objects"];
    NSLog(@"Count %d", results.count);
    
    for (NSDictionary *contactDic in results) {
        HUBContact *contact = [[HUBContact alloc] init];
        
        for (NSString *key in contactDic) {
            if ([contact respondsToSelector:NSSelectorFromString(key)]) {
                [contact setValue:[contactDic valueForKey:key] forKey:key];
            }
        }
        [contacts addObject:contact];
    }
    
    return contacts;
}

@end
