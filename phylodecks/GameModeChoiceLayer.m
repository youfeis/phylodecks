//
//  GameModeChoiceLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-30.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameModeChoiceLayer.h"
#import "LocationConfirmationScene.h"
#import "ChallengeModePrepareScene.h"
#import "MainMenuLayer.h"

@implementation GameModeChoiceLayer

-(id) init {
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
		// create and initialize a Label
        // todo: change text labels to images
        // todo: add a background layer for the mainmenuscene/setting scene
        
        CCSprite *label = [CCSprite spriteWithFile:@"title.png"];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        [label setScale:0.5f];
		// position the label on the center top of the screen
		label.position =  ccp( size.width /2 , 4*size.height/5 );
		
		// add the label as a child to this Layer
		[self addChild: label z:0];
        
        
		//
		// MenuItems
		//
		
		// Set font size
		[CCMenuItemFont setFontSize:28];
		
		// back item
        CCSprite *back1 = [CCSprite spriteWithFile:@"Back.png"];
        CCSprite *back2 = [CCSprite spriteWithFile:@"Back.png"];
        back2.color = ccGRAY;
        CCMenuItemSprite * itemBack = [CCMenuItemSprite itemWithNormalSprite:back1 selectedSprite:back2 block:^(id sender){
            [[self parent] addChild:[[MainMenuLayer alloc] init] z:0 tag:mainMenuLayerTag];
            [self removeFromParentAndCleanup:NO];
            
        }];
        [itemBack setScale:0.5f];
        CCMenu *backMenu = [CCMenu menuWithItems:itemBack, nil];
        backMenu.position = ccp(40.0f,size.height - 20.0f);
        [self addChild:backMenu];
		
        
        // menu buttons
        CCSprite *gpsBattleSprite1 = [CCSprite spriteWithFile:@"GPSMode1.png"];
        CCSprite *gpsBattleSprite2 = [CCSprite spriteWithFile:@"GPSMode2.png"];
        CCMenuItemSprite * itemGPSBattle = [CCMenuItemSprite itemWithNormalSprite:gpsBattleSprite1 selectedSprite:gpsBattleSprite2 block:^(id sender){
            if([[Player currentPlayer] GPSBattleLeft] != 0){
                [self transitToLocationConfirmationScene];
            }
            
        }];
        [itemGPSBattle setScale:0.5f];
        
        CCSprite *challengeSprite1 = [CCSprite spriteWithFile:@"Challenge1.png"];
        CCSprite *challengeSprite2 = [CCSprite spriteWithFile:@"Challenge2.png"];
        CCMenuItemSprite * itemChallengeMode = [CCMenuItemSprite itemWithNormalSprite:challengeSprite1 selectedSprite:challengeSprite2 block:^(id sender){
            [[Map currentMap] setGameMode:0];
            [self transitToChallengeModePrepareScene];
        }];
        [itemChallengeMode setScale:0.5f];
        
    
		
		CCMenu *menuLine1 = [CCMenu menuWithItems:itemChallengeMode, itemGPSBattle, nil];
        
		
		[menuLine1 alignItemsVerticallyWithPadding:20];
		[menuLine1 setPosition:ccp( size.width/2, size.height - 200)];
        
        // text message showing how many gps battles left
		[self addChild:menuLine1];
        
        NSString *battleLeftString = [NSString stringWithFormat:@"You have %i GPS battle left today.",[[Player currentPlayer] GPSBattleLeft]];
        CCLabelTTF *battleLeftInfo = [CCLabelTTF labelWithString:battleLeftString fontName:@"Marker Felt" fontSize:22];;
        [battleLeftInfo setPosition:ccp(size.width/2, 170)];
        [self addChild:battleLeftInfo];

    }
    return self;
}

- (void)transitToLocationConfirmationScene{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[LocationConfirmationScene alloc] init] withColor:ccWHITE]];
}

- (void)transitToChallengeModePrepareScene{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[ChallengeModePrepareScene alloc] init] withColor:ccWHITE]];
}

@end
