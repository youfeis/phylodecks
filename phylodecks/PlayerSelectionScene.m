//
//  PlayerSelectionScene.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-25.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PlayerSelectionScene.h"


@implementation PlayerSelectionScene

-(id)init{
    self = [super init];
    if(self != nil){
        
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.anchorPoint = ccp(0,0);
        [background setScaleY: 480/background.contentSize.height];
        [background setScaleX: 320/background.contentSize.width];
        [self addChild:background z:-2];
        
        [self addChild:[PlayerSelectionLayer node]];
    }
    return self;
}

@end
