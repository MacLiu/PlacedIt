//
//  MapViewController.m
//  PlacedIt
//
//  Created by Mac Liu on 7/3/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (nonatomic) CLLocationCoordinate2D location;
@property (strong, nonatomic) NSMutableArray *items; // of NSDctionary

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // Coordinates of the current location
    self.location = [userLocation coordinate];
    
    // Region of the location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.location, 2000, 2000);
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = self.location;
    point.title = @"Current Location";
    
    [self.mapView addAnnotation:point];
    
    //Show the location
    [self.mapView setRegion:region animated:YES];
    
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender
{
    self.items = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ITEM_KEY"] mutableCopy];
    if (!self.items) self.items = [[NSMutableArray alloc] init];
    
    double lat = self.location.latitude;
    double longitude = self.location.longitude;
    
    [self.itemAsPropertyList setObject:[NSNumber numberWithDouble:lat] forKey:@"latitudeLocation"];
    [self.itemAsPropertyList setObject:[NSNumber numberWithDouble:longitude] forKey:@"longitudeLocation"];
    
    [self.items addObject:self.itemAsPropertyList];
     
    [[NSUserDefaults standardUserDefaults] setObject:self.items forKey:@"ITEM_KEY"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
