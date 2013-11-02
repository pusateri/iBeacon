//
//  MasterViewController.h
//  iBeacon
//
//  Created by Tom Pusateri on 11/1/13.
//  Copyright (c) 2013 bangj, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UITextField *identiferField;
@property (strong, nonatomic) IBOutlet UITextField *majorField;
@property (strong, nonatomic) IBOutlet UITextField *minorField;
@property (strong, nonatomic) IBOutlet UITableViewCell *controllCell;

@property (strong, nonatomic) UITextField *editField;
@property () BOOL running;

@end
