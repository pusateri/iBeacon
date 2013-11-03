//
//  DetailViewController.m
//  iBeacon
//
//  Created by Tom Pusateri on 11/1/13.
//  Copyright (c) 2013 bangj, LLC. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)resetView
{
    self.majorLabel.text = @"Major";
    self.minorLabel.text = @"Minor";
    self.uuidLabel.text = @"UUID";
}

- (void)start
{
    NSString *idString = [[NSUserDefaults standardUserDefaults] objectForKey:defaultIdentifierKey];
    NSNumber *major = [[NSUserDefaults standardUserDefaults] objectForKey:defaultMajorKey];
    self.majorLabel.text = [major stringValue];
    NSNumber *minor = [[NSUserDefaults standardUserDefaults] objectForKey:defaultMinorKey];
    self.minorLabel.text = [minor stringValue];
    
    ESTBeaconManager *manager = [[ESTBeaconManager alloc] init];
    manager.delegate = self;
    self.beaconManager = manager;
    
    [self.beaconManager startAdvertisingWithMajor:[major intValue] withMinor:[minor intValue] withIdentifier:idString];
}

- (void)stop
{
    [self.beaconManager stopAdvertising];
    [self resetView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
    }
    [super viewWillDisappear:animated];
    
    [self stop];
    self.autostart = NO;
    self.beaconManager = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self resetView];
    
    if (self.autostart) {
        [self start];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ESTBeaconManager Delegate

- (void)beaconManagerDidStartAdvertising:(ESTBeaconManager *)manager error:(NSError *)error
{
    if (error) {
        NSLog(@"beaconManagerDidStartAdvertising: %@", [error localizedDescription]);
    } else {
        ESTBeaconRegion *region = manager.virtualBeaconRegion;
        NSUUID *uuid = region.proximityUUID;
        self.uuidLabel.text = [uuid UUIDString];
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Setup", @"Setup");
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
