//
//  HUBContactTableViewController.m
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import "HUBContactDetailTableViewController.h"
#import "HUBComposeMessageViewController.h"

@interface HUBContactDetailTableViewController () {
    HUBContact *_contact;
}

@end

@implementation HUBContactDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setCurrentContact:(HUBContact*)contact
{
    _contact = contact;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([_contact.number length] == 0) return 1; // Contact doesn't have a phone number, can't send message
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([_contact.number length] == 0) return 2; // Contact doesn't have phone number
    if (section == 0) return 2;
    else return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ContactDetailInfoCellIdentifier = @"ContactDetailInfoCell";
    static NSString *ContactDetailSendMessageCellIdentifier = @"ContactDetailSendMessageCell";
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:ContactDetailInfoCellIdentifier forIndexPath:indexPath];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"Name: %@", _contact.name];
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@"Number: %@", [self formatPhone:_contact.number]];
        }
    } else {
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:ContactDetailSendMessageCellIdentifier forIndexPath:indexPath];
        }
        cell.textLabel.text = @"Send Message";
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (NSString *) formatPhone:(NSString *)phone
{
    if (phone.length != 12) return phone;
    NSString *stringWithoutCountryCode = [phone stringByReplacingOccurrencesOfString:@"+1" withString:@""];
    NSMutableString *prettyPhone = [NSMutableString stringWithString:stringWithoutCountryCode];
    [prettyPhone insertString:@"(" atIndex:0];
    [prettyPhone insertString:@")" atIndex:4];
    [prettyPhone insertString:@"-" atIndex:5];
    [prettyPhone insertString:@"-" atIndex:9];
    return [NSString stringWithString:prettyPhone];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"composeMessageSegue"]) {
        HUBComposeMessageViewController *messageVC = [segue destinationViewController];
        [messageVC setCurrentContact:_contact];
    }
}


@end
