//
//  DetailViewController.h
//  iBeacon
//
//  Created by Tom Pusateri on 11/1/13.
//  Copyright (c) 2013 bangj, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTBeaconManager.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, ESTBeaconManagerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) ESTBeaconManager *beaconManager;
@property (strong, nonatomic) IBOutlet UILabel *majorLabel;
@property (strong, nonatomic) IBOutlet UILabel *minorLabel;
@property (strong, nonatomic) IBOutlet UILabel *uuidLabel;

- (void)start;
- (void)stop;

@end
