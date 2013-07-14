//
//  MapInventoryLayer.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-06.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCMenuAdvanced.h"

#import "Map.h"
#import "FullScreenCardViewLayer.h"

@interface MapInventoryLayer : CCLayer {
    
}


// Creates advice label (test description)
- (CCLabelTTF *) adviceLabel;

// Creates widget (can be anything you want, in Vertical Test it is a vertical menu).
- (CCNode *) widget;

// Creates reversed vertical menu.
- (CCNode *) widgetReversed;

// Updates layout of the children.
- (void) updateForScreenReshape;

// Updates position for node with tag kWidget (Used in updateForScreenReshape).
- (void) updateWidget;

- (void) reformatMenu;


@end
