//
//  GoogleMapUIViewController.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-30.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GoogleMapUIViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@implementation GoogleMapUIViewController {
    GMSMapView *mapView_;
}


// You don't need to modify the default initWithNibName:bundle: method.


- (void)loadView {
    
//    CGSize size = [[CCDirector sharedDirector] winSize];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    NSLog(@"%1f,%2f",locationManager.location.coordinate.latitude
          ,locationManager.location.coordinate.longitude);

   /* GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude
                                                            longitude:locationManager.location.coordinate.longitude
                                                                 zoom:5];
    mapView_ = [GMSMapView mapWithFrame: CGRectMake(0,0,size.width,350) camera:camera];
    mapView_.myLocationEnabled = YES;
    
    self.view = mapView_;
    
    // Creates a marker of player home
    // todo
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    marker.title = @"Current Location";
    marker.snippet = @"Player";
    marker.map = mapView_;
    //todo
    //create a marker for player current location*/
}

-(void)relocate{
    
    NSLog(@"%1f,%2f",locationManager.location.coordinate.latitude
          ,locationManager.location.coordinate.longitude);
}

-(float)latitude{
    return locationManager.location.coordinate.latitude;
}

-(float)longitude{
    return locationManager.location.coordinate.longitude;
}

@end