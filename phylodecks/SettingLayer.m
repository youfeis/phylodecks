//
//  SettingLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-25.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//  layer/scene showing player stats, can be used as setting in future

#import "SettingLayer.h"


@implementation SettingLayer

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
        
        // Set font size
		[CCMenuItemFont setFontSize:28];
		
		// Create mainmenu items
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
		
        CCSprite *userProfileSprite1 = [CCSprite spriteWithFile:@"UserProfile1.png"];
        CCSprite *userProfileSprite2 = [CCSprite spriteWithFile:@"UserProfile2.png"];
        CCMenuItemSprite * itemUserProfile = [CCMenuItemSprite itemWithNormalSprite:userProfileSprite1 selectedSprite:userProfileSprite2 block:^(id sender){
                [self transitToPlayerProfileScene];
            
        }];
        [itemUserProfile setScale:0.5f];
        
        CCMenu *menuLine1 = [CCMenu menuWithItems:itemUserProfile,nil];
        //todo: add a counter to show how many chances left for playing a GPS Battle
		
		[menuLine1 alignItemsVerticallyWithPadding:20];
		[menuLine1 setPosition:ccp( size.width/2, size.height - 200)];
        
        // Add the menu to the layer
		[self addChild:menuLine1];
        
    }
    
    return self;
}

- (void)transitToPlayerProfileScene{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[PlayerSelectionScene alloc] init] withColor:ccWHITE]];
}

@end
