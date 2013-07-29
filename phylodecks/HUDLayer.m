        //
//  HUDLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-15.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "MainMenuLayer.h"


@implementation HUDLayer

-(id)init{
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSprite *back1 = [CCSprite spriteWithFile:@"Back.png"];
        CCSprite *back2 = [CCSprite spriteWithFile:@"Back.png"];
        back2.color = ccGRAY;
        CCMenuItemSprite * itemBack = [CCMenuItemSprite itemWithNormalSprite:back1 selectedSprite:back2 block:^(id sender){
            [[self parent] removeAllChildrenWithCleanup:YES];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init] withColor:ccWHITE]];
            
        }];
        [itemBack setScale:0.5f];
        CCMenu *backMenu = [CCMenu menuWithItems:itemBack, nil];
        backMenu.position = ccp(40.0f,screenSize.height - 20.0f);
        [self addChild:backMenu];
        
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
        
        
        
        CCLabelTTF *debug1 = [CCLabelTTF labelWithString:@"wingame" fontName:@"Marker Felt" fontSize:22];
        

        CCLabelTTF *debug2 = [CCLabelTTF labelWithString:@"losegame" fontName:@"Marker Felt" fontSize:22];
    
        
        CCMenu *debugMenu = [CCMenu menuWithItems:[CCMenuItemLabel itemWithLabel:debug1 block:^(id sender) {
            [self winGame];
        }],[CCMenuItemLabel itemWithLabel:debug2 block:^(id sender) {
            [self loseGame];
        }], nil];
        [debugMenu alignItemsVerticallyWithPadding:3.0f];
        debugMenu.position = ccp( 0.8f * screenSize.width, screenSize.height - 15.0f);
        //[self addChild:debugMenu];
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

-(void)winGame{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[GameOverScene alloc] initWithMode:1] withColor:ccWHITE]];
}

-(void)loseGame{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[GameOverScene alloc] initWithMode:0] withColor:ccWHITE]];
}

@end
