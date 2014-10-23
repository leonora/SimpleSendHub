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
    spinner.alpha = 0.0f;
    sendStatusLabel.alpha = 0.0f;
    [self addDoneToolBarToKeyboard:textView];
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
}

- (void)pressedSend:(id)sender
{
    [self startSending];
    _manager = [[HUBContactsManager alloc] init];
    _manager.communicator = [[HUBCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    [_manager sendMessage:[self getMessageJson]];
}

- (void)startSending
{
    textView.editable = NO;
    sendButton.enabled = NO;
    textView.alpha = 0.3f;
    sendButton.alpha = 0.3f;
    spinner.alpha = 1.0f;
    [spinner startAnimating];
}

- (void)stopSending
{
    textView.editable = YES;
    sendButton.enabled = YES;
    textView.alpha = 1.0f;
    sendButton.alpha = 1.0f;
    spinner.alpha = 0.0f;
    [spinner stopAnimating];
}

- (void)addDoneToolBarToKeyboard:(UITextView *)aTextView
{
    UIToolbar* doneToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    doneToolbar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClickedDismissKeyboard)];
    doneToolbar.items = [NSArray arrayWithObjects:flexibleSpace, barButton, flexibleSpace, nil];
    [doneToolbar sizeToFit];
    aTextView.inputAccessoryView = doneToolbar;
}

-(void)doneButtonClickedDismissKeyboard
{
    [textView resignFirstResponder];
}

-(void)wasSendMessageSuccessful:(BOOL)isSuccessful
{
    [self stopSending];
    if (isSuccessful) {
        sendStatusLabel.text = @"Message sent!";
        sendStatusLabel.alpha = 1.0f;
    } else {
        sendStatusLabel.text = @"Send failed.";
        sendStatusLabel.alpha = 1.0f;
    }
}

@end
