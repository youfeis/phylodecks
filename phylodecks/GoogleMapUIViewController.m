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
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    CGSize size = [[CCDirector sharedDirector] winSize];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame: CGRectMake(0,0,size.width,350) camera:camera];
    mapView_.myLocationEnabled = YES;
    
    self.view = mapView_;
    mapView_.mapType = kGMSTypeSatellite;
    
    // Creates a marker of player home
    // todo
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
    //todo
    //create a marker for player current location
}
@end