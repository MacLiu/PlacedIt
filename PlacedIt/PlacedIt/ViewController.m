//
//  ViewController.m
//  PlacedIt
//
//  Created by Mac Liu on 6/19/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import "ViewController.h"
#import "ItemMapViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = [self.item objectForKey:@"item"];

    
    
    self.textView.text = [self.item objectForKey:@"detail"];
    
    // Gesture Reconizer to dismiss keybard when background if touched
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ItemMapViewController class]]) {
        ItemMapViewController *targetVC = segue.destinationViewController;
        targetVC.item = [self.items objectAtIndex:self.index];
    }
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    [self.item setValue:self.textView.text forKey:@"detail"];
    [self.items replaceObjectAtIndex:self.index withObject:self.item];
    [[NSUserDefaults standardUserDefaults] setObject:self.items forKey:@"ITEM_KEY"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Helper Methods

// Action for gesture reconizer to dismiss keyboard
-(void)hideKeyboard
{
    [self.textView resignFirstResponder];
}
@end

