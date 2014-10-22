//
//  HUBContactListTableViewController.m
//  SimpleSendHub
//
//  Created by Xianjing Hu on 10/21/14.
//  Copyright (c) 2014 Xianjing Hu. All rights reserved.
//

#import "HUBContactListTableViewController.h"
#import "HUBContact.h"
#import "HUBContactsManager.h"
#import "HUBCommunicator.h"
#import "HUBContactDetailTableViewController.h"

@interface HUBContactListTableViewController()<HUBContactsManagerDelegate> {
    NSArray *_contacts;
    HUBContactsManager *_manager;
}

@end

@implementation HUBContactListTableViewController

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
    _manager = [[HUBContactsManager alloc] init];
    _manager.communicator = [[HUBCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    
    [_manager fetchContacts];
}

- (void)didReceiveContacts:(NSArray *)contacts
{
    _contacts = contacts;
    [self.tableView reloadData];
}

- (void)fetchingContactsFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactItemCell" forIndexPath:indexPath];
    
    HUBContact *contact = _contacts[indexPath.row];
    cell.textLabel.text = contact.name;
    
    return cell;
}

- (IBAction)unwindToContactList:(UIStoryboardSegue *)segue
{
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showContactDetailSegue"]) {
        NSIndexPath *selectedRow = [[self tableView] indexPathForSelectedRow];
        HUBContact *currentContact = [_contacts objectAtIndex:[selectedRow row]];
        HUBContactDetailTableViewController *contactDetailVC = [segue destinationViewController];
        [contactDetailVC setCurrentContact:currentContact];
    }
}

@end
