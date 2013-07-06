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
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"PHYLODECKS" fontName:@"Marker Felt" fontSize:64];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
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
		CCMenuItem *itemTutorial = [CCMenuItemFont itemWithString:@"Tutorial" block:^(id sender) {
			
			
			NSLog(@"itemTutorialClicked");
            
  //          [self toTutorialScene];
		}
                                    ];
        
		CCMenuItem *itemSinglePlayer = [CCMenuItemFont itemWithString:@"Single Player" block:^(id sender) {
			
			
			NSLog(@"itemSinglePlayerClicked");
            [self showGameModeChoiceLayer];
            [self hideMainMenuLayer];
           
		}
                                        ];
        
        CCMenuItem *itemSetting = [CCMenuItemFont itemWithString:@"Setting " block:^(id sender) {
			
			//todo: setting interface
			NSLog(@"itemSettingClicked");
		}
                                   ];
        
		CCMenuItem *itemExit = [CCMenuItemFont itemWithString:@"     Exit    " block:^(id sender) {
			
			//todo: save user profile
			NSLog(@"itemExitClicked");
           // exit(0);
		}
                                ];
        
        //Locating menu items before adding them to the layer
        //todo: relocate them to fit in protrait view
		
		CCMenu *menuLine1 = [CCMenu menuWithItems:itemTutorial, itemSinglePlayer, nil];
		
		[menuLine1 alignItemsHorizontallyWithPadding:20];
		[menuLine1 setPosition:ccp( size.width/2, size.height - 150)];
        
        CCMenu *menuLine2 = [CCMenu menuWithItems:itemSetting, itemExit, nil];
        
        [menuLine2 alignItemsHorizontallyWithPadding:20];
		[menuLine2 setPosition:ccp( size.width/2, size.height - 180)];
		
		// Add the menu to the layer
		[self addChild:menuLine1];
        [self addChild:menuLine2];
        
	}
	return self;
}

-(void) hideMainMenuLayer{
    [[self parent] removeChildByTag:mainMenuLayerTag cleanup:YES];
    
}

-(void) showGameModeChoiceLayer{
    GameModeChoiceLayer *gameModeChoiceLayer = [GameModeChoiceLayer node];
    [[self parent] addChild: gameModeChoiceLayer z:-1 tag: gameModeChoiceLayerTag];
}

@end
