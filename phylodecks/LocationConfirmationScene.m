//
//  LocationConfirmationScene.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-30.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LocationConfirmationScene.h"
#import "GPSMapLayer.h"
#import "GPSMenuLayer.h"


@implementation LocationConfirmationScene

-(id)init {
    // always call super init
    self = [super init];
    if (self != nil) {
        // add the googlemap layer into locationconfirmationscene
        GPSMapLayer *mapLayer = [GPSMapLayer node];
        [self addChild: mapLayer z:0 tag:GPSMapLayerTag];
     //   GPSMenuLayer *menuLayer = [GPSMenuLayer node];
     //   [self addChild: menuLayer z:0];
    }
    return self;
}

@end
