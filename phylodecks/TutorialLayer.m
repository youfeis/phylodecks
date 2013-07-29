//
//  TutorialLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-29.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TutorialLayer.h"
#import "MainMenuScene.h"


@implementation TutorialLayer

enum nodeTags2
{
	kScrollLayer = 256,
	kAdviceLabel = 257,
	kFastPageChangeMenu = 258
};

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
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
        
        // Add fast page change menu.
		[self updateFastPageChangeMenu];
        
        
		
		// Do initial positioning & create scrollLayer.
		[self updateForScreenReshape];
        [self changeColorPressed:self];

    }
    return self;
}

+(CCScene *) scene{
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TutorialLayer *layer = [TutorialLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) updateFastPageChangeMenu
{
	// Remove fast page change menu if it exists.
	[self removeChildByTag:kFastPageChangeMenu cleanup:YES];
	
	// Get total current pages count.
	int pagesCount = [[self scrollLayerPages]count];
	CCScrollLayer *scroller = (CCScrollLayer *)[self getChildByTag:kScrollLayer];
	if (scroller)
	{
		pagesCount = [[scroller pages] count];
	}
	
	// Create & add fast-page-change menu.
	CCMenu *fastPageChangeMenu = [CCMenu menuWithItems: nil];
	for (int i = 0; i < pagesCount ; ++i)
	{
		NSString *numberString = [NSString stringWithFormat:@"%d", i];
		CCLabelTTF *labelWithNumber = [CCLabelTTF labelWithString:numberString fontName:@"Marker Felt" fontSize:22];
		CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:labelWithNumber target:self selector:@selector(fastMenuItemPressed:)];
		[fastPageChangeMenu addChild: item z: 0 tag: i];
	}
	[fastPageChangeMenu alignItemsHorizontally];
	[self addChild: fastPageChangeMenu z: 0 tag: kFastPageChangeMenu];
	
	// Position fast page change menu without calling updateForScreenReshape.
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	fastPageChangeMenu.position = ccp( 0.5f * screenSize.width, 15.0f);
}

// Positions children of CCScrollLayerTestLayer.
// ScrollLayer is updated via deleting old and creating new one.
// (Cause it's created with pages - normal CCLayer, which contentSize = winSize)
- (void) updateForScreenReshape
{
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	
	CCNode *fastPageChangeMenu = [self getChildByTag:kFastPageChangeMenu];
	CCNode *adviceLabel = [self getChildByTag:kAdviceLabel];
	
	fastPageChangeMenu.position = ccp( 0.5f * screenSize.width, 15.0f);
	adviceLabel.anchorPoint = ccp(0.5f, 1.0f);
	adviceLabel.position = ccp(0.5f * screenSize.width, screenSize.height);
	
	// ReCreate Scroll Layer for each Screen Reshape (slow, but easy).
	CCScrollLayer *scrollLayer = (CCScrollLayer *)[self getChildByTag:kScrollLayer];
	if (scrollLayer)
	{
		[self removeChild:scrollLayer cleanup:YES];
	}
	
	scrollLayer = [self scrollLayer];
	[self addChild: scrollLayer z: 0 tag: kScrollLayer];
	[scrollLayer selectPage: 0];
	scrollLayer.delegate = self;
}

#pragma mark ScrollLayer Creation

// Returns array of CCLayers - pages for ScrollLayer.
- (NSArray *) scrollLayerPages
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    // PAGE 2 - Custom Font Menu in the center.
	CCLayer *page1 = [CCLayer node];
    CCSprite * tut1 =[CCSprite spriteWithFile:@"tut1.png"];
    tut1.anchorPoint = ccp(0,0);
    [tut1 setScaleY: 480/tut1.contentSize.height];
    [tut1 setScaleX: 320/tut1.contentSize.width];
    
    CCLabelTTF *tutlabel1 = [CCLabelTTF labelWithString:@"Before starting a game, you can choose your deck for this game from your inventory. " dimensions:screenSize hAlignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:24];
    tutlabel1.position = ccp(screenSize.width/2,-50);
    
    [page1 addChild:tut1];
    [page1 addChild:tutlabel1];
    
    
    
    CCLayer *page2 = [CCLayer node];
    CCSprite * tut2 =[CCSprite spriteWithFile:@"tut2.png"];
    tut2.anchorPoint = ccp(0,0);
    [tut2 setScaleY: 480/tut2.contentSize.height];
    [tut2 setScaleX: 320/tut2.contentSize.width];
    
    CCLabelTTF *tutlabel2 = [CCLabelTTF labelWithString:@"You will get full screen view of a card when selecting.Notice the CLIMATE fo the card (right left corner),TERRAIN of the card (3 circles right left corner), SCALE (right top figure without circle),FOODCHAIN (right top figure in a circle),and DIET(the color of the right top circle) " dimensions:screenSize hAlignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:24];
    tutlabel2.position = ccp(screenSize.width/2,165);
    
    [page2 addChild:tut2];
    [page2 addChild:tutlabel2];
    
    
    
    CCLayer *page3 = [CCLayer node];
    CCSprite * tut3 =[CCSprite spriteWithFile:@"tut3.png"];
    tut3.anchorPoint = ccp(0,0);
    [tut3 setScaleY: 480/tut3.contentSize.height];
    [tut3 setScaleX: 320/tut3.contentSize.width];
    
    CCLabelTTF *tutlabel3 = [CCLabelTTF labelWithString:@"After picking your deck, you will see this gameboard.Click to toggle if selected.Again,click a card in map inventory to view full screen view, hold this full screen view for 1 sec to show it on table. Then ,try to drag it to a place on table. The card will be turned to grey." dimensions:screenSize hAlignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:15];
    tutlabel3.position = ccp(screenSize.width/2,-50);
    
    [page3 addChild:tut3];
    [page3 addChild:tutlabel3];
    
    
    CCLayer *page4 = [CCLayer node];
    CCSprite * tut4 =[CCSprite spriteWithFile:@"tut4.png"];
    tut4.anchorPoint = ccp(0,0);
    [tut4 setScaleY: 480/tut4.contentSize.height];
    [tut4 setScaleX: 320/tut4.contentSize.width];
    
    CCLabelTTF *tutlabel4 = [CCLabelTTF labelWithString:@"By this time, you can click on the grey card to confirm your placement, or click somewhere else to cancel placing. Also, you can pitch in and out and dragging to control the camera. This card turned red and disappears because it is not compatible on that tile " dimensions:screenSize hAlignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:15];
    tutlabel4.position = ccp(screenSize.width/2,-50);
    
    [page4 addChild:tut4];
    [page4 addChild:tutlabel4];
    
    CCLayer *page5 = [CCLayer node];
    CCSprite * tut5 =[CCSprite spriteWithFile:@"tut5.png"];
    tut5.anchorPoint = ccp(0,0);
    [tut5 setScaleY: 480/tut5.contentSize.height];
    [tut5 setScaleX: 320/tut5.contentSize.width];
    
    CCLabelTTF *tutlabel5 = [CCLabelTTF labelWithString:@"To make a card compatible, it must has at least one adjcant card has same terrain with this card, at least one adjacant card has same climate with this card, and it has at least one adjcant card provide proper food if the card is foodchain level 2 or 3 " dimensions:screenSize hAlignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:15];
    tutlabel5.position = ccp(screenSize.width/2,-50);
    
    [page5 addChild:tut5];
    [page5 addChild:tutlabel5];
    
    CCLayer *page6 = [CCLayer node];
    CCSprite * tut6 =[CCSprite spriteWithFile:@"tut6.png"];
    tut6.anchorPoint = ccp(0,0);
    [tut6 setScaleY: 480/tut6.contentSize.height];
    [tut6 setScaleX: 320/tut6.contentSize.width];
    
    CCLabelTTF *tutlabel6 = [CCLabelTTF labelWithString:@"This is a foodchain level 3 card, and its diet is carnivore. The color circle on right top coner indicates the diet, if it is green, it is herbivore, brown for omnivore. Yellow and black are producers that they can feed themselves by photosynthetic or molecular carbon" dimensions:screenSize hAlignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:15];
    tutlabel6.position = ccp(screenSize.width/2,160);
    
    [page6 addChild:tut6];
    [page6 addChild:tutlabel6];
    
    
    CCLayer *page7 = [CCLayer node];
    CCSprite * tut7 =[CCSprite spriteWithFile:@"tut7.png"];
    tut7.anchorPoint = ccp(0,0);
    [tut7 setScaleY: 480/tut7.contentSize.height];
    [tut7 setScaleX: 320/tut7.contentSize.width];
    
    CCLabelTTF *tutlabel7 = [CCLabelTTF labelWithString:@"A food chain level 3 carnivore can prey on any food chain level 2 card, or food chain level 3 card which has a smaller or equal scale, while omnivores of level 3 can feed on everything except for food chain level 3 cards that has a larger scale." dimensions:screenSize hAlignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:15];
    tutlabel7.position = ccp(screenSize.width/2,screenSize.height/2 - 15);
    CCLabelTTF *tutlabel10 = [CCLabelTTF labelWithString:@"A food chain level 2 card can feed on anything that is level 1, and level 1 card only needs climates and terrains. The game goal is to connect to the target card from home card, and make the target card also compatible. Here, the target card is connected, but not compatible, the game will continue." dimensions:screenSize hAlignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:15];
    tutlabel10.position = ccp(screenSize.width/2,-100);
    
    [page7 addChild:tut7];
    [page7 addChild:tutlabel7];
    [page7 addChild:tutlabel10];
    
    CCLayer *page8 = [CCLayer node];
    CCSprite * tut8 =[CCSprite spriteWithFile:@"tut8.png"];
    tut8.anchorPoint = ccp(0,0);
    [tut8 setScaleY: 480/tut8.contentSize.height];
    [tut8 setScaleX: 320/tut8.contentSize.width];
    
    CCLabelTTF *tutlabel8 = [CCLabelTTF labelWithString:@"Here just confirm this placement by clicking the grey card, you will win this game. But also remember, if you have reached the step limit(bottom left corner) or used up all the cards, you will be lose. Good news is , you can extend your inventory by playing GPS mode, it generates target cards depending on your current location, and after you win this game, you will get that target card adds into your inventory. Just click rellocate to see your position updated, and click battle!" dimensions:screenSize hAlignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:15];
    tutlabel8.position = ccp(screenSize.width/2,-50);
    
    [page8 addChild:tut8];
    [page8 addChild:tutlabel8];
    
    CCLayer *page9 = [CCLayer node];
    CCSprite * tut9 =[CCSprite spriteWithFile:@"tut9.png"];
    tut9.anchorPoint = ccp(0,0);
    [tut9 setScaleY: 480/tut9.contentSize.height];
    [tut9 setScaleX: 320/tut9.contentSize.width];
    
    CCLabelTTF *tutlabel9 = [CCLabelTTF labelWithString:@"" dimensions:screenSize hAlignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:15];
    tutlabel9.position = ccp(screenSize.width/2,160);
    
    [page9 addChild:tut9];
    [page9 addChild:tutlabel9];
    
	
	return [NSArray arrayWithObjects: page1,page2,page3,page4,page5,page6,page7,page8,page9,nil];
}

// Creates new Scroll Layer with pages returned from scrollLayerPages.
- (CCScrollLayer *) scrollLayer
{
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	
	// Create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages).
	CCScrollLayer *scroller = [CCScrollLayer nodeWithLayers: [self scrollLayerPages] widthOffset: 0];
	scroller.pagesIndicatorPosition = ccp(screenSize.width * 0.5f, screenSize.height - 30.0f);
    
    // New feature: margin offset - to slowdown scrollLayer when scrolling out of it contents.
    // Comment this line or change marginOffset to screenSize.width to disable this effect.
    scroller.marginOffset = 0.5f * screenSize.width;
	
	return scroller;
}

#pragma mark Callbacks

- (void) changeColorPressed: (CCNode *) sender
{
    CCScrollLayer *scroller = (CCScrollLayer *)[self getChildByTag:kScrollLayer];
    
    GLubyte opacity = arc4random() % 127 + 128;
    GLubyte red = arc4random() % 255;
    GLubyte green = arc4random() % 255;
    GLubyte blue = arc4random() % 255;
    
    GLubyte opacitySelected = arc4random() % 127 + 128;
    GLubyte redSelected = arc4random() % 255;
    GLubyte greenSelected = arc4random() % 255;
    GLubyte blueSelected = arc4random() % 255;
    
    scroller.pagesIndicatorNormalColor = ccc4(red, green, blue, opacity);
    scroller.pagesIndicatorSelectedColor = ccc4(redSelected, greenSelected, blueSelected, opacitySelected);
    
}

// "Add Page" Button Callback - adds new page & updates fast page change menu.
- (void) addPagePressed: (CCNode *) sender
{
	NSLog(@"CCScrollLayerTestLayer#addPagePressed: called!");
	
    
	
	CCScrollLayer *scroller = (CCScrollLayer *)[self getChildByTag:kScrollLayer];
	
	CCLayer *pageX = [CCLayer node];
	
	[scroller addPage: pageX];
	
	//Update fast page change menu.
	[self updateFastPageChangeMenu];
}

// "Remove page" menu callback - removes pages through running new action with delay.
- (void) removePagePressed: (CCNode *) sender
{
	// Run action with page removal on cocos2d thread.
	[self runAction:[CCSequence actions:
					 [CCDelayTime actionWithDuration:0.2f],
					 [CCCallFunc actionWithTarget:self selector:@selector(removePage)],
					 nil]
	 ];
}

- (void) removePage
{
	// Actually remove page.
	CCScrollLayer *scroller = (CCScrollLayer *)[self getChildByTag:kScrollLayer];
	[scroller removePageWithNumber: [scroller.pages count] - 1];
	
	// Update fast page change menu.
	[self updateFastPageChangeMenu];
}

// "0 1 2" menu callback - used for fast page change.
- (void) fastMenuItemPressed: (CCNode *) sender
{
	CCScrollLayer *scroller = (CCScrollLayer *)[self getChildByTag:kScrollLayer];
	
	[scroller moveToPage: sender.tag];
}

#pragma mark Scroll Layer Callbacks

- (void) scrollLayerScrollingStarted:(CCScrollLayer *) sender
{
	NSLog(@"CCScrollLayerTestLayer#scrollLayerScrollingStarted: %@", sender);
}

- (void) scrollLayer: (CCScrollLayer *) sender scrolledToPageNumber: (int) page
{
	NSLog(@"CCScrollLayerTestLayer#scrollLayer:scrolledToPageNumber: %@ %d", sender, page);
}

@end
