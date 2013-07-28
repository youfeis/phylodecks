//
//  PlayerSelectionLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-25.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PlayerSelectionLayer.h"
#import "GDataXMLNode.h"


enum nodeTags
{
	playerListTag,
    kWidget
};

@implementation PlayerSelectionLayer


- (id) init
{
	if ( (self = [super init]) )
	{
		
		// Create vertical scroll widget.
		CCNode *widget = [self widget];
		[self addChild: widget z: 0 tag: kWidget];
        
        NSString *level = [NSString stringWithFormat:@"level: %i",[[Player currentPlayer] playerLevel]];
        NSString *exp = [NSString stringWithFormat:@"exp: %i",[[Player currentPlayer] playerExp]];
        NSString *cardCount = [NSString stringWithFormat:@"card total: %i",[[[Player currentPlayer] playerInventory] count]];
        
        CCLabelTTF *line1 = [CCLabelTTF labelWithString:level fontName:@"Marker Felt" fontSize:24];
        CCLabelTTF *line2 = [CCLabelTTF labelWithString:exp fontName:@"Marker Felt" fontSize:24];
        CCLabelTTF *line3 = [CCLabelTTF labelWithString:cardCount fontName:@"Marker Felt" fontSize:24];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        line1.position = ccp(size.width*0.75,size.height*0.7);
        line2.position = ccp(size.width*0.75,size.height*0.6);
        line3.position = ccp(size.width*0.75,size.height*0.5);
        [self addChild:line1];
        [self addChild:line2];
        [self addChild:line3];
        
        
        CCLabelTTF *resetLabel = [CCLabelTTF labelWithString:@"Reset" fontName:@"Marker Felt" fontSize:24];
        
        CCMenuItemLabel *reset = [CCMenuItemLabel itemWithLabel: resetLabel target: self selector: @selector(resetPlayer:)];
        
        
		CCLabelTTF *backLabel = [CCLabelTTF labelWithString:@"Back" fontName:@"Marker Felt" fontSize:24];
        
        CCMenuItemLabel *back = [CCMenuItemLabel itemWithLabel: backLabel target: self selector: @selector(backToMainMenu:)];
        
        CCMenu* menuReset = [CCMenu menuWithItems:reset, nil];
        menuReset.position = ccp(size.width*0.75,size.height*0.3);
        CCMenu* menuBack = [CCMenu menuWithItems:back, nil];
        menuBack.position = ccp(size.width*0.75,size.height*0.1);
        [self addChild:menuReset];
        [self addChild:menuBack];
        
        
		// Do initial layout.
		[self updateForScreenReshape];
	}
	
	return self;
}


- (void) updateForScreenReshape
{
	[self updateWidget];
}


#pragma mark Vertical Scroll Widget



- (CCNode *) widget
{
    NSArray* playerList = [[Player currentPlayer] loadAllPlayerName];
    NSLog(@"%@",playerList);
    CCMenuAdvanced *menu = [CCMenuAdvanced menuWithItems:nil];
    for (NSString *playerName in playerList){
        [menu addChild:[CCMenuItemLabel itemWithLabel:[CCMenuItemFont itemWithString: playerName]
                                               target: self
                                             selector: @selector(itemPressed:)]];
    }
	
	// Setup Menu Alignment
	[menu alignItemsVerticallyWithPadding: 5 bottomToTop: NO]; //< also sets contentSize and keyBindings on Mac
#if COCOS2D_VERSION >= 0x00020000
    menu.ignoreAnchorPointForPosition = NO;
#else
    menu.isRelativeAnchorPoint = YES;
#endif
	
	return menu;
}


- (void) updateWidget
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
    // Menu at the Left.
    {
        CCMenuAdvanced *menu = (CCMenuAdvanced *) [self getChildByTag:kWidget];
        
        //widget
        menu.anchorPoint = ccp(0.5f, 1);
        menu.position = ccp(winSize.width / 4, winSize.height);
        
        menu.scale = MIN ((winSize.width / 2.0f) / menu.contentSize.width, 0.75f );
        
        menu.boundaryRect = CGRectMake(MAX(0, winSize.width / 4.0f - [menu boundingBox].size.width / 2.0f),
                                       25.0f,
                                       [menu boundingBox].size.width,
                                       winSize.height - 50.0f );
        
        [menu fixPosition];
    }
    
    }

- (void) itemPressed: (CCNode *) sender
{
/*    id name = [[[[[sender children] objectAtIndex:0] children] objectAtIndex:0] string];
    NSLog(@"%@",name);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Switch User" message:[NSString stringWithFormat:@"Switching to user %@?",name] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Not now", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [[Player currentPlayer] saveData];
    [alert show];*/
}

- (void)backToMainMenu: (id)sender{
    [[self parent] removeAllChildrenWithCleanup:YES];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init] withColor:ccWHITE]];
}

- (void) resetPlayer: (id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"All game progress will be cleared! And game will resatrt!" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    
    [alert show];
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1) {
        [[Player currentPlayer] resetPlayer];
        [[Player currentPlayer] saveData];
        exit(0);
    }
}


@end
