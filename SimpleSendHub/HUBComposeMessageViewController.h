//
//  HUBComposeMessageViewController.h
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUBContact.h"

@interface HUBComposeMessageViewController : UIViewController {
    IBOutlet UITextView *textView;
    IBOutlet UIButton *sendButton;
}

- (IBAction)pressedSend:(id)sender;
- (void)setCurrentContact:(HUBContact*)contact;

@end
