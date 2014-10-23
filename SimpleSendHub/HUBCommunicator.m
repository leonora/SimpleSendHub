//
//  HUBCommunicator.m
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import "HUBCommunicator.h"
#import "HUBCommunicatorDelegate.h"

#define API_KEY @"8bdc7dfdd375f022e5ae5469ccaefdb739278a74"
#define PHONE @"6508618136"

@interface HUBCommunicator() {
    NSMutableData *_sendMessageResponseData;
}
@end

@implementation HUBCommunicator

- (void)requestContacts
{
    NSString *getAllContactsUrl = [NSString stringWithFormat:@"https://api.sendhub.com/v1/contacts/?username=%@&api_key=%@", PHONE, API_KEY];
    NSLog(@"getAllContactsUrl=%@", getAllContactsUrl);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:getAllContactsUrl]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error) {
                               NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               NSLog(@"Response data of requestContacts: %@", responseData);
                               if (error) {
                                   [self.delegate fetchingContactsFailedWithError:error];
                               } else {
                                   [self.delegate receivedContactsJSON:data];
                               }
                           }];
}

- (void)sendMessageToContacts:(NSString*) message
{
    NSString *sendMessageUrl = [NSString stringWithFormat:@"https://api.sendhub.com/v1/messages/?username=%@&api_key=%@", PHONE, API_KEY];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:sendMessageUrl]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *xmlString = message;
    
    [request setValue:[NSString stringWithFormat:@"%d", [xmlString length]] forHTTPHeaderField:@"Content-length"];
    
    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
}

#pragma mark NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _sendMessageResponseData = [[NSMutableData alloc] init];
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    BOOL isSuccessful = false;
    if (code == 201) isSuccessful = true;
    [self.delegate receivedSendMessageStatus:isSuccessful];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_sendMessageResponseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //Now you can do what you want with the response string from the data
    NSString* responseString = [NSString stringWithUTF8String:[_sendMessageResponseData bytes]];
    NSLog(@"sendMessage response: %@", responseString);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //Do something if there is an error in the connection
}
@end
