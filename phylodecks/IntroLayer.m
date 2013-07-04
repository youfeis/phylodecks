//
//  IntroLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-29.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "IntroLayer.h"
#import "MainMenuScene.h"


@implementation IntroLayer
-(void) onEnter
{
	[super onEnter];
    
	// ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
    
	CCSprite *background;
	
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
		background = [CCSprite spriteWithFile:@"Default.png"];
	} else {
		background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
	}
	background.position = ccp(size.width/2, size.height/2);
    
	// add the label as a child to this Layer
	[self addChild: background];
			
	// In one second transition to the new scene
    // todo: load user profile
	[self scheduleOnce:@selector(makeTransition:) delay:1];
}

-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init] withColor:ccWHITE]];
}

@end

