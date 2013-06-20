//
//  TutorialLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-19.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TutorialLayer.h"


@implementation TutorialLayer

+(CCScene *) scene{
    
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TutorialLayer *layer = [TutorialLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
    
}

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
    }
    return self;
}


@end
