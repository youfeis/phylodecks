//
//  SettingLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-25.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

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
		CCMenuItem *itemUserProfile = [CCMenuItemFont itemWithString:@"User Profile" block:^(id sender) {
			[self transitToPlayerProfileScene];	
		}
                                     ];
        
        CCMenuItem *itemBack = [CCMenuItemFont itemWithString:@"Back" block:^(id sender) {
			[[self parent] addChild:[MainMenuLayer node]];
            [self removeFromParentAndCleanup:YES];
            
		}
                                       ];
        
        CCMenu *menuLine1 = [CCMenu menuWithItems:itemUserProfile,itemBack, nil];
		
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
