//
//  GameBoardLayer.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCLayerPanZoom.h"

@interface GameBoardLayer : CCLayer <CCLayerPanZoomClickDelegate>{
    
    CCLayerPanZoom *_tutorialGameboard;
    CCSprite *_selectedCard;
    CCSprite *_toConfirm;
    NSMutableArray *_tilesArray;
    
}

-(void) updateForScreenReshape;
-(void) setToSheetMode;
-(void) setToFrameMode;
-(void) showSelected :(id)sender atPos:(CGPoint)pos;
-(void) drawTiles;

@end
