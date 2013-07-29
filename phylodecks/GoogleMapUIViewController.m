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



// make GPS start refreshing
- (void)loadView {
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    NSLog(@"%1f,%2f",locationManager.location.coordinate.latitude
          ,locationManager.location.coordinate.longitude);

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