//
//  ViewController.h
//  PlacedIt
//
//  Created by Mac Liu on 6/19/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(strong,nonatomic)NSMutableDictionary *item;
@property(strong,nonatomic)NSMutableArray *items; //of NSDictionary
@property(nonatomic)NSInteger index;

//IBOutlets
@property (strong, nonatomic) IBOutlet UITextView *textView;


//IBaction
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@end

