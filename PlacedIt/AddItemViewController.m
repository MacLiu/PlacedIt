//
//  AddItemViewController.m
//  PlacedIt
//
//  Created by Mac Liu on 6/19/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *items; // of NSDctionary
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
    
    self.itemTextField.delegate = self;
    self.locationTextfield.delegate = self;
    
    // Gesture Reconizer to dismiss keybard when background if touched
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Dissmissing Keyboard/UITextfield delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.detailTextView resignFirstResponder];
    return YES;
}


#pragma mark - IBActions
- (IBAction)saveButtonPressed:(UIButton *)sender {
    if ([self.itemTextField.text length] ==  0 || [self.locationTextfield.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Contents" message:@"Please make sure all fields are filled in." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }else {
        self.items = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ITEM_KEY"] mutableCopy];
        if (!self.items) self.items = [[NSMutableArray alloc] init];
        
        [self.items addObject:[self itemInfoAsDictionary]];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.items forKey:@"ITEM_KEY"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
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
        
        return @{@"item": self.itemTextField.text, @"location" : self.locationTextfield.text, @"detail" : self.detailTextView.text, @"image" : UIImageJPEGRepresentation(newImage, 1.0)};
    }
    return @{@"item": self.itemTextField.text, @"location" : self.locationTextfield.text, @"detail" : self.detailTextView.text};
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
    [self.locationTextfield resignFirstResponder];
}

@end
