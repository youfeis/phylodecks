//
//  LocationConfirmationScene.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-30.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LocationConfirmationScene.h"
#import "GPSMapLayer.h"


@implementation LocationConfirmationScene

-(id)init {
    // always call super init
    self = [super init];
    if (self != nil) {
        
        GPSMapLayer *mapLayer = [GPSMapLayer node];
        [self addChild: mapLayer z:0 tag:GPSMapLayerTag];
 
    }
    return self;
}

@end
