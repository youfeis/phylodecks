//
//  GameBoardLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameBoardLayer.h"
#import "nodeTags.h"
#import "Map.h"
#import "Card.h"
#import "Tile.h"

@implementation GameBoardLayer
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        _tutorialGameboard = [[CCLayerPanZoom node] retain];
        [self addChild: _tutorialGameboard];
		_tutorialGameboard.delegate = self;
        // background
        CCSprite *background = [CCSprite spriteWithFile: @"gameboard.png"];
        background.anchorPoint = ccp(0,0);
		background.scale = CC_CONTENT_SCALE_FACTOR();
        [_tutorialGameboard addChild: background
                                  z :-1
                                 tag: gameBoardBackgroundTag];
        
        
        _tutorialGameboard.mode = kCCLayerPanZoomModeSheet;
        
        _tutorialGameboard.rubberEffectRatio = 0.1f;
        
        _tutorialGameboard.bottomFrameMargin = 180.0f;
        
        _tilesArray = [[NSMutableArray alloc] init];
        
        [[Map currentMap]generateNewMap:[[Player currentPlayer] playerLevel]];
        [self locateHomeAndTarget];
        [self drawTiles];
        
        
		[self updateForScreenReshape];

    }
    return self;
}


- (void) dealloc
{
    _tutorialGameboard.delegate = nil;
    [_tutorialGameboard release];
    [_tilesArray release];
	[super dealloc];
}

- (void) updateForScreenReshape
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
	CCNode *background = [_tutorialGameboard getChildByTag: gameBoardBackgroundTag];
	// our bounding rect
	CGRect boundingRect = CGRectMake(0, 0, 0, 0);
	boundingRect.size = [background boundingBox].size;
	[_tutorialGameboard setContentSize: boundingRect.size];
    
	_tutorialGameboard.anchorPoint = ccp(0.5f, 0.5f);
	_tutorialGameboard.position = ccp(0.5f * winSize.width, 0.5f * winSize.height);
	
    _tutorialGameboard.panBoundsRect = CGRectMake(0, 0, winSize.width, winSize.height);
    
    
    // Stay in screen bounds (1 screen = minScale), allow to zoom 2x.
    _tutorialGameboard.minScale =  1.0f *  winSize.width / [background boundingBox].size.width;
    _tutorialGameboard.maxScale =  25.0f *  winSize.width / [background boundingBox].size.width;
}

- (void) dragSelectedCard: (CGPoint) point
{
    CCSprite *dragable = (CCSprite *)[_tutorialGameboard getChildByTag: dragableTag];
    if ( CGRectContainsPoint( [dragable boundingBox], point))
    {
        _selectedCard = dragable;
        [self setToFrameMode];
    }else{
        _selectedCard = 0;
        [_tutorialGameboard removeChildByTag:dragableTag cleanup:YES];
        [self setToSheetMode];
        
    }
    
    
}

- (void) layerPanZoom: (CCLayerPanZoom *) sender
	   clickedAtPoint: (CGPoint) point
             tapCount: (NSUInteger) tapCount
{
	NSLog(@"CCLayerPanZoomTestLayer#layerPanZoom: %@ clickedAtPoint: { %f, %f } tap count %i", sender, point.x, point.y,tapCount);
    if(CGRectContainsPoint([_toConfirm boundingBox], point)){
        [_toConfirm setColor:ccWHITE];
        int dragIndex = [_tilesArray indexOfObject:_toConfirm];
        
        // check if the card is compatitable at that tile
        BOOL isCompatible = [[[[Map currentMap] tiles] objectAtIndex:dragIndex] isCompatible:[[Map currentMap] selected]];
        if(isCompatible){
            [[[[Map currentMap] tiles] objectAtIndex:dragIndex] setCard:[[Map currentMap] selected]];
            _toConfirm = 0;
        }else{
            CCSprite *emptyCard = [CCSprite spriteWithFile:@"emptyTile.png"];
            [emptyCard setScaleY: 72/emptyCard.contentSize.height];
            [emptyCard setScaleX: 52/emptyCard.contentSize.width];
            [_toConfirm setTexture:[emptyCard texture]];
            [_toConfirm setVisible:NO];
            _toConfirm = 0;
        }
        
        [Map currentMap].stepCounter--;
        [(HUDLayer*)[[self parent] getChildByTag:HUDLayerTag] updateHUD];
  
        if([Map currentMap].stepCounter == 0){
            //game end
        }
        
    }
    else if(_toConfirm != 0){
        //add card back to inventory
        [[[Map currentMap] mapInventory] addObject: [[Map currentMap] selected]];
        [(MapInventoryLayer *)[[self parent] getChildByTag:mapInventoryLayerTag] reformatMenu];
        //todo: cant reformat here, will look into it later
        CCSprite *emptyCard = [CCSprite spriteWithFile:@"emptyTile.png"];
        [emptyCard setScaleY: 72/emptyCard.contentSize.height];
        [emptyCard setScaleX: 52/emptyCard.contentSize.width];
        [_toConfirm setTexture:[emptyCard texture]];
        _toConfirm = 0;
    }
    else{
        for (CCSprite* tile in _tilesArray){
            if(CGRectContainsPoint([tile boundingBox], point)){
                int index = [_tilesArray indexOfObject:tile];
                if([[[[Map currentMap] tiles] objectAtIndex:index] hasCard]){
                    NSLog(@"a card on map is clicked");
                    NSLog(@"%@",[[[[Map currentMap] tiles] objectAtIndex:index] card]);
                }
                
            }
        }
        
    }
    [self dragSelectedCard: point];
}

- (void) layerPanZoom: (CCLayerPanZoom *) sender
 touchPositionUpdated: (CGPoint) newPos
{
    NSLog(@"CCLayerPanZoomTestLayer#layerPanZoom: %@ touchPositionUpdated: { %f, %f }", sender, newPos.x, newPos.y);
    _selectedCard.position = newPos;
}

- (void) layerPanZoom: (CCLayerPanZoom *) sender touchMoveBeganAtPosition: (CGPoint) aPoint
{
    NSLog(@"CCLayerPanZoomTestLayer#layerPanZoom: %@ touchMoveBeganAtPosition: { %f, %f }", sender, aPoint.x, aPoint.y);
    [self dragSelectedCard: aPoint];
    
    // Change anchorPoint & position of selectedTestObject to avoid jerky movement.
    if (_selectedCard)
    {
        CGFloat width = _selectedCard.contentSize.width;
        CGFloat height = _selectedCard.contentSize.height;
        
        CGPoint aPointInTestObjectCoordinates = [ _selectedCard convertToNodeSpace: [_tutorialGameboard convertToWorldSpace: aPoint] ];
        CGPoint anchorPointInPoints = ccp( _selectedCard.anchorPoint.x * width,
                                          _selectedCard.anchorPoint.y * height );
        CGPoint anchorShift = ccpSub(anchorPointInPoints, aPointInTestObjectCoordinates );
        _selectedCard.anchorPoint = ccp( (anchorPointInPoints.x - anchorShift.x )/ width,
                                        (anchorPointInPoints.y - anchorShift.y) / height );
        _selectedCard.position = aPoint;
        
    }
}

-(void) layerPanZoom: (CCLayerPanZoom *) sender touchMoveEndAtPosition:(CGPoint) endPos
{
    NSLog(@"released finger at position %@  {%f,%f}",sender,endPos.x,endPos.y);
    if(_selectedCard != 0){
        if([self draggedToTile:endPos]!= -1){
            [[_tilesArray objectAtIndex: [self draggedToTile:endPos]] setTexture:[_selectedCard texture]];
            [[_tilesArray objectAtIndex:[self draggedToTile:endPos]] setVisible:YES];
            [_tutorialGameboard removeChildByTag:dragableTag cleanup:YES];
            _toConfirm = [_tilesArray objectAtIndex: [self draggedToTile:endPos]];
            [_toConfirm setColor:ccGRAY];
            _selectedCard = 0;
            
            [self setToSheetMode];
        }
    }
}

-(void) setToSheetMode
{
    _tutorialGameboard.mode = kCCLayerPanZoomModeSheet;
}
-(void) setToFrameMode
{
    _tutorialGameboard.mode = kCCLayerPanZoomModeFrame;
}
-(void) showSelected :(id) sender atPos:(CGPoint)pos
{
    [self setToFrameMode];
    NSLog(@"%@",sender);
    CCSprite *dragable = [CCSprite spriteWithTexture:[sender texture]];
    [dragable setScaleY: 72/dragable.contentSize.height];
    [dragable setScaleX: 52/dragable.contentSize.width];
    
    [_tutorialGameboard addChild : dragable
                                z: 6
                              tag:dragableTag
     ];
    CGRect boundingRect = CGRectMake(0, 0, 0, 0);
    CCNode *background = [_tutorialGameboard getChildByTag: gameBoardBackgroundTag];
	boundingRect.size = [background boundingBox].size;
	[_tutorialGameboard setContentSize: boundingRect.size];
  
    dragable.position = ccp(boundingRect.size.width * 0.5f, boundingRect.size.height * 0.5f);
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    _tutorialGameboard.position = ccp(0.5f * winSize.width, 0.5f * winSize.height);
    _tutorialGameboard.scale = 1.0f;
    
    

}

-(void) drawTiles{
    CGPoint initPos = ccp(25,10);
    
    for (id obj in [[Map currentMap] tiles]){
        CCSprite * card;
        if ([obj card] == 0){
            card = [CCSprite spriteWithFile:@"emptyTile.png"];
            [card setVisible:NO];
            
        }else{
            card = [obj card];
            
        }
        [card setScaleY: 72/card.contentSize.height];
        [card setScaleX: 52/card.contentSize.width];
        [card setAnchorPoint:CGPointZero];
        card.position = ccp(initPos.x + ([obj posX]-1) * [card boundingBox].size.width ,initPos.y + ([obj posY]-1) * [card boundingBox].size.height);
        [_tutorialGameboard addChild:card];
        [_tilesArray addObject:card];
    }
    /*
    CCNode *background = [_tutorialGameboard getChildByTag: gameBoardBackgroundTag];
    CGRect boundingRect = CGRectMake(0, 0, 0, 0);
	boundingRect.size = [background boundingBox].size;
    
    CCSprite *genericEmptyCard = [CCSprite spriteWithFile:@"emptyTile.png"];
    [genericEmptyCard setScaleY: 72/genericEmptyCard.contentSize.height];
    [genericEmptyCard setScaleX: 52/genericEmptyCard.contentSize.width];
    
    
    for(int i = 0; i < 9; i++){
        for (int i = 0; i < 22; i++){
            CCSprite *emptyCard = [CCSprite spriteWithFile:@"emptyTile.png"];
            [emptyCard setScaleY: 72/emptyCard.contentSize.height];
            [emptyCard setScaleX: 52/emptyCard.contentSize.width];
            [emptyCard setAnchorPoint:CGPointZero];
            emptyCard.position = ccp(initPos.x + i * [emptyCard boundingBox].size.width ,initPos.y );
            [_tutorialGameboard addChild:emptyCard];
            
        }
        initPos = ccp(initPos.x ,initPos.y + [genericEmptyCard boundingBox].size.height );
        
    }
     */
}

-(int) draggedToTile: (CGPoint) endPos{
    int rtn = -1;
    for(CCSprite *tile in _tilesArray){
        if(CGRectContainsPoint( [tile boundingBox], endPos)){
            rtn = [_tilesArray indexOfObject:tile];
        }
    }
    
    return rtn;
}

-(void) cleanSelected
{
    [_tutorialGameboard removeChildByTag:dragableTag cleanup:YES];
}

-(void) locateHomeAndTarget{
    [[[[Map currentMap] tiles] objectAtIndex:99] setCard:[[Map currentMap] home]];
    int distance;
    if([[Player currentPlayer] playerLevel] == 1){
        distance = 4;
    }
    NSMutableArray *targetList = [[[[Map currentMap] tiles] objectAtIndex:99] getArrayWithRadius:distance];
    int randomIndex = arc4random() % [targetList count];
    [[targetList objectAtIndex:randomIndex] setCard:[[Map currentMap] target]];
    [[targetList objectAtIndex:randomIndex] setIsTarget:YES];
        
    
}
-(int) indexToX: (int)index{
    return 1+(index % 22);
}

-(int) indexToY: (int)index{
    return 1+(index / 22);
}

-(int) toIndexPosX:(int)x posY:(int)y{
    return (y-1)*22+(x-1);
}
@end
