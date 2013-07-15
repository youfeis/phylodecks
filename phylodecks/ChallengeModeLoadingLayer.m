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
        
		// create and initialize a Label
        // todo: change text labels to images
        // todo: add a background layer for the mainmenuscene/setting scene
		CCSprite *label = [CCSprite spriteWithFile:@"title.png"];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        [label setScale:0.5f];
		// position the label on the center top of the screen
		label.position =  ccp( size.width /2 , 4*size.height/5 );
		
		// add the label as a child to this Layer
		[self addChild: label z:0];
        
        CCLabelTTF *loading = [CCLabelTTF labelWithString:@"Now Loading..." fontName:@"Marker Felt" fontSize:64];
        
        loading.position =  ccp( size.width /2 , 2*size.height/5 );
        
        [self addChild: loading];
    }
    return self;
}

@end
