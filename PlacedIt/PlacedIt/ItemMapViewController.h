//
//  ItemMapViewController.h
//  PlacedIt
//
//  Created by Mac Liu on 7/3/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ItemMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) NSMutableDictionary *item;

@end
