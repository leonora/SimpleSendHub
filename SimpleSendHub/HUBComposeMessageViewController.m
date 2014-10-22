//
//  HUBComposeMessageViewController.m
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import "HUBComposeMessageViewController.h"
#import "HUBContactsManager.h"
#import "HUBMessageJsonBuilder.h"
#import "HUBCommunicator.h"
#import <QuartzCore/QuartzCore.h>

@interface HUBComposeMessageViewController()<HUBContactsManagerDelegate> {
    NSArray *_contacts;
    NSString *_text;
    HUBContactsManager *_manager;
}

@end

@implementation HUBComposeMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    textView.layer.borderWidth = 1.0f;
    textView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    
}

- (NSString*)getMessageJson
{
    return [HUBMessageJsonBuilder jsonFromMessage:_contacts withText:textView.text];
}

- (void)setCurrentContact:(HUBContact*)contact
{
    _contacts = [[NSArray alloc] initWithObjects:contact.id, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pressedSend:(id)sender
{
    _manager = [[HUBContactsManager alloc] init];
    _manager.communicator = [[HUBCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    [_manager sendMessage:[self getMessageJson]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
