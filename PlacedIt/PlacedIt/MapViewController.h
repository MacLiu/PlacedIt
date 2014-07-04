//
//  MapViewController.h
//  PlacedIt
//
//  Created by Mac Liu on 7/3/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController : ViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableDictionary *itemAsPropertyList;

//IBActions
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;
@end
