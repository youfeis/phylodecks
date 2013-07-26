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
		
		// Create mainmenu items
		CCMenuItem *itemGPSBattle = [CCMenuItemFont itemWithString:@"GPS Battle" block:^(id sender) {
			[self transitToLocationConfirmationScene]; 
		}
                                    ];
        
		CCMenuItem *itemChallengeMode = [CCMenuItemFont itemWithString:@"Challenge Mode" block:^(id sender) {
            [self transitToChallengeModePrepareScene];
		}
                                        ];
        //Locating menu items before adding them to the layer
        //todo: relocate them to fit in protrait view
        //todo: add return button layer
		
		CCMenu *menuLine1 = [CCMenu menuWithItems:itemChallengeMode, itemGPSBattle, nil];
        //todo: add a counter to show how many chances left for playing a GPS Battle
		
		[menuLine1 alignItemsVerticallyWithPadding:20];
		[menuLine1 setPosition:ccp( size.width/2, size.height - 200)];
        
        // Add the menu to the layer
		[self addChild:menuLine1];
        
        NSString *battleLeftString = [NSString stringWithFormat:@"You have %i GPS battle left today.",[[Player currentPlayer] GPSBattleLeft]];
        CCLabelTTF *battleLeftInfo = [CCLabelTTF labelWithString:battleLeftString fontName:@"Marker Felt" fontSize:22];;
        [battleLeftInfo setPosition:ccp(size.width/2, 200)];
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
