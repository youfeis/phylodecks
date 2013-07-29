//
//  ChallengeModePrepareScene.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ChallengeModePrepareScene.h"
#import "nodeTags.h"


@implementation ChallengeModePrepareScene


-(id)init {
    // always call super init
    self = [super init];
    if (self != nil) {
        // only Inventory Selection Layer needed in this scene
        
        //adding background
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.anchorPoint = ccp(0,0);
        [background setScaleY: 480/background.contentSize.height];
        [background setScaleX: 320/background.contentSize.width];
        [self addChild:background z:-2];
        
        //adding inventory selection layer
        InventorySelectionLayer *inventorySelectionLayer = [InventorySelectionLayer node];
        [self addChild: inventorySelectionLayer z:0 tag:inventorySelectionLayerTag];
        
    }
    return self;
}

@end
