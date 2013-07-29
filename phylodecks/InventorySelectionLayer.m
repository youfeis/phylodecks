//
//  InventorySelectionLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "InventorySelectionLayer.h"
#import "MainMenuLayer.h"


@implementation InventorySelectionLayer

@synthesize cardSprites;

enum nodeTags2
{
	kScrollLayer = 256,
	kAdviceLabel = 257,
	kFastPageChangeMenu = 258,
    mapInventoryCounterTag,
};

// on "init" you need to initialize your instance
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
        
        [[Map currentMap] setMapInventory:[[NSMutableArray alloc] init]];
        
        cardSprites = [[NSMutableArray alloc] init];
        [self loadCardDatabase];
        [self inventoryInit];
		[self homeAndTargetInit];
		// Add fast page change menu.
		[self updateFastPageChangeMenu];
        
        
		
		// Do initial positioning & create scrollLayer.
		[self updateForScreenReshape];
        [self placeInventoryCards];
        [self changeColorPressed:self];
        
        
        
        CCMenu *playMenu = [CCMenu menuWithItems: nil];
        
        
          
        CCLabelTTF *labelWithNumber = [CCLabelTTF labelWithString:@"go>>" fontName:@"Marker Felt" fontSize:22];
        CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:labelWithNumber block:^(id sender){
            if([[[Map currentMap] mapInventory] count] <= [[Map currentMap] maxInventory]){
                [self transitToChallengeModeScene];
            }
        }];
            [playMenu addChild: item z: 0];
        
        [self addChild: playMenu z: 0];
    
        playMenu.position = ccp( 0.9f * screenSize.width, 15.0f);
        
        NSString *countString = [NSString stringWithFormat:@"%1i/%2i",[[[Map currentMap] mapInventory] count],[[Map currentMap] maxInventory]];
        CCLabelTTF *inventoryCount = [CCLabelTTF labelWithString:countString fontName:@"Marker Felt" fontSize:22];
        inventoryCount.position = ccp( 0.1f * screenSize.width, 15.0f);
        [self addChild:inventoryCount z:0 tag:mapInventoryCounterTag];
        
	}
	return self;
}

// Removes old "0 1 2" menu and creates new for actual pages count.
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
	
    // PAGE 2 - Custom Font Menu in the center.
	CCLayer *pageOne = [CCLayer node];
    /*
	CCLabelTTF *labelTwo = [CCLabelTTF labelWithString:@"Add Page!" fontName:@"Marker Felt" fontSize:44];
	CCMenuItemLabel *titem = [CCMenuItemLabel itemWithLabel:labelTwo target:self selector:@selector(addPagePressed:)];
	CCLabelTTF *labelTwo2 = [CCLabelTTF labelWithString:@"Remove Page!" fontName:@"Marker Felt" fontSize:44];
	CCMenuItemLabel *titem2 = [CCMenuItemLabel itemWithLabel:labelTwo2 target:self selector:@selector(removePagePressed:)];
    CCLabelTTF *labelTwo3 = [CCLabelTTF labelWithString:@"Change dots color!" fontName:@"Marker Felt" fontSize:40];
	CCMenuItemLabel *titem3 = [CCMenuItemLabel itemWithLabel:labelTwo3 target:self selector:@selector(changeColorPressed:)];
	CCMenu *menu = [CCMenu menuWithItems: titem, titem2, titem3, nil];
	[menu alignItemsVertically];
	menu.position = ccp(screenSize.width/2, screenSize.height/2);
	[pageOne addChild:menu]; */
	
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

-(void)loadCardDatabase{
 	NSLog(@">>>>>>>>>>>>>>>>> openDatabase");
    //	BOOL success;
    //	NSFileManager *fileManager = [NSFileManager defaultManager];
    //	NSError *error;
    //	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE);
    //	NSString *documentsDirectory = [paths objectAtIndex:0];
    //	NSString *writableDBPath = [[NSBundle mainBundle] pathForResource:@"db" ofType:@"sqlite3"];
	NSString *defaultDBPath = [[NSBundle mainBundle] pathForResource:@"db" ofType:@"sqlite3"];
    //[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"db.sqlite3"];
	
    //	BOOL forceRefresh = FALSE; // Just for testing
	
    //	success = [fileManager fileExistsAtPath:writableDBPath];
    //	if (!success || forceRefresh) {
    //		success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    //		NSLog(@"initial creation of writable database (%@) from resources database (%@)", writableDBPath, defaultDBPath);
    //	}
	
	db = [[FMDatabase databaseWithPath:defaultDBPath] retain];
	
	if ([db open]) {
		NSLog(@"database opened: %@", defaultDBPath);
		
		[db setTraceExecution: FALSE];
		[db setLogsErrors: TRUE];
		
		databaseOpened = TRUE;
		
		[db setShouldCacheStatements:FALSE];
		
	} else {
        NSLog(@"could not open database: %@", defaultDBPath);
        databaseOpened = FALSE;
    }
}

-(void)inventoryInit{
    FMResultSet * rs;
    for(id obj in [[Player currentPlayer] playerInventory]){
        rs = [db executeQuery:@"SELECT * FROM card WHERE cardID = ?",obj];
        [rs next];
        Card *aCard = [[Card spriteWithFile:[rs stringForColumn:@"image"]]  initWithData:rs card:[obj intValue]];
        [cardSprites addObject:aCard];

    }
    
    
}
- (void) placeInventoryCards{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CCMenuAdvanced* menu = [CCMenuAdvanced menuWithItems: nil];
    int i = 1;
    int j = 1;
    int k = 0;
    
    for(id obj in cardSprites){
        CCMenuItem *item = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:[obj imageName]] selectedSprite:nil block:^(id sender){
            
            
            // implement card click event here
            
            
            if([[[Map currentMap] mapInventory] containsObject:obj]){
                [(CCSprite *)sender setColor:ccWHITE];
                [[[Map currentMap] mapInventory] removeObject:obj];
            }else{
            
                [[[Map currentMap] mapInventory] addObject:obj];
                [(CCSprite *)sender setColor:ccGRAY];
            }
           
            FullScreenCardViewLayer * viewer = [[FullScreenCardViewLayer alloc] initWithCard:obj];
            [[self parent]addChild:viewer];
            [self setPosition:CGPointMake(-1000, -1000)];
            
            NSString *countString = [NSString stringWithFormat:@"%1i/%2i",[[[Map currentMap] mapInventory] count],[[Map currentMap] maxInventory]];
            CCLabelTTF *inventoryCount = [CCLabelTTF labelWithString:countString fontName:@"Marker Felt" fontSize:22];
            inventoryCount.position = ccp( 0.1f * screenSize.width, 15.0f);
            if([[[Map currentMap] mapInventory] count] > [[Map currentMap] maxInventory]){
                [inventoryCount setColor:ccRED];
            }
            [self removeChildByTag:mapInventoryCounterTag cleanup:YES];
            [self addChild:inventoryCount z:0 tag:mapInventoryCounterTag];
            
        }];
        if(i>5){
            i=1;
            j++;
            if(j>5){
                j=1;
                 [[[[self getChildByTag:256]children] objectAtIndex:k] addChild:menu];
                menu = [CCMenuAdvanced menuWithItems: nil];
                k++;
                [self addPagePressed:self];
            }
        }
        [item setScaleY: 72/item.contentSize.height];
        [item setScaleX: 52/item.contentSize.width];
        [item setPosition:ccp(i * screenSize.width/6, (6-j)*screenSize.height/6)];
        [menu addChild:item];

        i++;
    }
    [[[[self getChildByTag:256]children] objectAtIndex:k] addChild:menu];
}

-(void)transitToChallengeModeScene{
       [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[ChallengeModeScene alloc] init] withColor:ccWHITE]];
}


-(void)homeAndTargetInit{
    FMResultSet * rs;
    rs = [db executeQuery:@"SELECT * FROM card WHERE cardID = 1"];
	[rs next];
    Card *home = [[Card spriteWithFile:[rs stringForColumn:@"image"]]  initWithData:rs card:1];
    [[Map currentMap] setHome:home];
    rs = [db executeQuery:@"SELECT * FROM card WHERE type = \"SPECIES\" ORDER BY RANDOM() LIMIT 1" ];
    [rs next];
    NSMutableArray * targetRandomSet = [[NSMutableArray alloc]init];
    if ([[Map currentMap] gameMode] == 0){
        Card *target = [[Card spriteWithFile:[rs stringForColumn:@"image"]]  initWithData:rs card:[rs intForColumn:@"cardID"]];
        [[Map currentMap] setTarget:target];
    }else{
        for(NSString * terrain in [[Map currentMap] terrainSet]){
            NSString * query = [NSString stringWithFormat:@"SELECT * FROM card WHERE type = \"SPECIES\" AND terrains LIKE \"%%%@%%\" ORDER BY RANDOM() LIMIT 1",terrain];
            rs = [db executeQuery:query];
            [rs next];
            Card *target = [[Card spriteWithFile:[rs stringForColumn:@"image"]]  initWithData:rs card:[rs intForColumn:@"cardID"]];
            [targetRandomSet addObject:target];
        }
        [[Player currentPlayer] setGPSBattleLeft:[[Player currentPlayer] GPSBattleLeft]-1];
        int randomIndex = arc4random() % [targetRandomSet count];
        [[Map currentMap] setTarget:[targetRandomSet objectAtIndex:randomIndex]];
        
    }
    
}

@end

