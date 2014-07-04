//
//  ItemMapViewController.m
//  PlacedIt
//
//  Created by Mac Liu on 7/3/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import "ItemMapViewController.h"

@interface ItemMapViewController ()

@end

@implementation ItemMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // Coordinates of the current location
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([[self.item objectForKey:@"latitudeLocation"] doubleValue], [[self.item objectForKey:@"longitudeLocation"] doubleValue]);
    
    // Region of the location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 2000, 2000);
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    point.title = [self.item objectForKey:@"item"];
    
    [self.mapView addAnnotation:point];
    
    //Show the location
    [self.mapView setRegion:region animated:YES];
    
}
@end
