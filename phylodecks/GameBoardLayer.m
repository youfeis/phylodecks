//
//  GameBoardLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameBoardLayer.h"
#import "nodeTags.h"


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
        CCSprite *background = [CCSprite spriteWithFile: @"background.png"];
        background.anchorPoint = ccp(0,0);
		background.scale = CC_CONTENT_SCALE_FACTOR();
        [_tutorialGameboard addChild: background
                                  z :-1
                                 tag: gameBoardBackgroundTag];
        
        
        _tutorialGameboard.mode = kCCLayerPanZoomModeSheet;
        
        _tutorialGameboard.rubberEffectRatio = 0.1f;
        
        _tilesArray = [[NSMutableArray alloc] init];
        
    //    [self drawTiles: 4];
        
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
    _tutorialGameboard.maxScale =  15.0f *  winSize.width / [background boundingBox].size.width;
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
	NSLog(@"CCLayerPanZoomTestLayer#layerPanZoom: %@ clickedAtPoint: { %f, %f }", sender, point.x, point.y);
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
            [_tutorialGameboard removeChildByTag:dragableTag cleanup:YES];
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
-(void) showSelected :(id) sender
{
    
    CCSprite *dragable = [CCSprite spriteWithTexture:[[[sender children] objectAtIndex:0] texture]];
    [dragable setScaleY: 100/dragable.contentSize.height];
    [dragable setScaleX: 75/dragable.contentSize.width];
    
    [_tutorialGameboard addChild : dragable
                                z: 6
                              tag:dragableTag
     ];
    dragable.color = ccBLUE;
    CGRect boundingRect = CGRectMake(0, 0, 0, 0);
    CCNode *background = [_tutorialGameboard getChildByTag: gameBoardBackgroundTag];
	boundingRect.size = [background boundingBox].size;
	[_tutorialGameboard setContentSize: boundingRect.size];
    dragable.position = ccp(boundingRect.size.width * 0.5f, boundingRect.size.height * 0.5f - 56);
}

-(void) drawTiles:(int) dimension{
    CCNode *background = [_tutorialGameboard getChildByTag: gameBoardBackgroundTag];
    CGRect boundingRect = CGRectMake(0, 0, 0, 0);
	boundingRect.size = [background boundingBox].size;
    CGPoint initPos = ccp(boundingRect.size.width * 0.6f, boundingRect.size.height * 0.5f - 56);
    CCSprite *genericEmptyCard = [CCSprite spriteWithFile:@"emptyTile.png"];
    [genericEmptyCard setScaleY: 100/genericEmptyCard.contentSize.height];
    [genericEmptyCard setScaleX: 75/genericEmptyCard.contentSize.width];
    
    for(int i = 0; i < dimension; i++){
        for (int i = 0; i < dimension; i++){
            CCSprite *emptyCard = [CCSprite spriteWithFile:@"emptyTile.png"];
            [emptyCard setScaleY: 100/emptyCard.contentSize.height];
            [emptyCard setScaleX: 75/emptyCard.contentSize.width];
            emptyCard.position = ccp(initPos.x,initPos.y + i * [emptyCard boundingBox].size.height);
            [_tutorialGameboard addChild:emptyCard];
            [_tilesArray addObject:emptyCard];
        }
        initPos = ccp(initPos.x + [genericEmptyCard boundingBox].size.width,initPos.y);
        
    }
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
@end
