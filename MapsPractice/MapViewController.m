//
//  MapViewController.m
//  MapsPractice
//
//  Created by Justin Haar on 3/26/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "MapViewController.h"
#import "BusStop.h"
#import <MapKit/MapKit.h>


@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapView.delegate = self;

    [self loadBusStops];

}

//This method loads pins for our bus stops
-(void)loadBusStops
{
    for (BusStop *busStop in self.busStops)
    {
        MKPointAnnotation *busStopAnnotation = [[MKPointAnnotation alloc]init];
        busStopAnnotation.coordinate = busStop.coord;
        [self.mapView addAnnotation:busStopAnnotation];
        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
        CLLocationCoordinate2D center = busStopAnnotation.coordinate;
        [self.mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];

        busStopAnnotation.title = busStop.title;
        busStopAnnotation.subtitle = busStop.routes;
    }
}

#pragma MARK CALLOUT ACTIONS

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    pinAnnotation.canShowCallout = YES;
    pinAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return pinAnnotation;

}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{

    //were supposed to segue to another view controller for more details instead of zooming in here when tapping on callout accessory.
    CLLocationCoordinate2D center = view.annotation.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    [mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];

}
















@end
