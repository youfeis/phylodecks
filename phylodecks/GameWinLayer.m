//
//  GameWinLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-28.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameWinLayer.h"
#import "MainMenuScene.h"


@implementation GameWinLayer

-(id)init{
    [super init];
    if (self != nil){
        
        
    }
    return self;
}

-(void)onEnter{
    [super onEnter];
    CGSize s = [[CCDirector sharedDirector] winSize];
    CCSprite *win = [CCSprite spriteWithFile:@"YouWin.png"];
    [win setScale:0.5f];
    win.position = ccp(s.width/2,s.height*0.8);
    win.opacity = 0;
    [self addChild:win];
    
    
    id delay = [CCDelayTime actionWithDuration:1.0f];
    id fadein  = [CCFadeIn actionWithDuration:2.0f ];
    id fadeInDone = [CCCallFuncN actionWithTarget:self selector:@selector(fadeInDoneSelector)];
    id sequence = [CCSequence actions:delay,fadein,fadeInDone, nil];
    [win runAction:sequence];
    
}

-(void)fadeInDoneSelector{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *back1 = [CCSprite spriteWithFile:@"Back.png"];
    CCSprite *back2 = [CCSprite spriteWithFile:@"Back.png"];
    back2.color = ccGRAY;
    CCMenuItemSprite * itemBack = [CCMenuItemSprite itemWithNormalSprite:back1 selectedSprite:back2 block:^(id sender){
        [[self parent] removeAllChildrenWithCleanup:YES];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init] withColor:ccWHITE]];
        
    }];
    [itemBack setScale:0.5f];
    CCMenu *backMenu = [CCMenu menuWithItems:itemBack, nil];
    backMenu.position = ccp(40.0f,size.height - 20.0f);
    [self addChild:backMenu];
    
    int expGet=0;
    for(Tile* tile in [[Map currentMap] tiles]){
        if([[[tile card] type] isEqualToString:@"SPECIES"]){
            expGet = expGet + [[tile card] point];
        }
    }
    
    NSString *level;
    if ([Player currentPlayer].playerExp + expGet >= [[Player currentPlayer]levelUP]){
        level = [NSString stringWithFormat:@"level: %i + 1",[[Player currentPlayer] playerLevel]];
        [Player currentPlayer].playerLevel = [Player currentPlayer].playerLevel + 1;
    }else{
        level = [NSString stringWithFormat:@"level: %i",[[Player currentPlayer] playerLevel]];
    }
    
    NSString *exp = [NSString stringWithFormat:@"exp: %1i+%2i/%3i",[[Player currentPlayer] playerExp],expGet,[[Player currentPlayer]levelUP]];
    [Player currentPlayer].playerExp = [Player currentPlayer].playerExp + expGet;
    NSString *cardCount;
    
    if([[Map currentMap]gameMode] == 1){
        cardCount = [NSString stringWithFormat:@"card total: %i + 1",[[[Player currentPlayer] playerInventory] count]];
        [[Player currentPlayer] addTargetToInventory];
    }else{
        
        cardCount = [NSString stringWithFormat:@"card total: %i",[[[Player currentPlayer] playerInventory] count]];
    }
    CCLabelTTF *line1 = [CCLabelTTF labelWithString:level fontName:@"Marker Felt" fontSize:24];
    CCLabelTTF *line2 = [CCLabelTTF labelWithString:exp fontName:@"Marker Felt" fontSize:24];
    CCLabelTTF *line3 = [CCLabelTTF labelWithString:cardCount fontName:@"Marker Felt" fontSize:24];
    
    
    line1.position = ccp(size.width*0.5,size.height*0.6);
    line2.position = ccp(size.width*0.5,size.height*0.5);
    line3.position = ccp(size.width*0.5,size.height*0.4);
    [self addChild:line1];
    [self addChild:line2];
    [self addChild:line3];
   
    
    [[Player currentPlayer] saveData];
}

@end
