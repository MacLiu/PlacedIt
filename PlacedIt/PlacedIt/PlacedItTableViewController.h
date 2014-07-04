//
//  PlacedItTableViewController.h
//  PlacedIt
//
//  Created by Mac Liu on 6/19/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemViewController.h"

@interface PlacedItTableViewController : UITableViewController

@property(strong, nonatomic)NSMutableArray *items; // of NSDictionary
@property(strong, nonatomic)NSDictionary *selectedItem;
@property(nonatomic)NSInteger index;


- (IBAction)addItemButtonPressed:(UIBarButtonItem *)sender;


@end

