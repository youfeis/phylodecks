//
//  MainMenuLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-29.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "GameModeChoiceLayer.h"
#import "nodeTags.h"


@implementation MainMenuLayer

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
		

		CCMenuItem *itemTutorial = [CCMenuItemImage itemWithNormalImage:@"tutorial2.png" selectedImage:@"tutorial1.png" block:^(id sender) {
			
			
			NSLog(@"itemTutorialClicked");
            
  //          [self toTutorialScene];
		}
                                    ];
        [itemTutorial setScale:0.5f];
        
		CCMenuItem *itemSinglePlayer = [CCMenuItemImage itemWithNormalImage:@"play1.png" selectedImage:@"play2.png" block:^(id sender) {

            [self showGameModeChoiceLayer];
            [self hideMainMenuLayer];
           
		}
                                        ];
        [itemSinglePlayer setScale:0.5f];
        CCMenuItem *itemSetting = [CCMenuItemImage itemWithNormalImage:@"settings1.png" selectedImage:@"settings2.png" block:^(id sender){
            
			[self showSettingLayer];
			[self hideMainMenuLayer];
            
		}
                                   ];
        [itemSetting setScale:0.5f];
        
		CCMenuItem *itemExit = [CCMenuItemImage itemWithNormalImage:@"quit1.png" selectedImage:@"quit2.png" block:^(id sender) {
			
			//todo: save user profile
			NSLog(@"itemExitClicked");
           // exit(0);
		}
                                ];
        [itemExit setScale:0.5f];
        
        //Locating menu items before adding them to the layer
        //todo: relocate them to fit in protrait view
		
		CCMenu *menuLine1 = [CCMenu menuWithItems:itemTutorial, itemSinglePlayer ,itemSetting,itemExit, nil];
		
		[menuLine1 alignItemsVerticallyWithPadding:20];
		[menuLine1 setPosition:ccp( size.width/2, size.height - 275)];
        
		// Add the menu to the layer
		[self addChild:menuLine1];
        
	}
	return self;
}

-(void) hideMainMenuLayer{
    [self removeFromParentAndCleanup:YES];
    
}

-(void) showGameModeChoiceLayer{
    GameModeChoiceLayer *gameModeChoiceLayer = [GameModeChoiceLayer node];
    [[self parent] addChild: gameModeChoiceLayer z:-1 tag: gameModeChoiceLayerTag];
}

-(void) showSettingLayer{
    SettingLayer *settingLayer = [SettingLayer node];
    [[self parent] addChild: settingLayer z:-1];
}

@end
