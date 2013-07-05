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

@interface InventorySelectionLayer : CCLayer <CCScrollLayerDelegate>{
    NSMutableArray * cardSprites;
    FMDatabase * db;
	BOOL databaseOpened;
}

- (void) updateForScreenReshape;


@end
