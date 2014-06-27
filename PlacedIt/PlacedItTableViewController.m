//
//  PlacedItTableViewController.m
//  PlacedIt
//
//  Created by Mac Liu on 6/19/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import "ViewController.h"
#import "PlacedItTableViewController.h"

@interface PlacedItTableViewController ()

@end

@implementation PlacedItTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.items = [[self retrieveItems] mutableCopy];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor blackColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *item = [self.items objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = [item objectForKey:@"item"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [item objectForKey:@"location"];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageWithData:[item objectForKey:@"image"]];
    
    float startValue = 0.3;
    float colorFade = (indexPath.row + 1) * .1 + startValue;
    cell.backgroundColor = [UIColor colorWithRed:0.0 green:colorFade blue:0.0 alpha:1.0];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedItem = [self.items objectAtIndex:indexPath.row];
    self.index = indexPath.row;
    [self performSegueWithIdentifier:@"toViewController" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.items removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:self.items forKey:@"ITEM_KEY"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ViewController class]]) {
        ViewController *targetVC = segue.destinationViewController;
        targetVC.item = [self.selectedItem mutableCopy];
        targetVC.items = self.items;
        targetVC.index = self.index;
    }
}

- (IBAction)addItemButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddItemViewController" sender:self];
}

#pragma mark - Helper Method

-(NSArray *)retrieveItems
{
    NSArray *items = [[NSUserDefaults standardUserDefaults] objectForKey:@"ITEM_KEY"];
    if (!items) {
        items = [[NSArray alloc]init];
    }
    return items;
}

@end
