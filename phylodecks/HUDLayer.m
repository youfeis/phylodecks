        //
//  HUDLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-15.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"


@implementation HUDLayer

-(id)init{
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        NSString *stepCountString = [NSString stringWithFormat:@"%i",[[Map currentMap] stepCounter]];
        CCLabelTTF *stepCount = [CCLabelTTF labelWithString:stepCountString fontName:@"Marker Felt" fontSize:22];
        stepCount.position = ccp( 0.8f * screenSize.width, 15.0f);
        [self addChild:stepCount z:0 tag:HUDStepCounterTag];
        
        CCSprite *inventory = [CCSprite spriteWithFile:@"inventory.png"];
        inventory.scaleX = screenSize.width/inventory.contentSize.width;
        inventory.scaleY = 75/inventory.contentSize.height;
        inventory.opacity = 128;
        [inventory setPosition:ccp(screenSize.width * 0.5f, 80.0f)];
        [self addChild:inventory];
        
        
    }
    return self;
}

-(void)updateHUD{
    [self removeChildByTag:HUDStepCounterTag cleanup:YES];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    NSString *stepCountString = [NSString stringWithFormat:@"%i",[[Map currentMap] stepCounter]];
    CCLabelTTF *stepCount = [CCLabelTTF labelWithString:stepCountString fontName:@"Marker Felt" fontSize:22];
    stepCount.position = ccp( 0.8f * screenSize.width, 15.0f);
    [self addChild:stepCount z:0 tag:HUDStepCounterTag];
    
}

@end
