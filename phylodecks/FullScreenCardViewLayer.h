//
//  FullScreenCardViewLayer.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-06.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCLayerPanZoom.h"
#import "Card.h"
#import "InventorySelectionLayer.h"
#import "ChallengeModeScene.h"

@interface FullScreenCardViewLayer : CCLayer <CCLayerPanZoomClickDelegate> {
    CCLayerPanZoom *_panZoomer;
    Card *_card;
}

-(id)initWithCard:(Card*)card;
-(void) handleLongPressFrom: (UILongPressGestureRecognizer*)recognizer;

@end
