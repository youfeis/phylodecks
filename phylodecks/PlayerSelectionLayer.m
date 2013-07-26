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
		
		// Show current player status and delete/new button 
        
        
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
    id name = [[[[[sender children] objectAtIndex:0] children] objectAtIndex:0] string];
    NSLog(@"%@",name);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Switch User" message:[NSString stringWithFormat:@"Switching to user %@?",name] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Not now", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [[Player currentPlayer] saveData];
    [alert show];
}

@end
