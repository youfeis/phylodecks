//
//  ChallengeModeScene.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ChallengeModeScene.h"


@implementation ChallengeModeScene

-(id)init {
    // always call super init
    self = [super init];
    if (self != nil) {
        // add gameboardLayer
        GameBoardLayer *gameBoardLayer = [GameBoardLayer node];
        [self addChild:gameBoardLayer z: -1];
    }
    return self;
}

@end
