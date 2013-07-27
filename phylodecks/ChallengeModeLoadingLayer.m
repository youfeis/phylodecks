//
//  ChallengeModeLoadingLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-14.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//



// This layer is currently not in use


#import "ChallengeModeLoadingLayer.h"


@implementation ChallengeModeLoadingLayer

-(id) init {
    if( (self=[super init]) ) {
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.anchorPoint = ccp(0,0);
        [background setScaleY: 480/background.contentSize.height];
        [background setScaleX: 320/background.contentSize.width];
        [self addChild:background z:-2];
		
    }
    return self;
}

@end
