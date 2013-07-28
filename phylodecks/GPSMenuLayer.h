//
//  GPSMenuLayer.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-30.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Map.h"
#import <CoreLocation/CoreLocation.h>
#import "GDataXMLNode.h"
#import "ChallengeModePrepareScene.h"

@interface GPSMenuLayer : CCLayer {
    IBOutlet CLLocationManager *locationManager;
    IBOutlet UILabel *latLabel;
    IBOutlet UILabel *longLabel;
}

@end
