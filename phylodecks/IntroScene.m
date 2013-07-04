//
//  IntroScene.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-29.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "IntroScene.h"
#import "IntroLayer.h"
#import "MainMenuScene.h"


@implementation IntroScene

-(id)init {
    // always call super init
    self = [super init];
    if (self != nil) {
        // add the introlayer into introscene
        IntroLayer *introLayer = [IntroLayer node];
        [self addChild: introLayer z:0];
    }
    return self;
}

@end
