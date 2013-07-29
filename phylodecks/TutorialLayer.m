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
	CCLayer *pageOne = [CCLayer node];
    CCSprite * tut1 =[CCSprite spriteWithFile:@"tut1.png"];
    tut1.anchorPoint = ccp(0,0);
    [tut1 setScaleY: 480/tut1.contentSize.height];
    [tut1 setScaleX: 320/tut1.contentSize.width];
    [pageOne addChild:tut1];
    
	
	return [NSArray arrayWithObjects: pageOne,nil];
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
