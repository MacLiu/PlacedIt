//
//  AddItemViewController.m
//  PlacedIt
//
//  Created by Mac Liu on 6/19/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import "AddItemViewController.h"
#import "MapViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

@interface AddItemViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@end

@implementation AddItemViewController

-(UIImagePickerController *)imagePickerController
{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
    }
    return _imagePickerController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.viewLocation.layer.cornerRadius = 8;
    self.viewLocation.layer.borderWidth = 1;
    self.viewLocation.layer.borderColor = [UIColor grayColor].CGColor;
    self.viewLocation.clipsToBounds = YES;
    
    self.itemTextField.delegate = self;
    self.locationTextField.delegate = self;
    
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
    if ([segue.destinationViewController isKindOfClass:[MapViewController class]]) {
        MapViewController *targetVC = segue.destinationViewController;
        targetVC.itemAsPropertyList = [[self itemInfoAsDictionary] mutableCopy];
    }
}

#pragma mark - Dissmissing Keyboard/UITextfield delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.detailTextView resignFirstResponder];
    return YES;
}


#pragma mark - IBActions
- (IBAction)saveButtonPressed:(UIButton *)sender
{
    if ([self.itemTextField.text length] ==  0 || [self.locationTextField.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Contents" message:@"Please make sure all fields are filled in." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }else {
         [self performSegueWithIdentifier:@"toViewLocation" sender:self];
    }
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)cameraButtonPressed:(UIBarButtonItem *)sender {
    // Create and setup the imagePickercontroller
    self.imagePickerController.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // Presents the imagePickerController on the screen
    [self presentViewController:self.imagePickerController animated:NO completion:nil];
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - HelperMethod

-(NSDictionary *)itemInfoAsDictionary
{
    if (self.image != nil) {
        UIImage *newImage = [self resizeImageWithWidth:160.0 Height:160.0];
        
        return @{@"item": self.itemTextField.text, @"detail" : self.detailTextView.text, @"location" : self.locationTextField.text, @"image" : UIImageJPEGRepresentation(newImage, 1.0)};
    }
    return @{@"item": self.itemTextField.text, @"detail" : self.detailTextView.text, @"location" : self.locationTextField.text};
}

-(UIImage *)resizeImageWithWidth:(float)width Height:(float)height
{
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self.image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

// Action for gesture reconizer to dismiss keyboard
-(void)hideKeyboard
{
    [self.itemTextField resignFirstResponder];
    [self.detailTextView resignFirstResponder];
    [self.locationTextField resignFirstResponder];
}

@end
