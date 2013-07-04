//
//  GPSMenuLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-30.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GPSMenuLayer.h"
#import "MainMenuScene.h"
#import "GoogleMapUIViewController.h"
#import "Player.h"


@implementation GPSMenuLayer

- (id)init{
    if( (self=[super init]) ) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
    
        // Create menu items
        [CCMenuItemFont setFontSize:28];
        CCMenuItem *item = [CCMenuItemFont itemWithString:@"Hunt for a card!" block:^(id sender) {
            // add event after click here
            
            [self removeMap];
            [self showConfirmationLayer];
            
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
		[menu setPosition:ccp( size.width/2, size.height * 0.2)];
        [self addChild: menu];
    }
    return self;
}

-(void) removeMap{
    for(UIView *subview in [[[CCDirector sharedDirector] view] subviews]) {
        [subview removeFromSuperview];
    }
}

-(void) showConfirmationLayer{
    
}


@end
