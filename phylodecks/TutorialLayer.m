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
@end
