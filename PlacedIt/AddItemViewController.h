//
//  AddItemViewController.h
//  PlacedIt
//
//  Created by Mac Liu on 6/19/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemViewController : UIViewController

//IBOutlets
@property (strong, nonatomic) IBOutlet UITextField *itemTextField;
@property (strong, nonatomic) IBOutlet UITextField *locationTextfield;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIImage *image;

//IBActions
- (IBAction)saveButtonPressed:(UIButton *)sender;
- (IBAction)cameraButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;

@end
