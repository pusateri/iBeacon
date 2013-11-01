//
//  MasterViewController.m
//  iBeacon
//
//  Created by Tom Pusateri on 11/1/13.
//  Copyright (c) 2013 bangj, LLC. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    NSString *idString = [[NSUserDefaults standardUserDefaults] objectForKey:defaultIdentifierKey];
    self.identiferField.text = idString;
    NSNumber *major = [[NSUserDefaults standardUserDefaults] objectForKey:defaultMajorKey];
    self.majorField.text = [major stringValue];
    NSNumber *minor = [[NSUserDefaults standardUserDefaults] objectForKey:defaultMinorKey];
    self.minorField.text = [minor stringValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSManagedObject *object = nil;
        [[segue destinationViewController] setDetailItem:object];
    }
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSManagedObject *object = nil;
        self.detailViewController.detailItem = object;
    }
    if (self.editField) {
        [self.editField resignFirstResponder];
    }
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.editField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.identiferField) {
        NSString *old = [[NSUserDefaults standardUserDefaults] objectForKey:defaultIdentifierKey];
        if (![old isEqualToString:textField.text]) {
            [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:defaultIdentifierKey];
        }
    } else if (textField == self.majorField) {
        NSNumber *old = [[NSUserDefaults standardUserDefaults] objectForKey:defaultMajorKey];
        if (![[old stringValue] isEqualToString:textField.text]) {
            NSNumber *new = [NSNumber numberWithInt:[textField.text intValue]];
            [[NSUserDefaults standardUserDefaults] setObject:new forKey:defaultMajorKey];
        }
    } else if (textField == self.minorField) {
        NSNumber *old = [[NSUserDefaults standardUserDefaults] objectForKey:defaultMinorKey];
        if (![[old stringValue] isEqualToString:textField.text]) {
            NSNumber *new = [NSNumber numberWithInt:[textField.text intValue]];
            [[NSUserDefaults standardUserDefaults] setObject:new forKey:defaultMinorKey];
        }
    }
    self.editField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
