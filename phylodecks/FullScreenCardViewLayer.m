//
//  FullScreenCardViewLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-06.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//
//  This class also uses ccpanzoomlayer, to view the card full screen , and provides camera control
//

#import "FullScreenCardViewLayer.h"
#import "nodeTags.h"

enum nodeTags2
{
    fullSizeCardTag
};


@implementation FullScreenCardViewLayer

-(id)initWithCard:(Card*)card{
    // always call super init
    self = [self init];
    if (self != nil) {
        // set the card as a background full screen
        //recognize a holding 
        _card = card;
        UILongPressGestureRecognizer* recognizer =
        [[UILongPressGestureRecognizer alloc]
         initWithTarget:self
         action:@selector(handleLongPressFrom:)];
        recognizer.minimumPressDuration = 0.5; // seconds
        [[[CCDirector sharedDirector] view]
         addGestureRecognizer:recognizer];
        
        _panZoomer = [[CCLayerPanZoom alloc] init];
        [self addChild:_panZoomer];
        _panZoomer.delegate = self;
        
        CCSprite *background = [CCSprite spriteWithTexture:[card texture]];
        background.anchorPoint = ccp(0,0);
        [background setScaleY: 480/background.contentSize.height];
        [background setScaleX: 320/background.contentSize.width];
        [_panZoomer addChild: background
                          z :-1
                         tag: fullSizeCardTag];
        
        _panZoomer.mode = kCCLayerPanZoomModeSheet;
        _panZoomer.rubberEffectRatio = 0.2f;
        
        
        [self updateForScreenReshape];
        
    }
    return self;
}

- (void) dealloc
{
    _panZoomer.delegate = nil;
    [_panZoomer release];
	[super dealloc];
}

//camera control funcition
- (void) updateForScreenReshape
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
	CCNode *background = [_panZoomer getChildByTag: fullSizeCardTag];
	// our bounding rect
	CGRect boundingRect = CGRectMake(0, 0, 0, 0);
	boundingRect.size = [background boundingBox].size;
	[_panZoomer setContentSize: boundingRect.size];
    
	_panZoomer.anchorPoint = ccp(0.5f, 0.5f);
	_panZoomer.position = ccp(0.5f * winSize.width, 0.5f * winSize.height);
	
    _panZoomer.panBoundsRect = CGRectMake(0, 0, winSize.width, winSize.height);
    
    
    // Stay in screen bounds (1 screen = minScale), allow to zoom 2x.
    _panZoomer.minScale =  1.0f *  winSize.width / [background boundingBox].size.width;
    _panZoomer.maxScale =  2.0f *  winSize.width / [background boundingBox].size.width;
}

// this function moves back hud and inventory, also adds back the shown card to the inventory
- (void) layerPanZoom: (CCLayerPanZoom *) sender
	   clickedAtPoint: (CGPoint) point
             tapCount: (NSUInteger) tapCount
{
	NSLog(@"CCLayerPanZoomTestLayer#layerPanZoom: %@ clickedAtPoint: { %f, %f }", sender, point.x, point.y);
    if( [[self parent] isKindOfClass:[ChallengeModeScene class]] ) {
        [[[Map currentMap] mapInventory] addObject: [[Map currentMap] selected]];
        [(MapInventoryLayer *)[[self parent] getChildByTag:mapInventoryLayerTag] reformatMenu];
    }
    for(id obj in [[self parent] children]){
        [obj setPosition:CGPointZero];
    }
    [self removeFromParentAndCleanup:YES];
    

}

- (void) layerPanZoom: (CCLayerPanZoom *) sender
 touchPositionUpdated: (CGPoint) newPos
{
    NSLog(@"CCLayerPanZoomTestLayer#layerPanZoom: %@ touchPositionUpdated: { %f, %f }", sender, newPos.x, newPos.y);
    

}

- (void) layerPanZoom: (CCLayerPanZoom *) sender touchMoveBeganAtPosition: (CGPoint) aPoint
{
    NSLog(@"CCLayerPanZoomTestLayer#layerPanZoom: %@ touchMoveBeganAtPosition: { %f, %f }", sender, aPoint.x, aPoint.y);

}

-(void) layerPanZoom: (CCLayerPanZoom *) sender touchMoveEndAtPosition:(CGPoint) endPos
{
    NSLog(@"released finger at position %@  {%f,%f}",sender,endPos.x,endPos.y);

}

// if it holds more than 0.5 seconds on challenge mode, this function shows the card to the gameboard and removes hud and inventory.
-(void) handleLongPressFrom:(UILongPressGestureRecognizer*)recognizer{
    if ( recognizer.state != UIGestureRecognizerStateBegan ){
        return;
    }
    for(id obj in [[self parent] children]){
        [obj setPosition:CGPointZero];
    }
    
    if( [[self parent] isKindOfClass:[ChallengeModeScene class]] ) {
        [(GameBoardLayer *)[[self parent] getChildByTag:gameBoardLayerTag ]showSelected: _card atPos:[recognizer locationInView:[UIApplication sharedApplication].keyWindow]];
        [[[Map currentMap] mapInventory] removeObject:_card];
        [(MapInventoryLayer *)[[self parent] getChildByTag:mapInventoryLayerTag] reformatMenu];
        
        [[[self parent] getChildByTag:mapInventoryLayerTag] setPosition:ccp(-1000,-1000)];
        [[[self parent] getChildByTag:HUDLayerTag] setPosition:ccp(-1000,-1000)];
        
        [self removeFromParentAndCleanup:YES];
        
    }
   
}

-(void) onExit{
    [super onExit];
    NSArray *grs = [[[CCDirector sharedDirector] view] gestureRecognizers];
    
    for (UIGestureRecognizer *gesture in grs){
        if([gesture isKindOfClass:[UILongPressGestureRecognizer class]]){
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:gesture];
        }
    }
}



@end
