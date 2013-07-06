//
//  InventorySelectionLayer.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCScrollLayer.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "Card.h"
#import "Player.h"
#import "Map.h"
#import "CCMenuAdvanced.h"
#import "ChallengeModeScene.h"

@interface InventorySelectionLayer : CCLayer <CCScrollLayerDelegate>{
    NSMutableArray * cardSprites;
    FMDatabase * db;
	BOOL databaseOpened;
}

@property (retain, readwrite) NSMutableArray * cardSprites;

- (void) updateForScreenReshape;
- (void) transitToChallengeModeScene;


@end
