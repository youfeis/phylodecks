//
//  MainMenuLayer.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-01.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "MainMenuLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - MainMenuLayer

// MainMenuLayer implementation
@implementation MainMenuLayer

// Helper class method that creates a Scene with the MainMenuLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"PHYLODECKS" fontName:@"Marker Felt" fontSize:64];

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center top of the screen
		label.position =  ccp( size.width /2 , 4*size.height/5 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		
		
		//
		// MenuItems
		//
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
		
		// Achievement Menu Item using blocks
		CCMenuItem *itemTutorial = [CCMenuItemFont itemWithString:@"Tutorial" block:^(id sender) {
			
			
			NSLog(@"itemTutorialClicked");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TutorialLayer scene] withColor:ccWHITE]];
            
		}
									   ];
	
		// Leaderboard Menu Item using blocks
		CCMenuItem *itemSinglePlayer = [CCMenuItemFont itemWithString:@"Single Player" block:^(id sender) {
			
			
			NSLog(@"itemSinglePlayerClicked");
		}
									   ];
        
        CCMenuItem *itemSetting = [CCMenuItemFont itemWithString:@"Setting " block:^(id sender) {
			
			
			NSLog(@"itemSettingClicked");
		}
                                    ];
        
		// Leaderboard Menu Item using blocks
		CCMenuItem *itemExit = [CCMenuItemFont itemWithString:@"     Exit    " block:^(id sender) {
			
			
			NSLog(@"itemExitClicked");
            exit(0);
		}
                                        ];
        
        
		
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

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
