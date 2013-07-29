//
//  GPSMapLayer.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-30.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GoogleMapUIViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "GDataXMLNode.h"
#import "Map.h"
#import "ChallengeModePrepareScene.h"

@interface GPSMapLayer : CCLayer {
    GoogleMapUIViewController *mapView;
    IBOutlet CLLocationManager *locationManager;
    IBOutlet UILabel *latLabel;
    IBOutlet UILabel *longLabel;
}

@end
