//
//  MapInventoryLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-06.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MapInventoryLayer.h"
#import "MainMenuScene.h"


enum nodeTags2
{
	// Tags to distinguish what button was pressed.
	kItemVerticalTest,
	kItemHorizontalTest,
	kItemPriorityTest,
	
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
        CGSize s = [[CCDirector sharedDirector] winSize];
		// Create advice label.
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Welcome to tutorial." fontName:@"Marker Felt" fontSize:24];
		CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Press on a card to enable dragging to the map," fontName:@"Marker Felt" fontSize:24];
        CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"holding the card to see card details." fontName:@"Marker Felt" fontSize:24];
        CCLabelTTF *label4 = [CCLabelTTF labelWithString:@"Swipe the inventory to view through the cards." fontName:@"Marker Felt" fontSize:24];
        
        CCLabelTTF *labelBack = [CCLabelTTF labelWithString:@"Back <<" fontName:@"Marker Felt" fontSize:24];
        CCLabelTTF *labelHide = [CCLabelTTF labelWithString:@"Hide" fontName:@"Marker Felt" fontSize:24];
        
		label2.anchorPoint = ccp(0.5f, 1);
		label2.position = ccp(0.5f * label.contentSize.width, 0);
        label3.anchorPoint = ccp(0.5f, 1);
		label3.position = ccp(0.5f * label2.contentSize.width, 0);
        label4.anchorPoint = ccp(0.5f, 1);
		label4.position = ccp(0.5f * label3.contentSize.width, 0);
        
        
		[label addChild: label2];
        [label2 addChild: label3];
        [label3 addChild: label4];
        
		[self addChild: label z:1 tag: kAdvice];
        CCNode *widget = [self widget];
        [self addChild: widget z: 1 tag: kWidget];
        
        CCMenuItemLabel *back = [CCMenuItemLabel itemWithLabel: labelBack target: self selector: @selector(backToMainMenu:)];
        CCMenuItemLabel *hide = [CCMenuItemLabel itemWithLabel: labelHide target: self selector: @selector(toggleTutorialText:)];
        
        CCMenu *menu = [CCMenu menuWithItems: back,nil];
        CCMenu *menu2 = [CCMenu menuWithItems: hide,nil];
        
        [menu setPosition: ccp(18.0f + s.width / 20, s.height - 30.0f)];
        [menu2 setPosition: ccp(0.98 * s.width -18.0f, s.height - 30.0f)];
        
        [self addChild: menu];
        [self addChild: menu2 z:1 tag:toggleButtonTag];
		
		[self updateForScreenReshape];
	}
	
	return self;
}

- (CCLabelTTF *) adviceLabel
{
	CCLabelTTF *label = [CCLabelTTF labelWithString:@"Horizontal Test." fontName:@"Marker Felt" fontSize:24];
	CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Scrollable menu should be at the center." fontName:@"Marker Felt" fontSize:24];
	label2.anchorPoint = ccp(0.5f, 1);
	label2.position = ccp(0.5f * label.contentSize.width, 0);
	[label addChild: label2];
	
	return label;
}

- (void) updateForScreenReshape
{
	CGSize s = [CCDirector sharedDirector].winSize;
	
	// Position label at top.
	CCLabelTTF *label = (CCLabelTTF *)[self getChildByTag: kAdvice];
	label.anchorPoint = ccp(0.5f,1);
	label.position = ccp( 0.5f * s.width, 0.9f * s.height);
	
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
        
        //       CCSprite *originalImage = [CCSprite spriteWithFile: fileName];
   //     CCSprite *scaledImage = obj;
   //     [scaledImage setScaleY: 72/scaledImage.contentSize.height];
   //     [scaledImage setScaleX: 52/scaledImage.contentSize.width];
		// Create menu item.
        
		CCMenuItemSprite *item =
		[CCMenuItemSprite itemWithNormalSprite: obj
								selectedSprite: nil
                                         block:^(id sender){
                                             [[Map currentMap] setSelected:obj];
                                             FullScreenCardViewLayer * viewer = [[FullScreenCardViewLayer alloc] initWithCard:obj];
                                             for(id obj in [[self parent] children]){
                                                 [obj setPosition:CGPointMake(-1000, -1000)];
                                             }
                                             [[self parent]addChild:viewer];
 
                                         }];
		[item setScaleY: 72/item.contentSize.height];
        [item setScaleX: 52/item.contentSize.width];
	//	[[item selectedImage] setScaleY: 10000/[item selectedImage].contentSize.height];
	//	[[item selectedImage] setScaleX: 7500/[item selectedImage].contentSize.width];
		// Add it.
		[menu addChild: item];
	}
	
	// Enable Debug Draw (available only when DEBUG is defined )
#ifdef DEBUG
	menu.debugDraw = YES;
#endif
	
	// Setup Menu Alignment.
	[menu alignItemsHorizontally]; //< also sets contentSize and keyBindings on Mac
	
	return menu;
}

- (CCNode *) widgetReversed
{
    return nil;
}

- (void) updateWidget
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	CCMenuAdvanced *menu = (CCMenuAdvanced *) [self getChildByTag:kWidget];
	
	// Initial position.
	menu.anchorPoint = ccp(0.5f, 0.5f);
	menu.position = ccp(0.5f * winSize.width, 0.5f * winSize.height);
	
	menu.scale = MIN ((winSize.height / 2.0f) / menu.contentSize.height, 0.75f );
	
	menu.boundaryRect = CGRectMake( 25.0f,
								   0.5f * winSize.height - 2.0f * [menu boundingBox].size.height ,
								   winSize.width - 50.0f,
								   [menu boundingBox].size.height );
	
	// Show first menuItem (scroll max to the left).
	menu.position = ccp(menu.contentSize.width / 2.0f, 0.5f * winSize.height);
	
	[menu fixPosition];
}
- (void) itemPressed: (id) sender
{

}

- (void) backToMainMenu: (id) sender
{
    [self removeAllChildrenWithCleanup:YES];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init] withColor:ccWHITE]];
    
}

- (void) toggleTutorialText: (id) sender
{
    [self removeChildByTag:kAdvice cleanup:YES];
    [self removeChildByTag:toggleButtonTag cleanup:YES];
    
}

- (void) reformatMenu{
    [self removeChildByTag:kWidget cleanup:YES];
    CCNode *widget = [self widget];
    [self addChild: widget z: 1 tag: kWidget];
    [self updateForScreenReshape];
}

-(void) removeCard:(CCSprite *) cardSprite
{
    
}

-(void) cardMoveLeft:(CCSprite*) cardSprite
{
    
}
-(void) addCard:(CCSprite *) cardSprite
{
    
}

@end