//
//  MapInventoryLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-06.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//  The class displays users card on hand

#import "MapInventoryLayer.h"
#import "MainMenuScene.h"


enum nodeTags2
{
	
	// Tag to get children in updateForScreenReshape
	kMenu,
	kAdvice,
	
	// Vertical Test Node Additional Tags
	kBackButtonMenu,
	kWidget,
    kWidgetReversed,
	
	// Priority Test Node Additional Tags
	kMenu2,
    
    //
    tutorialLayerTag,
    toggleButtonTag
};


@implementation MapInventoryLayer
- (id) init
{
	if ( (self=[super init]) )
	{
        CCNode *widget = [self widget];
        [self addChild: widget z: 1 tag: kWidget];
		
		[self updateForScreenReshape];
	}
	
	return self;
}


//enabling dragging horizontally the inventory
- (void) updateForScreenReshape
{
	CGSize s = [CCDirector sharedDirector].winSize;

	
	// Position Menu at Center.
	CCMenuAdvanced *menu = (CCMenuAdvanced *)[self getChildByTag: kMenu];
	menu.anchorPoint = ccp(0.5f,0.5f);
	menu.position = ccp( 0.5f * s.width, 0.5f * s.height);
    
    [self updateWidget];
}

- (CCNode *) widget
{
	// Prepare Menu.
	CCMenuAdvanced *menu = [CCMenuAdvanced menuWithItems: nil];
	
	// Prepare menu items.
    
	for (id obj in [[Map currentMap] mapInventory])
	{
        
		CCMenuItemSprite *item =
		[CCMenuItemSprite itemWithNormalSprite: obj
								selectedSprite: nil
                                         block:^(id sender){
                                             
                                             //if clicked showing the full screen cards and remove other layers
                                             [[Map currentMap] setSelected:obj];
                                             FullScreenCardViewLayer * viewer = [[FullScreenCardViewLayer alloc] initWithCard:obj];
                                             for(id obj in [[self parent] children]){
                                                 [obj setPosition:CGPointMake(-1000, -1000)];
                                             }
                                             [[self parent]addChild:viewer];
                                             [[[Map currentMap] mapInventory] removeObject:obj];
 
                                         }];
		[item setScaleY: 72/item.contentSize.height];
        [item setScaleX: 52/item.contentSize.width];
		[menu addChild: item];
	}
	
	// Enable Debug Draw (available only when DEBUG is defined )
#ifdef DEBUG
	menu.debugDraw = NO;
#endif
	
	// Setup Menu Alignment.
	[menu alignItemsHorizontally]; //< also sets contentSize and keyBindings on Mac
	
	return menu;
}


// enabling dragging the inventory
- (void) updateWidget
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	CCMenuAdvanced *menu = (CCMenuAdvanced *) [self getChildByTag:kWidget];
	
	// Initial position.
	menu.anchorPoint = ccp(0, 0.5f);
	menu.position = ccp(0.5f * winSize.width, 0.5f * winSize.height);
	
	menu.scale = MIN ((winSize.height / 2.0f) / menu.contentSize.height, 0.75f );
	
	menu.boundaryRect = CGRectMake( 25.0f,
								   0.5f * winSize.height - 3.5f * [menu boundingBox].size.height ,
								   50.0f,
								   [menu boundingBox].size.height );

	// Show first menuItem (scroll max to the left).
	menu.position = ccp(0, 0.5f * winSize.height);
	
    [menu fixPosition];
}


- (void) backToMainMenu: (id) sender
{
    [[self parent] removeAllChildrenWithCleanup:YES];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init] withColor:ccWHITE]];
    
}

//refreshes menu if a card is removed or added back
- (void) reformatMenu{
    [[self getChildByTag:kMenu] removeAllChildrenWithCleanup:YES];
    [[self getChildByTag:kWidget] removeAllChildrenWithCleanup:YES];
    [self removeChildByTag:kMenu cleanup:YES];
    [self removeChildByTag:kWidget cleanup:YES];
    CCNode *widget = [self widget];
    [self addChild: widget z: 1 tag: kWidget];
    [self updateForScreenReshape];
}


@end