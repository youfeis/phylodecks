//
//  GameOverScene.m
//  phylodecks
//
//  Created by Youfei Sun on 7/28/13.
//
//  When game ending condition meets, this scene will be actived and load layers depending on user
// wining or losing the game

#import "GameOverScene.h"

@implementation GameOverScene

-(id)init{
    [super init];
    if (self != nil){
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.anchorPoint = ccp(0,0);
        [background setScaleY: 480/background.contentSize.height];
        [background setScaleX: 320/background.contentSize.width];
        [self addChild:background z:-2];
        if(mode == 0){ //lose
            CCLayer * gameover = [[GameOverLayer alloc]init];
            [self addChild:gameover];
        }else{  //win
            CCLayer * gamewin = [[GameWinLayer alloc]init];
            [self addChild:gamewin];
        }
        

    }
    return self;
}

-(id)initWithMode:(int)modeCode{
    mode = modeCode;// mode 1 -> win mode 0-> lose
    [self init];
    return self;
}

@end
