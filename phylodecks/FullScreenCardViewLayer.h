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
@interface FullScreenCardViewLayer : CCLayer <CCLayerPanZoomClickDelegate> {
    CCLayerPanZoom *_panZoomer;
}

-(id)initWithCard:(Card*)card;

@end
