//
//  DetailViewController.m
//  iBeacon
//
//  Created by Tom Pusateri on 11/1/13.
//  Copyright (c) 2013 bangj, LLC. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startup
{
    ESTBeaconManager *manager = [[ESTBeaconManager alloc] init];
    manager.delegate = self;
    self.beaconManager = manager;
    
    [self performSelector:@selector(advertise) withObject:nil afterDelay:1.0];
}

- (void)advertise
{
    ESTBeaconMajorValue major16 = 88;
    ESTBeaconMinorValue minor16 = 8;
    NSNumber *meetingNumber = [NSNumber numberWithInt:major16];
    NSNumber *roomNumber = [NSNumber numberWithInt:minor16];
    self.majorLabel.text = [meetingNumber stringValue];
    self.minorLabel.text = [roomNumber stringValue];
    [self.beaconManager startAdvertisingWithMajor:major16 withMinor:minor16 withIdentifier:@"IETF"];
}

#pragma mark ESTBeaconManager Delegate

- (void)beaconManagerDidStartAdvertising:(ESTBeaconManager *)manager error:(NSError *)error
{
    if (error) {
        NSLog(@"beaconManagerDidStartAdvertising: %@", [error localizedDescription]);
    } else {
        ESTBeaconRegion *region = manager.virtualBeaconRegion;
        NSUUID *uuid = region.proximityUUID;
        self.minorLabel.text = [uuid UUIDString];
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
