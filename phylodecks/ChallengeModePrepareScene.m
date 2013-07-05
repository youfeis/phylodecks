//
//  ChallengeModePrepareScene.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ChallengeModePrepareScene.h"


@implementation ChallengeModePrepareScene


-(id)init {
    // always call super init
    self = [super init];
    if (self != nil) {

        InventorySelectionLayer *inventorySelectionLayer = [InventorySelectionLayer node];
        [self addChild: inventorySelectionLayer];
        
    }
    return self;
}

@end
